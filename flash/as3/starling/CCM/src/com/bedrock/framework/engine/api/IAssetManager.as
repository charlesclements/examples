package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.data.BedrockAssetData;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.engine.data.BedrockAssetGroupData;

	public interface IAssetManager
	{
		function initialize( $data:XML ):void;
		function hasGroup( $id:String ):Boolean;
		function getGroup( $id:String ):BedrockAssetGroupData;
		function filterGroups( $value:*, $field:String ):Array;
		function addAssetToGroup( $groupID:String, $asset:BedrockAssetData ):void;
		function get data():HashMap;
	}
}