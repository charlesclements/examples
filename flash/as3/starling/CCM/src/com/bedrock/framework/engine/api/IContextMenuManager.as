package com.bedrock.framework.engine.api
{
	import flash.ui.ContextMenu;
	
	public interface IContextMenuManager
	{
		function initialize():void;
		function get menu():ContextMenu;
	}
}