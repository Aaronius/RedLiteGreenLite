package com.aaronhardy.rlgl.events
{
	import flash.events.Event;

	public class GroupEvent extends Event
	{
		public static const COLOR_RETRIEVED:String = 'colorRetrieved';
		public var color:String;
		public var lastModifiedAlias:String;
		
		public function GroupEvent(type:String, color:String, lastModifiedAlias:String)
		{
			super(type, bubbles, cancelable);
			this.color = color;
			this.lastModifiedAlias = lastModifiedAlias;
		}
		
		override public function clone():Event
		{
			return new GroupEvent(type, color, lastModifiedAlias);
		} 
		
	}
}