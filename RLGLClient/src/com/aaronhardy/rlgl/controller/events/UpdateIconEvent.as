package com.aaronhardy.rlgl.controller.events
{
	import flash.events.Event;
	
	import mx.effects.easing.Back;
	
	public class UpdateIconEvent extends Event
	{
		public static const UPDATE_ICON:String = 'updateIcon';
		
		public var color:String;
		public var lastModifiedAlias:String;
		public var bounce:Boolean;
		
		public function UpdateIconEvent(type:String, color:String, lastModifiedAlias:String,
				bounce:Boolean)
		{
			super(type);
			this.color = color;
			this.lastModifiedAlias = lastModifiedAlias;
			this.bounce = bounce;
		}
		
		override public function clone():Event
		{
			return new UpdateIconEvent(type, color, lastModifiedAlias, bounce);
		}
	}
}