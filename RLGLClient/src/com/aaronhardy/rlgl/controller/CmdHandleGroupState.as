package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.ShowToastEvent;
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
		[Embed('assets/green16.png')]
		protected var GreenIcon16:Class;
		
		[Embed('assets/red16.png')]
		protected var RedIcon16:Class;
		
		[Embed('assets/green32.png')]
		protected var GreenIcon32:Class;
		
		[Embed('assets/red32.png')]
		protected var RedIcon32:Class;
		
		[Embed('assets/green48.png')]
		protected var GreenIcon48:Class;
		
		[Embed('assets/red48.png')]
		protected var RedIcon48:Class;
		
		[Embed('assets/green128.png')]
		protected var GreenIcon128:Class;
		
		[Embed('assets/red128.png')]
		protected var RedIcon128:Class;
		
		[Embed('assets/green256.png')]
		protected var GreenIcon256:Class;
		
		[Embed('assets/red256.png')]
		protected var RedIcon256:Class;
		
		[Inject]
		public var groupModel:GroupModel;
		
		[Inject]
		public var menuModel:MenuModel;
		
		[Inject]
		public var event:HandleGroupStateEvent;
		
		override public function execute():void
		{
			groupModel.status = event.color;
			groupModel.lastModifiedAlias = event.lastModifiedAlias;
			updateIcon(event.color, event.lastModifiedAlias);
			updateMenu(event.color);
			dispatch(new ShowToastEvent(ShowToastEvent.SHOW_TOAST));
		}
		
		protected function updateIcon(color:String, lastModifiedAlias:String):void
		{
			var app:WindowedApplication = WindowedApplication(FlexGlobals.topLevelApplication);
			var icon:InteractiveIcon = app.nativeApplication.icon;
			switch (color)
			{
				case Color.GREEN:
					icon.bitmaps = [
							new GreenIcon16(), 
							new GreenIcon32(), 
							new GreenIcon48(),
							new GreenIcon128(),
							new GreenIcon256()];
					break;
				case Color.RED:
					icon.bitmaps = [
							new RedIcon16(), 
							new RedIcon32(), 
							new RedIcon48(),
							new RedIcon128(),
							new RedIcon256()];
					break;
			}
			
			if (NativeApplication.supportsDockIcon)
			{
				var dockIcon:DockIcon = DockIcon(icon);
				dockIcon.bounce();
			}
			if (NativeApplication.supportsSystemTrayIcon)
			{
				var trayIcon:SystemTrayIcon = SystemTrayIcon(icon);
				trayIcon.tooltip = 'Last modified by ' + lastModifiedAlias;
			}
		}
		
		protected function updateMenu(color:String):void
		{
			if (!menuModel.menu)
			{
				createMenu();
			}
			
			var toggleLabel:String;
			switch (color)
			{
				case Color.GREEN:
					toggleLabel = 'Go red!';
					break;
				case Color.RED:
					toggleLabel = 'Go green!';
					break;
			}
			
			menuModel.toggleStatusMenuItem.label = toggleLabel; 
		}
		
		protected function createMenu():void
		{
			var menu:NativeMenu = new NativeMenu();
			
			var toggleFunction:Function = function(event:Event):void
			{
				var newStatus:String = groupModel.status == Color.GREEN ? Color.RED : Color.GREEN;
				dispatch(new SetGroupStateEvent(SetGroupStateEvent.SET_GROUP_STATE,
						groupModel.group, groupModel.alias, newStatus));
			}
			
			var toggleStatusMenuItem:NativeMenuItem = new NativeMenuItem();
			toggleStatusMenuItem.addEventListener(Event.SELECT, toggleFunction);
			menu.addItem(toggleStatusMenuItem);
			
			var exitFunction:Function = function(event:Event):void
			{
				NativeApplication.nativeApplication.exit();
			}
			
			var exitMenuItem:NativeMenuItem = new NativeMenuItem();
			exitMenuItem.label = 'Exit';
			exitMenuItem.addEventListener(Event.SELECT, exitFunction);
			menu.addItem(exitMenuItem);
			
			var app:WindowedApplication = WindowedApplication(FlexGlobals.topLevelApplication);
			var icon:Object = app.nativeApplication.icon;
			icon.menu = menu;
			
			menuModel.menu = menu;
			menuModel.toggleStatusMenuItem = toggleStatusMenuItem;
			menuModel.exitMenuItem = exitMenuItem;
		}
	}
}