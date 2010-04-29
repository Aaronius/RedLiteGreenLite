package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
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
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.WindowedApplication;
	
	public class CmdUpdateIcon extends Command
	{
		[Embed('assets/green16.png')]
		protected var GreenIcon16:Class;
		
		[Embed('assets/red16.png')]
		protected var RedIcon16:Class;
		
		[Embed('assets/black16.png')]
		protected var BlackIcon16:Class;
		
		[Embed('assets/green32.png')]
		protected var GreenIcon32:Class;
		
		[Embed('assets/red32.png')]
		protected var RedIcon32:Class;
		
		[Embed('assets/black32.png')]
		protected var BlackIcon32:Class;
		
		[Embed('assets/green48.png')]
		protected var GreenIcon48:Class;
		
		[Embed('assets/red48.png')]
		protected var RedIcon48:Class;
		
		[Embed('assets/black48.png')]
		protected var BlackIcon48:Class;
		
		[Embed('assets/green128.png')]
		protected var GreenIcon128:Class;
		
		[Embed('assets/red128.png')]
		protected var RedIcon128:Class;
		
		[Embed('assets/black128.png')]
		protected var BlackIcon128:Class;
		
		[Embed('assets/green256.png')]
		protected var GreenIcon256:Class;
		
		[Embed('assets/red256.png')]
		protected var RedIcon256:Class;
		
		[Embed('assets/black256.png')]
		protected var BlackIcon256:Class;
		
		[Inject]
		public var event:UpdateIconEvent;
		
		[Inject]
		public var menuModel:MenuModel;

		[Inject]
		public var groupModel:GroupModel;
		
		override public function execute():void
		{
			var app:WindowedApplication = WindowedApplication(FlexGlobals.topLevelApplication);
			var icon:InteractiveIcon = app.nativeApplication.icon;
			
			switch (event.color)
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
				case Color.BLACK:
					icon.bitmaps = [
						new BlackIcon16(),
						new BlackIcon32(),
						new BlackIcon48(),
						new BlackIcon128(),
						new BlackIcon256()];
			}
			
			if (event.bounce && NativeApplication.supportsDockIcon)
			{
				var dockIcon:DockIcon = DockIcon(icon);
				dockIcon.bounce();
			}
			
			if (NativeApplication.supportsSystemTrayIcon)
			{
				var trayIcon:SystemTrayIcon = SystemTrayIcon(icon);
				trayIcon.tooltip = event.lastModifiedAlias ? 
						'Last modified by ' + event.lastModifiedAlias :
						'';
			}
			
			updateMenu(event.color);
		}
		
		protected function updateMenu(color:String):void
		{
			if (!menuModel.menu)
			{
				createMenu();
			}
			
			if (color == Color.BLACK)
			{
				if (menuModel.menu.containsItem(menuModel.toggleStatusMenuItem))
				{
					menuModel.menu.removeItem(menuModel.toggleStatusMenuItem);
				}
			}
			else
			{
				if (!menuModel.menu.containsItem(menuModel.toggleStatusMenuItem))
				{
					menuModel.menu.addItemAt(menuModel.toggleStatusMenuItem, 0);
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
			
			// We don't add this menu item to the menu yet because it will be added/removed
			// as needed.
			var toggleStatusMenuItem:NativeMenuItem = new NativeMenuItem();
			toggleStatusMenuItem.addEventListener(Event.SELECT, toggleFunction);
			
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