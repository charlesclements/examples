package com.bedrock.extras.audio
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.ISoundManager;
	import com.bedrock.framework.plugin.audio.GlobalSound;
	import com.bedrock.framework.plugin.audio.SoundBoard;
	
	import flash.media.SoundChannel;
	import com.bedrock.framework.plugin.audio.SoundData;

	public class SoundManager extends StandardBase implements ISoundManager
	{
		/*
		Variable Declarations
		*/
		public static const GLOBAL:String = "global";
		
		private var _objSoundBoard:SoundBoard;
		private var _objGlobalSound:GlobalSound;
		/*
		Constructor
		*/
		public function SoundManager()
		{
			this.createGlobalSound();
			this.createSoundBoard();
		}
		public function initialize($sounds:Array = null):void
		{
			this.createSounds($sounds);
		}
		/*
		Creation Functions
		*/
		private function createSoundBoard():void
		{
			this._objSoundBoard = new SoundBoard;
		}
		private function createGlobalSound():void
		{
			this._objGlobalSound = new GlobalSound;
		}
		private function createSounds($sounds:Array):void
		{
			var arrSounds:Array = $sounds;
			var numLength:int = $sounds.length;
			for (var i:int = 0 ; i < numLength; i++) {
				this.add( new SoundData( arrSounds[i].id, arrSounds[i].value ) );
			}
		}
		/*
		Audio Functions
		*/
		public function add( $data:SoundData ):void
		{
			this._objSoundBoard.add( $data );
		}
		public function load($id:String, $url:String, $completeHandler:Function):void
		{
		}
		public function play($id:String, $startTime:Number=0, $delay:Number = 0, $loops:int=0, $volume:Number = 1, $panning:Number = 0):SoundChannel
		{
			return this._objSoundBoard.play($id, $startTime, $delay, $loops, $volume, $panning);
		}
		public function stop($id:String):void
		{
			this._objSoundBoard.stop($id);
		}
		public function close($id:String):void
		{
			this._objSoundBoard.close($id);
		}
		public function pause($id:String):void
		{
			this._objSoundBoard.pause($id);
		}
		public function resume($id:String):void
		{
			this._objSoundBoard.resume($id);
		}
		/*
		Volume/ Pan
		*/
		public function setVolume($id:String, $value:Number):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.volume = $value;
					break;
				default :
					this._objSoundBoard.setVolume($id, $value);
					break;
			}
		}
		public function getVolume($id:String):Number
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.volume;
					break;
				default :
					return this._objSoundBoard.getVolume($id);
					break;
			}
		}
		public function setPanning($id:String, $value:Number):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.panning = $value;
					break;
				default :
					this._objSoundBoard.setVolume($id, $value);
					break;
			}
		}
		public function getPanning($id:String):Number
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.panning;
					break;
				default :
					return this._objSoundBoard.getPanning($id);
					break;
			}
		}
		public function fadeVolume($id:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.fadeVolume( $value, $time, $handlers );
					break;
				default :
					this._objSoundBoard.fadeVolume($id, $value, $time, $handlers );
					break;
			}
		}
		public function fadePanning($id:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.fadePanning( $value, $time, $handlers );
					break;
				default :
					this._objSoundBoard.fadePanning($id, $value, $time, $handlers );
					break;
			}
		}
		/*
		Global Sound Functions
		*/
		public function mute( $id:String ):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.mute();
					break;
				default :
					this._objSoundBoard.mute( $id );
					break;
			}
		}
		public function unmute( $id:String ):void
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.unmute();
					break;
				default :
					this._objSoundBoard.unmute( $id );
					break;
			}
		}
		public function toggleMute( $id:String ):Boolean
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.toggleMute();
					break;
				default :
					return this._objSoundBoard.toggleMute( $id );
					break;
			}
		}
		public function isMuted( $id:String ):Boolean
		{
			switch ( $id ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.isMuted;
					break;
				default :
					return this._objSoundBoard.isMuted( $id );
					break;
			}
		}
		/*
		Get Data
		*/
		public function getData( $id:String ):SoundData
		{
			return this._objSoundBoard.getData( $id );
		}
	}
}