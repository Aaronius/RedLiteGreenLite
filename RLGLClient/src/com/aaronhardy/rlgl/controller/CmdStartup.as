package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.CheckForUpdateEvent;
	import com.aaronhardy.rlgl.controller.events.UpdateIconEvent;
	import com.aaronhardy.rlgl.enums.Color;
	
	import org.robotlegs.mvcs.Command;
	
	public class CmdStartup extends Command
	{
		override public function execute():void
		{
			dispatch(new CheckForUpdateEvent(CheckForUpdateEvent.CHECK_FOR_UPDATE));
			dispatch(new UpdateIconEvent(UpdateIconEvent.UPDATE_ICON, Color.BLACK, null, false));
		}
	}
}