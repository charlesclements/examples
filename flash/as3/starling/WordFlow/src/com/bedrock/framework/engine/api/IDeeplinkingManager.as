package com.bedrock.framework.engine.api
{
	import flash.events.IEventDispatcher;
	
	public interface IDeeplinkingManager extends IEventDispatcher
	{
		function initialize():void
		/*
		Enable/ Disable Change Event
		*/
		function enableChangeHandler():void;
		function disableChangeHandler():void;
		/*
		Address Functions
		*/
		function getAddress():String
		function setAddress($value:String):void;
		function clearAddress():void;
		/*
		Title functions
		*/
		function getTitle():String;
		function setTitle($title:String):void;
		/*
		Status bar functions 
		*/
		function getStatus():String;
		function setStatus($status:String):void;
		function resetStatus():void;
		/*
		Path functions
		*/
		function getPath():String;
		function setPath($path:String):void;
		function clearPath():void;
		function getPathNames():Array;
		/*
		Query string functions
		*/
		function setQueryString($query:String):void;
		function getQueryString():String;
		function clearQueryString():void;
		/*
		Parameter functions
		*/
		function getParameter($parameter:String):*
		function populateParameters($query:Object):void
		function addParameter($parameter:String,$value:String):void
		function setParameter($parameter:String,$value:String):void
		function getParametersAsObject():Object
		function getParameterNames():Array
		function clearParameter($parameter:String):void
	}
}