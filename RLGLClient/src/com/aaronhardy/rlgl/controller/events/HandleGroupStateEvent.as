package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;

	public class HandleGroupStateEvent extends Event
	{
		public static const HANDLE_GROUP_STATE:String = 'handleGroupState';
		
		public var color:String;
		public var lastModifiedAlias:String;
		
		public function HandleGroupStateEvent(type:String, color:String, lastModifiedAlias:String)
		{
			super(type);
			
			this.color = color;
			this.lastModifiedAlias = lastModifiedAlias;
		}
		
		override public function clone():Event
		{
			return new HandleGroupStateEvent(HANDLE_GROUP_STATE, color, lastModifiedAlias);
		}
	}
}