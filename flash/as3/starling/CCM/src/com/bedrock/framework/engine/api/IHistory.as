package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.data.BedrockSequenceData;
	
	public interface IHistory
	{
		function appendItem( $queue:BedrockSequenceData ):void;
		function getItem( $index:Number ):BedrockSequenceData;
		/*
		Get Current Queue
		*/
		function get current():BedrockSequenceData;
		/*
		Get Previous Queue
		*/
		function get previous():BedrockSequenceData;
		/*
		Get History
		*/
		function get data():Array;
	}
}