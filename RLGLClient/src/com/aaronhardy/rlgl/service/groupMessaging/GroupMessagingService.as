package com.aaronhardy.rlgl.service.groupMessaging
{
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.model.Config;
	
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.Producer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.IMessage;
	
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
			var channel:Channel = new AMFChannel(
					config.MESSAGE_CHANNEL_ID, config.MESSAGE_CHANNEL_URI);
			channelSet.addChannel(channel);
			
			if (consumer)
			{
				consumer.unsubscribe();
				consumer.removeEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
			}

			consumer = new Consumer();
			consumer.destination = config.MESSAGE_DESTINATION;
			consumer.addEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
			consumer.channelSet = channelSet;
			consumer.subtopic = config.MESSAGE_DESTINATION + 
					config.MESSAGE_SUBTOPIC_DELIMITER + group;
			consumer.subscribe();

			producer = new Producer();
			producer.destination = config.MESSAGE_DESTINATION;
			producer.channelSet = channelSet;
			producer.subtopic = config.MESSAGE_DESTINATION + 
					config.MESSAGE_SUBTOPIC_DELIMITER + group;
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