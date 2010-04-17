package com.aaronhardy.rlgl
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class CmdCheckForUpdate extends EventDispatcher
	{
		protected var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function execute():void
		{
			appUpdater.updateURL = 'http://aaronhardy.com/rlgl/update.xml';
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, initHandler);
			appUpdater.addEventListener(ErrorEvent.ERROR, errorHandler);
			appUpdater.initialize();
		}
		
		protected function initHandler(event:UpdateEvent):void
		{
			appUpdater.checkNow();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function errorHandler(event:ErrorEvent):void
		{
			trace('There was an error initializing the application updater.');
			dispatchEvent(new Event(Event.COMPLETE));
		}

	}
}