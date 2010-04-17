package com.aaronhardy.rlgl.service.groupMessaging
{
	public interface IGroupMessagingService
	{
		function initialize(group:String):void;
		function updateColor(group:String, alias:String, color:String):void;
	}
}