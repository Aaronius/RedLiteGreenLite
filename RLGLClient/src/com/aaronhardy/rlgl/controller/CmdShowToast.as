package com.aaronhardy.rlgl.controller
{
	import com.aaronhardy.rlgl.model.GroupModel;
	import com.aaronhardy.rlgl.view.toast.Toast;
	
	import flash.display.Screen;
	import flash.geom.Rectangle;
	
	import org.robotlegs.mvcs.Command;
	
	public class CmdShowToast extends Command
	{
		[Inject]
		public var groupModel:GroupModel;
		
		override public function execute():void
		{
			var toast:Toast = new Toast();
			toast.color = groupModel.status;
			toast.lastModifiedAlias = groupModel.lastModifiedAlias;
			toast.open();
		}
	}
}