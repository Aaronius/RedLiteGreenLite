package com.aaronhardy.rlgl.controller
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import org.robotlegs.extensions.mvcs.AsyncCommand;
	
	public class CmdCheckForUpdate extends AsyncCommand
	{
		protected var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		override public function execute():void
		{
			appUpdater.updateURL = 'http://aaronhardy.com/rlgl/update.xml';
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, initHandler);
			appUpdater.initialize();
		}
		
		protected function initHandler(event:UpdateEvent):void
		{
			appUpdater.checkNow();
			// TODO: figure out when we're done.
		}
	}
}