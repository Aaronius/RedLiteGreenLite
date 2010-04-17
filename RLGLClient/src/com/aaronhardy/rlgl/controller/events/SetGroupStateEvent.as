package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;

	public class SetGroupStateEvent extends Event
	{
		public static const SET_GROUP_STATE:String = 'setGroupState';
		
		public var group:String;
		public var alias:String;
		public var color:String;
		
		public function SetGroupStateEvent(type:String, group:String, alias:String, color:String)
		{
			super(type);
			this.group = group;
			this.alias = alias;
			this.color = color;
		}
		
		override public function clone():Event
		{
			return new SetGroupStateEvent(type, group, alias, color);
		}
		
	}
}