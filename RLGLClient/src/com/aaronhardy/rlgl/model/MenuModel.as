package com.aaronhardy.rlgl.model
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	
	import org.robotlegs.mvcs.Actor;

	public class MenuModel extends Actor
	{
		public var menu:NativeMenu;
		public var toggleStatusMenuItem:NativeMenuItem;
		public var exitMenuItem:NativeMenuItem;
	}
}