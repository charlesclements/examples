package com.bedrock.framework.plugin.audio
{
	
	import flash.media.SoundChannel;
	
	public interface ISoundBoard
	{
		function add( $data:SoundData ):void;
		function load($id:String, $url:String, $completeHandler:Function):void
		
		function play($id:String, $startTime:Number = 0, $delay:Number = 0, $loops:int = 0, $volume:Number = 1, $panning:Number = 0):SoundChannel;
		function stop($id:String):void;
		function close($id:String):void;
		
		function pause($id:String):void;
		function resume($id:String):void;
		
		function setVolume($id:String, $value:Number):void;
		function getVolume($id:String):Number;
		function fadeVolume($id:String, $value:Number, $time:Number, $handlers:Object = null ):void;
		
		function setPanning($id:String, $value:Number):void;
		function getPanning($id:String):Number;
		function fadePanning($id:String, $value:Number, $time:Number, $handlers:Object = null ):void;
		
		function mute( $id:String ):void;
		function unmute( $id:String ):void;
		function toggleMute( $id:String ):Boolean;
		function isMuted( $id:String ):Boolean;
		
		function getData($id:String):SoundData;
	}
}