package com.aaronhardy.rlgl
{
	
	import com.aaronhardy.rlgl.events.GroupEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	[Event(name="colorRetrieved", type="com.aaronhardy.rlgl.events.GroupEvent")]
	public class CmdGetColorForGroup extends EventDispatcher
	{
		public function execute(groupName:String):void
		{
			var cs:ChannelSet = new ChannelSet();
			var channel:Channel = new AMFChannel(
					Config.REMOTING_CHANNEL_ID, Config.REMOTING_CHANNEL_URI);
			cs.addChannel(channel);
			
			var remoteObject:RemoteObject = new RemoteObject();
			remoteObject.channelSet = cs;
			remoteObject.destination = Config.REMOTING_DESTINATION;
			remoteObject.addEventListener(ResultEvent.RESULT, resultHandler);
			remoteObject.addEventListener(FaultEvent.FAULT, faultHandler);
			remoteObject.getColorForGroup(groupName);
		}
		
		protected function resultHandler(event:ResultEvent):void
		{
			var color:String = String(event.message.body.color);
			var lastModifiedAlias:String = String(event.message.body.lastModifiedAlias);
			dispatchEvent(new GroupEvent(GroupEvent.COLOR_RETRIEVED, color, lastModifiedAlias));
		}
		
		protected function faultHandler(event:ResultEvent):void
		{
			// TODO handle fault
		}
	}
}