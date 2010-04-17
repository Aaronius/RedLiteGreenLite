package com.aaronhardy.rlgl.controller
{
	
	import com.aaronhardy.rlgl.controller.events.GetGroupStateEvent;
	import com.aaronhardy.rlgl.service.groupRemoting.IGroupRemotingService;
	
	import org.robotlegs.mvcs.Command;
	
	[Event(name="colorRetrieved", type="com.aaronhardy.rlgl.events.GroupEvent")]
	public class CmdGetGroupState extends Command
	{
		[Inject]
		public var event:GetGroupStateEvent;
		
		[Inject]
		public var groupService:IGroupRemotingService;
		
		override public function execute():void
		{
			groupService.getState(event.group);
		}
	}
}