package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;

	public class GetGroupStateEvent extends Event
	{
		public static const GET_STATE:String = 'getState';
		
		public var group:String;
		
		public function GetGroupStateEvent(type:String, group:String)
		{
			super(type, bubbles, cancelable);
			this.group = group;
		}
		
		override public function clone():Event
		{
			return new GetGroupStateEvent(type, group);
		}
		
	}
}