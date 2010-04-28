package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.controller.events.GetGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.LogInEvent;
	import com.aaronhardy.rlgl.model.GroupModel;
	import com.aaronhardy.rlgl.service.groupMessaging.IGroupMessagingService;
	
	import org.robotlegs.mvcs.Command;

	public class CmdLogIn extends Command
	{
		[Inject]
		public var event:LogInEvent;
		
		[Inject]
		public var groupModel:GroupModel;
		
		[Inject]
		public var groupMessagingService:IGroupMessagingService;
		
		override public function execute():void
		{
			dispatch(new GetGroupStateEvent(GetGroupStateEvent.GET_STATE, event.group));
			
			// FIXME: Above we just kicked of a call to get the group's initial state.
			// Below we're setting up the messaging producer/consumer.  What happens
			// if a consumer messages comes through before the initial group state
			// is retrieved?
			// What happens if the get-group-state call fails?  We're stuck with group
			// on the model even though we're not really logged into the group.
			groupMessagingService.initialize(event.group);
			groupModel.loggingInGroup = event.group;
			groupModel.loggingInAlias = event.alias;
		}
	}
}