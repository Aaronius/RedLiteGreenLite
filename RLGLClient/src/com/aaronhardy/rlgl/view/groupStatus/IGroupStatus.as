package com.aaronhardy.rlgl.view.groupStatus
{
	import flash.events.IEventDispatcher;

	public interface IGroupStatus extends IEventDispatcher
	{
		function set group(value:String):void;
		function set alias(value:String):void;
		function set status(value:String):void;
		function set lastModifiedAlias(value:String):void;
		function set appVersion(value:String):void
	}
}