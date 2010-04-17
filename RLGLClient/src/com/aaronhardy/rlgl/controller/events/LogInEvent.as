package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;

	public class LogInEvent extends Event
	{
		public static const LOG_IN:String = 'logIn';
		
		public var group:String;
		public var alias:String;
		
		public function LogInEvent(type:String, group:String, alias:String)
		{
			super(type);
			this.group = group;
			this.alias = alias;
		}
		
		override public function clone():Event
		{
			return new LogInEvent(type, group, alias);
		}
	}
}