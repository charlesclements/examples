package com.bedrock.framework.engine.api
{
	import flash.display.DisplayObjectContainer;
	
	public interface IConfig
	{
		function initialize($data:String, $url:String ):void;
		
		/*
		Save the page information for later use.
		*/
		function getSettingValue($id:String):*;
		function getPathValue($id:String):*;
		function getVariableValue($id:String):*;
		
		function saveSettingValue( $id:String, $value:*, $overrideOnly:Boolean = false ):void;
		function savePathValue($id:String, $value:*, $overrideOnly:Boolean = false ):void;
		function saveVariableValue( $id:String, $value:*, $overrideOnly:Boolean = false ):void;
		
		function hasSettingValue($id:String):Boolean;
		function hasPathValue($id:String):Boolean;
		function hasVariableValue($id:String):Boolean;

		function parseParams( $data:* ):void;
		
		function get containers():XML;
		function get locales():XML;
		function get contents():XML;
		function get assets():XML;
	}
}