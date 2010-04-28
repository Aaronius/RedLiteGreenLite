package com.aaronhardy.rlgl.view.groupStatus
{
	import com.aaronhardy.rlgl.controller.events.SetGroupStateEvent;
	import com.aaronhardy.rlgl.model.GroupModel;
	import com.aaronhardy.rlgl.model.events.GroupModelEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	public class GroupStatusMediator extends Mediator
	{
		[Inject]
		public var groupStatus:IGroupStatus;
		
		[Inject]
		public var groupModel:GroupModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(
					eventDispatcher,
					GroupModelEvent.GROUP_CHANGED,
					model_groupChangedHandler);
			setGroup();
			
			eventMap.mapListener(
					eventDispatcher,
					GroupModelEvent.ALIAS_CHANGED,
					model_aliasChangedHandler);
			setAlias();
			
			eventMap.mapListener(
					eventDispatcher, 
					GroupModelEvent.STATUS_CHANGED, 
					model_statusChangedHandler);
			setStatus();
			
			eventMap.mapListener(
					eventDispatcher, 
					GroupModelEvent.LAST_MODIFIED_ALIAS_CHANGED, 
					model_lastModifiedAliasChangedHandler);
			setLastModifiedAlias();
					
			setVersion();
			
			groupStatus.addEventListener(SetGroupStateEvent.SET_GROUP_STATE,
					view_setGroupStateHandler);
		}
		
		protected function model_groupChangedHandler(event:GroupModelEvent):void
		{
			setGroup();
		}
		
		protected function model_statusChangedHandler(event:GroupModelEvent):void
		{
			setStatus();
		}
		
		protected function model_lastModifiedAliasChangedHandler(event:GroupModelEvent):void
		{
			setLastModifiedAlias();
		}
		
		protected function model_aliasChangedHandler(event:GroupModelEvent):void
		{
			setAlias();
		}
		
		protected function setGroup():void
		{
			groupStatus.group = groupModel.group;
		}
		
		protected function setAlias():void
		{
			groupStatus.alias = groupModel.alias;
		}
		
		protected function setStatus():void
		{
			groupStatus.status = groupModel.status;
		}
		
		protected function setLastModifiedAlias():void
		{
			groupStatus.lastModifiedAlias = groupModel.lastModifiedAlias;
		}
		
		protected function setVersion():void
		{
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXML.namespace();
			groupStatus.appVersion = appXML.ns::version;
		}
		
		protected function view_setGroupStateHandler(event:SetGroupStateEvent):void
		{
			dispatch(event);
		}
	}
}