package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.view.IPreloader;
	
	public interface IPreloadManager
	{
		function initialize( $preloaderTime:Number = 0 ):void;
		function loadBegin():void;
		function loadComplete():void;
		/*
		Accessors
		*/
		function set minimumTime( $seconds:Number ):void;
		function set progress( $progress:Number ):void;
		function set preloader( $preloader:IPreloader ):void;
	}
}