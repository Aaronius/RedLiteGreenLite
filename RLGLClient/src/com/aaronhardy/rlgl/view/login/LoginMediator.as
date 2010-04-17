package com.aaronhardy.rlgl.view.login
{
	import com.aaronhardy.rlgl.controller.events.LogInEvent;
	import com.aaronhardy.rlgl.model.events.GroupModelEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class LoginMediator extends Mediator
	{
		[Inject]
		public var login:ILogin;
		
		override public function onRegister():void
		{
			eventMap.mapListener(
					login, 
					LogInEvent.LOG_IN, 
					view_logInHandler);
			eventMap.mapListener(
					eventDispatcher, 
					GroupModelEvent.LOGGING_IN, 
					model_loggingInHandler);
			eventMap.mapListener(
					eventDispatcher,
					GroupModelEvent.LOGIN_COMPLETE,
					model_loginCompleteHandler);
		}
		
		protected function view_logInHandler(event:LogInEvent):void
		{
			dispatch(event);
		}
		
		protected function model_loggingInHandler(event:GroupModelEvent):void
		{
			login.loggingIn = true;
		}
		
		protected function model_loginCompleteHandler(event:GroupModelEvent):void
		{
			login.loggingIn = false;
		}
	}
}