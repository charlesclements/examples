package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.plugin.tracking.ITrackingService;
	
	public interface ITrackingManager
	{
		function initialize($enabled:Boolean = true):void;
		/*
		Run Tracking
		*/
		function track($id:String, $details:Object):void;
		/*
		Add/ Get Services
		*/
		function addService($id:String, $service:ITrackingService):void;
		function getService($id:String):*;
		function hasService( $id:String ):Boolean;
		/*
		Property Definitions
		*/
		function set enabled($status:Boolean):void;
		function get enabled():Boolean;
	}
}