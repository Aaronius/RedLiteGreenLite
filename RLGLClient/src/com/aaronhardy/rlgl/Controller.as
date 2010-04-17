package com.aaronhardy.rlgl
{
	import com.aaronhardy.rlgl.events.GroupEvent;
	
	import flash.desktop.DockIcon;
	import flash.desktop.InteractiveIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.Application;
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.Producer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.IMessage;
	
	public class Controller
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
		
		protected var channelSet:ChannelSet;
		protected var consumer:Consumer;
		protected var producer:Producer;
		
		protected var group:String;
		protected var alias:String;
		
		[Bindable]
		public var lastModifiedAlias:String;
		
		[Bindable]
		public var color:String;
		
		[Bindable]
		public var retrievingGroupInfo:Boolean = false;
		
		public function init(alias:String, group:String):void
		{
			this.group = group;
			this.alias = alias;
			
			retrievingGroupInfo = true;
			var cmdGetColor:CmdGetColorForGroup = new CmdGetColorForGroup();
			cmdGetColor.addEventListener(GroupEvent.COLOR_RETRIEVED, colorRetrievedHandler);
			cmdGetColor.execute(group);
			
			consumer = new Consumer();
			consumer.destination = Config.MESSAGE_DESTINATION;
			consumer.addEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
			
			producer = new Producer();
			producer.destination = Config.MESSAGE_DESTINATION;
			
			var cs:ChannelSet = new ChannelSet();
			var channel:Channel = new AMFChannel(
					Config.MESSAGE_CHANNEL_ID, Config.MESSAGE_CHANNEL_URI);
			cs.addChannel(channel);
			consumer.subtopic = Config.MESSAGE_DESTINATION + 
					Config.MESSAGE_SUBTOPIC_DELIMITER + group;
			consumer.channelSet = cs;
			producer.subtopic = Config.MESSAGE_DESTINATION + 
					Config.MESSAGE_SUBTOPIC_DELIMITER + group;
			producer.channelSet = cs;
			consumer.subscribe();
		}
		
		protected function updateIcon(lastModifiedAlias:String):void
		{
			var icon:InteractiveIcon = Application.application.nativeApplication.icon;
			switch (color)
			{
				case Config.GREEN:
					icon.bitmaps = [
							new GreenIcon16(), 
							new GreenIcon32(), 
							new GreenIcon48(),
							new GreenIcon128(),
							new GreenIcon256()];
					break;
				case Config.RED:
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
		
		protected var menu:NativeMenu;
		protected var toggleMenuItem:NativeMenuItem;
		protected var exitMenuItem:NativeMenuItem;
		
		protected function updateMenu(color:String):void
		{
			if (!menu)
			{
				createMenu();
			}
			
			var toggleLabel:String;
			switch (color)
			{
				case Config.GREEN:
					toggleLabel = 'Go red!';
					break;
				case Config.RED:
					toggleLabel = 'Go green!';
					break;
			}
			
			toggleMenuItem.label = toggleLabel; 
		}
		
		protected function createMenu():void
		{
			menu = new NativeMenu();
			
			toggleMenuItem = new NativeMenuItem();
			toggleMenuItem.addEventListener(Event.SELECT, toggleMenuItem_selectHandler);
			menu.addItem(toggleMenuItem);
			
			exitMenuItem = new NativeMenuItem();
			exitMenuItem.label = 'Exit';
			exitMenuItem.addEventListener(Event.SELECT, exitMenuItem_selectHandler);
			menu.addItem(exitMenuItem);
			
			Application.application.nativeApplication.icon.menu = menu;
		}
		
		protected function updateRemote(color:String):void
		{
			var message:IMessage = new AsyncMessage();
			message.body.group = group;
			message.body.alias = alias;
			message.body.color = color;
			producer.send(message);
		}
		
		protected function updateLocal(color:String, lastModifiedAlias:String):void
		{
			if (color != Config.GREEN && color != Config.RED)
			{
				throw new Error('Invalid color.');
			}
			
			this.color = color;
			this.lastModifiedAlias = lastModifiedAlias;
			updateIcon(lastModifiedAlias);
			updateMenu(color);
		}
		
		protected function consumer_messageHandler(event:MessageEvent):void
		{
			updateLocal(
					event.message.body.color,
					event.message.body.alias);
		}
		
		protected function toggleMenuItem_selectHandler(event:Event):void
		{
			updateRemote(color == Config.GREEN ? Config.RED : Config.GREEN);
		}
		
		protected function exitMenuItem_selectHandler(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		protected function colorRetrievedHandler(event:GroupEvent):void
		{
			IEventDispatcher(event.target).removeEventListener(
					GroupEvent.COLOR_RETRIEVED, colorRetrievedHandler);
			
			retrievingGroupInfo = false;
			updateLocal(event.color, event.lastModifiedAlias);
		}
		
		protected var cmdCheckForUpdate:CmdCheckForUpdate;
		
		public function checkForUpdates():void
		{
			cmdCheckForUpdate = new CmdCheckForUpdate();
			cmdCheckForUpdate.execute();
			cmdCheckForUpdate.addEventListener(Event.COMPLETE, checkForUpdatesCompleteHandler);
		}
		
		protected function checkForUpdatesCompleteHandler(event:Event):void
		{
			cmdCheckForUpdate.removeEventListener(Event.COMPLETE, checkForUpdatesCompleteHandler);
			cmdCheckForUpdate = null;
		}
	}
}