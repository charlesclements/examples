package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.plugin.audio.ISoundBoard;
	
	import flash.media.SoundChannel;
	
		
	public interface ISoundManager extends ISoundBoard
	{
		function initialize($sounds:Array = null):void;
	}
}