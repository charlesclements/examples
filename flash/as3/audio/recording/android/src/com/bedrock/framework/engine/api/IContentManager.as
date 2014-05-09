package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.data.BedrockContentData;
	

	public interface IContentManager
	{
		function initialize( $data:XML ):void;
		function addContent( $data:BedrockContentData ):void;
		function getContent( $id:String ):BedrockContentData;
		function hasContent( $id:String ):Boolean;
		function filterContents( $value:*, $field:String ):Array;
		function get data():Array;
	}
}