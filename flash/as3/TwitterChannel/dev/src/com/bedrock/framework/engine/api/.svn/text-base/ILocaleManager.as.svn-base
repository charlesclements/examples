package com.bedrock.framework.engine.api
{
	public interface ILocaleManager
	{
		function initialize( $data:XML, $localizedFiles:String, $defaultLocale:String = null, $currentLocale:String = null, $delimiter:String = "_" ):void
		function load($locale:String = null ):void;
		function isLocaleAvailable($locale:String):Boolean;
		function isFileLocalized($file:String):Boolean;
		
		function set delimiter( $delimiter:String ):void;
		function get delimiter():String;
		function get data():Array;
		function set currentLocale( $value:String ):void;
		function get currentLocale():String;
		function get defaultLocale():String;
	}
}