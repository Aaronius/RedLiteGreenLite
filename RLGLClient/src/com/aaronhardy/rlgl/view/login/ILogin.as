package com.aaronhardy.rlgl.view.login
{
	import flash.events.IEventDispatcher;
	
	public interface ILogin extends IEventDispatcher
	{
		function set loggingIn(value:Boolean):void;
	}
}