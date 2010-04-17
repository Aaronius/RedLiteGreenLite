package com.aaronhardy.rlgl
{
	import com.aaronhardy.rlgl.controller.CmdCheckForUpdate;
	import com.aaronhardy.rlgl.controller.CmdGetGroupState;
	import com.aaronhardy.rlgl.controller.CmdHandleGroupState;
	import com.aaronhardy.rlgl.controller.CmdLogIn;
	import com.aaronhardy.rlgl.controller.CmdSetGroupState;
	import com.aaronhardy.rlgl.controller.events.GetGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.HandleGroupStateEvent;
	import com.aaronhardy.rlgl.controller.events.LogInEvent;
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
	import com.aaronhardy.rlgl.model.Config;
	import com.aaronhardy.rlgl.model.GroupModel;
	import com.aaronhardy.rlgl.model.MenuModel;
	import com.aaronhardy.rlgl.service.groupMessaging.GroupMessagingService;
	import com.aaronhardy.rlgl.service.groupMessaging.IGroupMessagingService;
	import com.aaronhardy.rlgl.service.groupRemoting.GroupRemotingService;
	import com.aaronhardy.rlgl.service.groupRemoting.IGroupRemotingService;
	import com.aaronhardy.rlgl.view.groupStatus.GroupStatus;
	import com.aaronhardy.rlgl.view.groupStatus.GroupStatusMediator;
	import com.aaronhardy.rlgl.view.groupStatus.IGroupStatus;
	import com.aaronhardy.rlgl.view.login.ILogin;
	import com.aaronhardy.rlgl.view.login.Login;
	import com.aaronhardy.rlgl.view.login.LoginMediator;
	
	import org.robotlegs.mvcs.Context;

	public class ApplicationContext extends Context
	{
		override public function startup():void
		{
			var checkForUpdate:CmdCheckForUpdate = new CmdCheckForUpdate();
			checkForUpdate.execute();
			
			injector.mapSingleton(Config);
			injector.mapSingleton(GroupModel);
			injector.mapSingleton(MenuModel);
			injector.mapSingletonOf(IGroupRemotingService, GroupRemotingService);
			injector.mapSingletonOf(IGroupMessagingService, GroupMessagingService);
			
			commandMap.mapEvent(LogInEvent.LOG_IN, CmdLogIn, LogInEvent);
			commandMap.mapEvent(GetGroupStateEvent.GET_STATE, CmdGetGroupState, GetGroupStateEvent);
			commandMap.mapEvent(HandleGroupStateEvent.HANDLE_GROUP_STATE, CmdHandleGroupState, HandleGroupStateEvent);
			commandMap.mapEvent(SetGroupStateEvent.SET_GROUP_STATE, CmdSetGroupState, SetGroupStateEvent);
			
			mediatorMap.mapView(GroupStatus, GroupStatusMediator, IGroupStatus);
			mediatorMap.mapView(Login, LoginMediator, ILogin);
			
			super.startup();
		}
			
	}
}