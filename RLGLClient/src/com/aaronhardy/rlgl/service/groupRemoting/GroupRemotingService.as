package com.aaronhardy.rlgl.service.groupRemoting
{
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.model.Config;
	import com.aaronhardy.rlgl.model.GroupModel;
	
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.robotlegs.mvcs.Actor;

	public class GroupRemotingService extends Actor implements IGroupRemotingService
	{
		[Inject]
		public var groupModel:GroupModel;
		
		[Inject]
		public var config:Config;
		
		protected var remoteObject:RemoteObject;
		
		public function getState(group:String):void
		{
			if (!remoteObject)
			{
				var cs:ChannelSet = new ChannelSet();
				var channel:Channel = new AMFChannel(
						config.REMOTING_CHANNEL_ID, config.REMOTING_CHANNEL_URI);
				cs.addChannel(channel);
				remoteObject = new RemoteObject();
				remoteObject.channelSet = cs;
				remoteObject.destination = config.REMOTING_DESTINATION;
				remoteObject.addEventListener(ResultEvent.RESULT, resultHandler);
				remoteObject.addEventListener(FaultEvent.FAULT, faultHandler);
			}
			
			groupModel.loggingIn = true;
			remoteObject.getColorForGroup(group);
		}
		
		protected function resultHandler(event:ResultEvent):void
		{
			var color:String = String(event.message.body.color);
			var lastModifiedAlias:String = String(event.message.body.lastModifiedAlias);
			dispatch(new HandleGroupStateEvent(
					HandleGroupStateEvent.HANDLE_GROUP_STATE, color, lastModifiedAlias));
		}
		
		protected function faultHandler(event:ResultEvent):void
		{
			// TODO handle fault
		}
	}
}