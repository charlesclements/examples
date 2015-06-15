package com.bedrock.framework.plugin.audio
{
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundBoard extends DispatcherBase implements ISoundBoard
	{
		/*
		Variable Declarations
		*/
		private var _mapSounds:HashMap;
		/*
		Constructor
		*/
		public function SoundBoard()
		{
			this._mapSounds = new HashMap();
		}
		
		/*
		Add a new sound
		*/
		public function add( $data:SoundData ):void
		{
			this._mapSounds.saveValue($data.id, $data );
		}
		public function remove($id:String):void
		{
			this._mapSounds.removeValue($id);
		}
		public function load($id:String, $url:String, $completeHandler:Function):void
		{
		
		}
		/*
		Yay
		*/
		public function play($id:String, $startTime:Number = 0, $delay:Number = 0, $loops:int = 0, $volume:Number = 1, $panning:Number = 0):SoundChannel
		{
			var objData:SoundData = this.getDataByAlias($id);
			if ( objData != null ) {
				objData.startTime = $startTime;
				objData.delay = $delay;
				objData.loops = $loops;
				objData.volume = $volume;
				objData.panning = $panning;
				objData.transform = new SoundTransform( objData.volume, objData.panning );
				return this.playImmediate(objData);
			} else {
				this.warning( "Sound not available - " + $id );
				return null;
			}
		}
		private function playConditional($data:SoundData):SoundChannel
		{
			if ( $data.delay == 0 ) {
				return this.playImmediate($data);
			} else {
				this.playDelay($data);
				return null;
			}
		}
		private function playImmediate($data:SoundData):SoundChannel
		{
			var objData:SoundData = $data;
			objData.playing = true;
			objData.channel = objData.sound.play(objData.startTime, objData.loops, objData.transform );
			objData.mixer.target = objData.channel;
			//objData.channel.addEventListener( Event.SOUND_COMPLETE, this.onSoundComplete );
			return objData.channel;
		}
		private function playDelay($data:SoundData):void
		{
			TweenLite.delayedCall( $data.delay, this.playImmediate, [$data] );
		}
		public function close($id:String):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( objData.playing ) {
				objData.playing = false;
				objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete );
				objData.sound.close();
			}
		}
		public function stop($id:String):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( objData.playing ) {
				objData.playing = false;
				objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete );
				objData.channel.stop();
			}
		}
		public function pause( $id:String ):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( objData.playing ) {
				objData.resumeTime = objData.channel.position;
				objData.playing = false;
				objData.channel.stop();
			}
		}
		public function resume( $id:String ):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( !objData.playing ) {
				this.play( $id, objData.resumeTime, objData.delay, objData.loops, objData.volume, objData.panning );
			}
		}
		/*
		Get Data
		*/
		private function getDataByChannel($channel:SoundChannel):SoundData
		{
			var arrData:Array = this._mapSounds.getValues();
			return ArrayUtil.findItem(arrData, $channel, "channel");
		}
		private function getDataByAlias($id:String):SoundData
		{
			return this._mapSounds.getValue($id);
		}
		public function getData($id:String):SoundData
		{
			return this.getDataByAlias( $id );
		}
		/*
		Volume Functions
		*/
		public function setVolume($id:String, $value:Number):void
		{
			this.getDataByAlias( $id ).mixer.volume = $value;
		}
		public function getVolume($id:String):Number
		{
			return this.getDataByAlias( $id ).mixer.volume;
		}
		/*
		Pan Functions
		*/
		public function setPanning($id:String, $value:Number):void
		{
			this.getDataByAlias( $id ).mixer.panning = $value;
		}
		public function getPanning($id:String):Number
		{
			return this.getDataByAlias( $id ).mixer.panning;
		}
		/*
		Fade Functions
		*/
		public function fadeVolume($id:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( !objData.playing ) this.play($id, 0, 0, 0, 0, 0);
			objData.mixer.fadeVolume( $value, $time, $handlers );
		}
		
		public function fadePanning($id:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:SoundData = this.getDataByAlias( $id );
			if ( !objData.playing ) this.play($id, 0, 0, 0, 0, 0);
			objData.mixer.fadePanning( $value, $time, $handlers );
		}
		/*
		Mute/ Unmute
		*/
		public function mute( $id:String ):void
		{
			this.getDataByAlias( $id ).mixer.mute();
		}
		public function unmute( $id:String ):void
		{
			this.getDataByAlias( $id ).mixer.unmute();
		}
		public function toggleMute( $id:String ):Boolean
		{
			return this.getDataByAlias( $id ).mixer.toggleMute();
		}
		public function isMuted( $id:String ):Boolean
		{
			return this.getDataByAlias( $id ).mixer.toggleMute();
		}
		/*
		Event Handlers
		*/
		private function onSoundComplete($event:Event):void
		{
			var objData:SoundData = this.getDataByChannel($event.target as SoundChannel);
			objData.playing = false;
			objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
			
			this.dispatchEvent( new SoundEvent(SoundEvent.SOUND_COMPLETE, this, objData) );
		}
	}
}