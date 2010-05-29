package com.aaronhardy.rlgl.service.groupMessaging
{
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.model.Config;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.Producer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.IMessage;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Actor;

	public class GroupMessagingService extends Actor implements IGroupMessagingService
	{
		[Inject]
		public var config:Config;
		
		protected var channelSet:ChannelSet;
		protected var consumer:Consumer;
		protected var producer:Producer;
		
		public function initialize(group:String):void
		{
			// Do we have to completely destroy the old consumer
			// and producer each time or can we just subscribe/publish
			// to a different subtopic.
			// Initial tests show it's not very predictable when re-using
			// the consumer/producer.
			
			channelSet = new ChannelSet();
			
			// Google Apps Engine does not support streaming or long-polling so we're stuck
			// with short-polling for now.
			
//			var streamChannel:Channel = new AMFChannel(
//					config.STREAM_MESSAGE_CHANNEL_ID, 
//					config.STREAM_MESSAGE_CHANNEL_URI);
//			channelSet.addChannel(streamChannel);
			
//			var longPollChannel:Channel = new AMFChannel(
//				config.LONG_POLL_MESSAGE_CHANNEL_ID, 
//				config.LONG_POLL_MESSAGE_CHANNEL_URI);
//			channelSet.addChannel(longPollChannel);
			
			var shortPollChannel:Channel = new AMFChannel(
					config.SHORT_POLL_MESSAGE_CHANNEL_ID, 
					config.SHORT_POLL_MESSAGE_CHANNEL_URI);
			channelSet.addChannel(shortPollChannel);
			
			if (consumer)
			{
				consumer.unsubscribe();
				consumer.removeEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
			}

			consumer = new Consumer();
			consumer.destination = config.MESSAGE_DESTINATION;
			consumer.addEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
			consumer.addEventListener(MessageFaultEvent.FAULT, faultHandler);
			consumer.channelSet = channelSet;
			consumer.subtopic = config.MESSAGE_DESTINATION + 
					config.MESSAGE_SUBTOPIC_DELIMITER + group;
			consumer.subscribe();

			producer = new Producer();
			producer.addEventListener(MessageFaultEvent.FAULT, faultHandler);
			producer.addEventListener(ChannelFaultEvent.FAULT, faultHandler);
			producer.destination = config.MESSAGE_DESTINATION;
			producer.channelSet = channelSet;
			producer.subtopic = config.MESSAGE_DESTINATION + 
					config.MESSAGE_SUBTOPIC_DELIMITER + group;
		}
		
		private function faultHandler(event:Object):void
		{
			trace('fault', event.faultDetail, event.faultString, event.faultCode);
		}
		
		protected function consumer_messageHandler(event:MessageEvent):void
		{
			dispatch(new HandleGroupStateEvent(
					HandleGroupStateEvent.HANDLE_GROUP_STATE,
					event.message.body.color,
					event.message.body.alias));
		}
		
		public function updateColor(group:String, alias:String, color:String):void
		{
			var message:IMessage = new AsyncMessage();
			message.body.group = group;
			message.body.alias = alias;
			message.body.color = color;
			producer.send(message);
		}
	}
}