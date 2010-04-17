package com.aaronhardy.rlgl.model.events
{
	import flash.events.Event;

	public class GroupModelEvent extends Event
	{
		public static const ALIAS_CHANGED:String = 'aliasChanged';
		public static const STATUS_CHANGED:String = 'statusChanged';
		public static const GROUP_CHANGED:String = 'groupChanged';
		public static const LAST_MODIFIED_ALIAS_CHANGED:String = 'lastModifiedAliasChanged';
		public static const LOGGING_IN:String = 'loggingIn';
		public static const LOGIN_COMPLETE:String = 'loginComplete';
		
		public function GroupModelEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new GroupModelEvent(type);
		}
		
	}
}