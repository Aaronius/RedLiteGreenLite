package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;

	public class ShowToastEvent extends Event
	{
		public static const SHOW_TOAST:String = 'showToast';
		
		public function ShowToastEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new ShowToastEvent(type);
		}
	}
}