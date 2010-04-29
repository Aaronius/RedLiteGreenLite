package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;
	
	public class CheckForUpdateEvent extends Event
	{
		public static const CHECK_FOR_UPDATE:String = 'checkForUpdate';
		
		public function CheckForUpdateEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new CheckForUpdateEvent(type);
		}
	}
}