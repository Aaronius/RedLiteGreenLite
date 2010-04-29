package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.ShowToastEvent;
	import com.aaronhardy.rlgl.controller.events.UpdateIconEvent;
	import com.aaronhardy.rlgl.enums.Color;
	import com.aaronhardy.rlgl.model.GroupModel;
	import com.aaronhardy.rlgl.model.MenuModel;
	
	import flash.desktop.DockIcon;
	import flash.desktop.InteractiveIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.WindowedApplication;

	public class CmdHandleGroupState extends Command
	{
		[Inject]
		public var groupModel:GroupModel;
		
		[Inject]
		public var event:HandleGroupStateEvent;
		
		override public function execute():void
		{
			if (groupModel.loggingIn)
			{
				groupModel.loggingIn = false;
				groupModel.group = groupModel.loggingInGroup;
				groupModel.alias = groupModel.loggingInAlias;
				groupModel.loggingInGroup = null;
				groupModel.loggingInAlias = null;
			}
			
			groupModel.status = event.color;
			groupModel.lastModifiedAlias = event.lastModifiedAlias;
			dispatch(new UpdateIconEvent(UpdateIconEvent.UPDATE_ICON, event.color,  
				event.lastModifiedAlias, true));
			dispatch(new ShowToastEvent(ShowToastEvent.SHOW_TOAST));
		}
	}
}