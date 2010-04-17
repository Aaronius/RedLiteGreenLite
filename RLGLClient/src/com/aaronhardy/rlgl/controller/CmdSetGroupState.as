package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
	import com.aaronhardy.rlgl.service.groupMessaging.IGroupMessagingService;
	
	import org.robotlegs.mvcs.Command;

	public class CmdSetGroupState extends Command
	{
		[Inject]
		public var service:IGroupMessagingService;
		
		[Inject]
		public var event:SetGroupStateEvent;
		
		override public function execute():void
		{
			service.updateColor(event.group, event.alias, event.color);
		}
	}
}