package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.data.BedrockAssetData;
	import com.bedrock.framework.engine.data.BedrockAssetGroupData;
	import com.bedrock.framework.engine.data.BedrockContentData;
	import com.bedrock.framework.plugin.storage.HashMap;
	
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	
	public interface ILoadController extends IEventDispatcher
	{
		function initialize( $builder:*, $applicationDomain:ApplicationDomain ):void;
		function load():void;
		function pause():void;
		function resume():void;
		
		function appendLoader( $loader:* ):void;
		function appendContent( $content:BedrockContentData ):void;
		function disposeContent( $id:String ):void;
		function appendAsset( $asset:BedrockAssetData ):void;
		function appendAssetGroup( $assetGroup:BedrockAssetGroupData ):void;
		/*
		Getters
		*/
		function hasLoader( $nameOrURL:String ):Boolean;
		function getLoader( $nameOrURL:String ):*;
		function getLoaderContent( $nameOrURL:String ):*;
		function getRawLoaderContent( $nameOrURL:String ):*;
		function getAssetGroupContents( $id:String ):HashMap;
		/*
		Property Definitions
		*/
		function set checkPolicyFile( $status:Boolean ):void;
		function get checkPolicyFile():Boolean;
		
		function set maxConnections( $count:uint ):void;
		function get maxConnections():uint;
		
		function set applicationDomain( $applicationDomain:ApplicationDomain ):void;
		function get applicationDomain():ApplicationDomain;
		
		function get empty():Boolean;
	}
}