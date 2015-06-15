package com.bedrock.framework.engine.api
{

	import flash.display.DisplayObjectContainer;
	
	public interface IContainerManager
	{
		function initialize( $data:XML, $root:DisplayObjectContainer ):void;
		function createContainer( $id:String, $child:DisplayObjectContainer=null, $parent:DisplayObjectContainer=null, $data:*=null, $depth:int=-1 ):*;
		function replaceContainer( $id:String, $child:DisplayObjectContainer, $data:*=null, $depth:int=-1 ):*;
		/*
		Depth Functions
		*/
		function getDepth( $id:String ):int;
		/*
		Container Functions
		*/
		function getContainer( $id:String ):*;
		function removeContainer( $id:String ):void;
		function hasContainer( $id:String ):Boolean;
		/*
		Property Definitions
		*/
		function get root():DisplayObjectContainer;
	}
}