package com.aaronhardy.rlgl.model
{
	import com.aaronhardy.rlgl.model.events.GroupModelEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class GroupModel extends Actor
	{
		private var _alias:String;
		
		public function get alias():String
		{
			return _alias;
		}
		
		public function set alias(value:String):void
		{
			if (_alias != value)
			{
				_alias = value;
				dispatch(new GroupModelEvent(GroupModelEvent.ALIAS_CHANGED));
			}
		}
		
		private var _group:String;
		
		public function get group():String
		{
			return _group;
		}
		
		public function set group(value:String):void
		{
			if (_group != value)
			{
				_group = value;
				dispatch(new GroupModelEvent(GroupModelEvent.GROUP_CHANGED));
			}
		}
		
		private var _status:String;
		
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			if (_status != value)
			{
				_status = value;
				dispatch(new GroupModelEvent(GroupModelEvent.STATUS_CHANGED));
			}
		}
		
		private var _lastModifiedAlias:String;
		
		public function get lastModifiedAlias():String
		{
			return _lastModifiedAlias;
		}
		
		public function set lastModifiedAlias(value:String):void
		{
			if (_lastModifiedAlias != value)
			{
				_lastModifiedAlias = value;
				dispatch(new GroupModelEvent(GroupModelEvent.LAST_MODIFIED_ALIAS_CHANGED));
			}
		}
		
		private var _loggingIn:Boolean;
		
		public function get loggingIn():Boolean
		{
			return _loggingIn;
		}
		
		public function set loggingIn(value:Boolean):void
		{
			if (_loggingIn != value)
			{
				_loggingIn = value;
				
				if (value)
				{
					dispatch(new GroupModelEvent(GroupModelEvent.LOGGING_IN));
				}
				else
				{
					dispatch(new GroupModelEvent(GroupModelEvent.LOGIN_COMPLETE));
				}
			}
		}
	}
}