package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.engine.data.BedrockSequenceData;
	import com.bedrock.framework.engine.view.BedrockContentView;
	
	import flash.events.IEventDispatcher;

	public interface ITransitionController extends IEventDispatcher
	{
		function initialize( $shellView:* ):void;
		function runSequence( $sequence:BedrockSequenceData ):void;
	}
}