﻿package com.bedrock.extras.video
{
	import com.bedrock.framework.core.base.SpriteBase;
	import com.bedrock.framework.plugin.audio.AudioMixer;
	import com.bedrock.framework.plugin.data.YouTubePlayerData;
	import com.bedrock.framework.plugin.event.LoaderEvent;
	import com.bedrock.framework.plugin.event.TriggerEvent;
	import com.bedrock.framework.plugin.event.VideoEvent;
	import com.bedrock.framework.plugin.event.YouTubePlayerEvent;
	import com.bedrock.framework.plugin.loader.VisualLoader;
	import com.bedrock.framework.plugin.timer.IntervalTrigger;
	import com.bedrock.framework.plugin.timer.TimeoutTrigger;
	import com.bedrock.framework.plugin.util.MathUtil;
	
	import flash.events.Event;
	import flash.system.Security;

	public class YouTubePlayer extends SpriteBase implements IVideoPlayer
	{
		/*
		Variable Declarations
		*/
		public static const UNSTARTED:Number = -1;
		public static const ENDED:Number = 0;
		public static const PLAYING:Number = 1;
		public static const PAUSED:Number = 2;
		public static const BUFFERING:Number = 3;
		public static const QUEUED:Number = 5;
		
		public var data:YouTubePlayerData;
		private var _objLoader:VisualLoader;
		private var _objVideoPlayer:*;
		private var _objUpdateTrigger:IntervalTrigger;
		private var _objFailureTrigger:TimeoutTrigger;
		private var _objAudioMixer:AudioMixer;
		
		private var _currentPercent:Number = -1;
		private var _currentTime:Number = -1;
		
		private var _seeking:Boolean;
		private var _playing:Boolean;
		private var _videoInQueue:Boolean;
		private var _metaDataLoaded:Boolean;
		private var _connectionEstablished:Boolean;
		private var _paused:Boolean;
		
		private var _connectionAttempts:Number = 0;
		/*
		Constructor
	 	*/
		public function YouTubePlayer()
		{
			Security.allowDomain("http://www.youtube.com");
			Security.allowInsecureDomain("http://www.youtube.com");	
		}
		
		public function initialize( $data:YouTubePlayerData ):void
		{
			this.data = $data;
			this.reset();
			this.createTrigger();
			this.createLoader();
			this.createAudioMixer();
			this.loadPlayer();
		}
		private function createTrigger():void
		{
			this._objUpdateTrigger = new IntervalTrigger( 0.005 );
			this._objUpdateTrigger.silenceLogging = true;
			
			this._objFailureTrigger = new TimeoutTrigger( 5 );
			this._objFailureTrigger.addEventListener( TriggerEvent.TRIGGER, this.onFailureTrigger );
			this._objFailureTrigger.silenceLogging = true;
		}
		
		private function createLoader():void
		{
			this._objLoader = new VisualLoader;
			this._objLoader.addEventListener( LoaderEvent.INIT, this.onLoadComplete );
			this._objLoader.addEventListener( LoaderEvent.IO_ERROR, this.onLoadError );
			this._objLoader.addEventListener( LoaderEvent.SECURITY_ERROR, this.onLoadError );
			this.addChild( this._objLoader );
		}
		private function createVideoPlayer():void
		{
			this._objVideoPlayer = this._objLoader.content;
			
			this._objVideoPlayer.addEventListener( YouTubePlayerEvent.PLAYER_READY, this.onPlayerReady );
			this._objVideoPlayer.addEventListener( YouTubePlayerEvent.PLAYER_ERROR, this.onPlayerError );
			this._objVideoPlayer.addEventListener( YouTubePlayerEvent.PLAYER_CHANGE, this.onPlayerChange );
		}
		private function createAudioMixer():void
		{
			this._objAudioMixer = new AudioMixer();	
		}
		
		
		public function play( $id:String = null ):void
		{
			this._objUpdateTrigger.addEventListener( TriggerEvent.TRIGGER, this.onLoadTrigger );
			this._objUpdateTrigger.startInterval();
			this.data.id = $id || this.data.id;
			if ( this.playerLoaded && this.playerStatus != YouTubePlayer.QUEUED ) {
				this._paused = false;
				this._playing = false;
				this._objVideoPlayer.loadVideoById( this.data.id, 0, this.data.quality );
			} else if ( this.playerLoaded && this.playerStatus == YouTubePlayer.QUEUED ) {
				this._objVideoPlayer.playVideo();
			}
		}
		public function playWithOffset( $id:String = null, $offset:Number = 0 ):void
		{
			this._objUpdateTrigger.addEventListener( TriggerEvent.TRIGGER, this.onLoadTrigger );
			this._objUpdateTrigger.startInterval();
			this.data.id = $id || this.data.id;
			if ( this.playerLoaded && this.playerStatus != YouTubePlayer.QUEUED ) {
				this._paused = false;
				this._playing = false;
				this._objVideoPlayer.loadVideoById( this.data.id, $offset, this.data.quality );
			} else if ( this.playerLoaded && this.playerStatus == YouTubePlayer.QUEUED ) {
				this._objVideoPlayer.playVideo();
			}
		}
		
		public function queue( $id:String = null ):void
		{
			this._objUpdateTrigger.startInterval();
			this.data.id = $id || this.data.id;
			if( this.playerLoaded ){
				this._paused = false;
				this._playing = false;
				this._objVideoPlayer.cueVideoById( this.data.id );
			}
		}
		public function stop():void
		{
			this._objUpdateTrigger.stopInterval();
			if ( this._playing && this.playerLoaded ) {
				this._paused = false;
				this._playing = false;
				this._objVideoPlayer.stopVideo();
			}
		}
		public function pause():void
		{
			if ( !this._paused && this.playerLoaded ) {
				this._paused = true;
				this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
				this._objVideoPlayer.pauseVideo();
				this.dispatchEvent( new VideoEvent( VideoEvent.PAUSE, this ) );
			}
		}
		public function resume():void
		{
			if ( this._paused && this.playerLoaded ) {
				this._paused = false;
				this._objUpdateTrigger.addEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
				this._objVideoPlayer.playVideo();
				this.dispatchEvent( new VideoEvent( VideoEvent.RESUME, this ) );
			}
		}
		
		public function reset():void
		{
			if( this.playerLoaded ) {
				this.stop();
			}
			this._currentPercent = -1;
			this._currentTime = -1;
			
			this._seeking = false;
			this._playing = false;
			this._paused = false;
			this._videoInQueue = false;
			this._metaDataLoaded = false;
			this._connectionEstablished = false;
		}
		
		public function clear():void
		{
			this.reset();
			this._objVideoPlayer.destroy();
			this._objLoader.unloadAndStop( true );
		}
		
		public function mute():void
		{
			this._objAudioMixer.mute();
			this.volume = 0;
			this.dispatchEvent( new VideoEvent( VideoEvent.MUTE, this ) );
		}
		public function unmute():void
		{
			this._objAudioMixer.unmute();
			this.volume = 100;
			this.dispatchEvent( new VideoEvent( VideoEvent.UNMUTE, this ) );
		}
		public function toggleMute():Boolean
		{
			if ( this.playerLoaded ) {
				if ( this.isMuted ) {
					this.unmute();
				} else {
					this.mute();
				}
			}
			return this.isMuted;
		}
		
		
		
		public function seekWithTime( $seconds:Number ):void
		{
			this._seeking = true;
			this._objVideoPlayer.seekTo( $seconds, this.data.allowSeekAhead );
			this.dispatchEvent( new VideoEvent( VideoEvent.SEEK_START, this, { progress:$seconds, percentage:MathUtil.calculatePercentage( $seconds, this.duration ), duration:this.duration } ) );
		}
		
		public function seekWithPercentage($percent:Number):void
		{
			var numTime:Number = MathUtil.getPercentageOfValue( $percent, this.duration );
			this.seekWithTime( numTime );
		}
		/*
		Player Functions
		*/
		private function reloadPlayer():void
		{
			if ( this.playerLoaded ) {
				if( this._objLoader.content != null && this._objVideoPlayer != null ){
					this._objVideoPlayer.removeEventListener( YouTubePlayerEvent.PLAYER_READY, this.onPlayerReady );
					this._objVideoPlayer.removeEventListener( YouTubePlayerEvent.PLAYER_ERROR, this.onPlayerError );
					this._objVideoPlayer.removeEventListener( YouTubePlayerEvent.PLAYER_CHANGE, this.onPlayerChange );
					this._objVideoPlayer.destroy();
					this._objLoader.unloadAndStop( true );
				}
				this._objVideoPlayer = null;
			} else {
				this.attention( "YouTube Player not loaded!" );
			}
			this.loadPlayer();
		}
		private function loadPlayer():void
		{
			this._objLoader.loadURL( this.data.playerURL );
		}
		/*
		Event Handlers
		*/
		private function onPlayerReady($event:Event):void
		{
			if( this._videoInQueue ) {
				( this.data.autoQueue != true) ? this.play() : this.queue();
				this._videoInQueue = false;
			}
			this.dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PLAYER_READY, this ) );
		}
		private function onPlayerError($event:Event):void
		{
			this.dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PLAYER_LOAD_ERROR, this ) );
		}
		private function onPlayerChange( $event:Event ):void
		{
			switch( this.playerStatus ){
				case YouTubePlayer.BUFFERING:
					this.dispatchEvent( new VideoEvent( VideoEvent.BUFFER_EMPTY, this ) );
					this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
					break;
				case YouTubePlayer.ENDED:
					if ( this.data.completeType == YouTubePlayerData.REAL ) {
						this._playing = false;
						this._objUpdateTrigger.stopInterval();
						this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
						this.dispatchEvent( new VideoEvent( VideoEvent.PLAY_COMPLETE, this ) );
					}
					break;
				case YouTubePlayer.PAUSED:
					//this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
					break;
				case YouTubePlayer.PLAYING:
					if ( !this._objUpdateTrigger.running ) {
						this._objUpdateTrigger.startInterval();
					}
					if ( this._seeking ) {
						this._seeking = false;
						this.dispatchEvent( new VideoEvent( VideoEvent.SEEK_COMPLETE, this, { position:this.position, percentage:MathUtil.calculatePercentage( this.position, this.duration ), duration:this.duration } ) );
					}
					if ( !this._playing ) {
						this._playing = true;
						this.dispatchEvent( new VideoEvent( VideoEvent.META_DATA, this, { duration:this.duration } ) );
					}
					this.dispatchEvent( new VideoEvent( VideoEvent.BUFFER_FULL, this ) );
					this.dispatchEvent( new VideoEvent( VideoEvent.PLAY_START, this ) );
					this._objUpdateTrigger.addEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
					break;
				case YouTubePlayer.QUEUED:
					this._paused = true;
					this.dispatchEvent( new VideoEvent( VideoEvent.QUEUE_COMPLETE, this ) );
					break;
				case YouTubePlayer.UNSTARTED:
					this._objVideoPlayer.setSize( this.data.width, this.data.height );
					break;
			}
		}
		/*
		Trigger Handlers
		*/
		private function onBufferTrigger( $event:TriggerEvent ):void
		{	
			//this.dispatchEvent(new VideoEvent(VideoEvent.BUFFER_PROGRESS, this, objDetails));
		}
		private function onLoadTrigger( $event:TriggerEvent ):void
		{
			var numPercent:int = MathUtil.calculatePercentage( this._objVideoPlayer.getVideoBytesLoaded(), this._objVideoPlayer.getVideoBytesTotal() );
			
			var objDetails:Object = new Object();
			objDetails.bytesStart = this._objVideoPlayer.getVideoStartBytes();		
			objDetails.bytesLoaded = this._objVideoPlayer.getVideoBytesLoaded();
			objDetails.bytesTotal = this._objVideoPlayer.getVideoBytesTotal();
			objDetails.percent = (numPercent > 100) ? 100 : numPercent;
			
			this.dispatchEvent(new VideoEvent(VideoEvent.LOAD_PROGRESS, this, objDetails));
			
			if ( numPercent == 100 ) {
				this.dispatchEvent(new VideoEvent(VideoEvent.LOAD_COMPLETE, this, objDetails));
				this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onLoadTrigger );
			}
			
		}
		private function onProgressTrigger( $event:TriggerEvent ):void
		{	
			var numPercent:int = MathUtil.calculatePercentage(this._objVideoPlayer.getCurrentTime(), this._objVideoPlayer.getDuration() );
			
			var objDetails:Object =  new Object();
			objDetails.position = this._objVideoPlayer.getCurrentTime();
			objDetails.duration = this._objVideoPlayer.getDuration();
			objDetails.percent = (numPercent > 100) ? 100 : numPercent;
			
			this.dispatchEvent(new VideoEvent(VideoEvent.PLAY_PROGRESS, this, objDetails));
			
			if ( this.data.completeType == YouTubePlayerData.FAKE ) {
				if ( numPercent >= this.data.fakePercentage ) {
					this._playing = false;
					this._objUpdateTrigger.stopInterval();
					this._objUpdateTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onProgressTrigger );
					this.dispatchEvent( new VideoEvent( VideoEvent.PLAY_COMPLETE, this ) );
				}
			}
			
		}
		private function onStatusTrigger( $event:TriggerEvent ):void
		{
			if( !this._connectionEstablished ) {
				this._connectionEstablished = true;
				this._objFailureTrigger.stopTimeout();
			}
			
			if( this._metaDataLoaded == false ) {
				if(this._objVideoPlayer.getVideoBytesTotal() > 0){
					this._metaDataLoaded = true;
				}
			}
		}
		private function onFailureTrigger( $event:TriggerEvent ):void
		{
			this.reloadPlayer();
			this.dispatchEvent( new VideoEvent(VideoEvent.CONNECTION_FAILED, this ) );
		}
		/*
		Loader Handlers
		*/
		private function onLoadComplete($event:LoaderEvent):void
		{
			this.createVideoPlayer();
			this.dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PLAYER_LOAD_COMPLETE, this ) );
		}
		
		private function onLoadError($event:LoaderEvent):void
		{
			this.dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PLAYER_LOAD_ERROR, this ) );
		}
		/*
		Property Definitions
		*/
		public function get playerStatus():int
		{
			return this._objVideoPlayer.getPlayerState();
		}
		
		public function get playerLoaded():Boolean
		{
			return ( this._objVideoPlayer != null );
		}
		public function get isPaused():Boolean
		{
			return this._paused;
		}
		
		public function get duration():Number
		{
			return this._objVideoPlayer.getDuration();
		}
		
		public function get position():Number
		{
			return this._objVideoPlayer.getCurrentTime();
		}
		
		public function set volume($value:Number):void
		{
			this._objAudioMixer.volume = $value;
			this._objVideoPlayer.setVolume( this._objAudioMixer.volume * 100 );
		}
		public function get volume():Number
		{
			return this._objAudioMixer.volume;
		}
		public function set panning($value:Number):void
		{
		}
		public function get panning():Number
		{
			return 0;
		}
		public function get isMuted():Boolean
		{
			return this._objAudioMixer.isMuted;
		}
		public function set autoQueue($value:Boolean):void
		{
			this.data.autoQueue = $value;
		}
		public function get autoQueue():Boolean
		{
			return this.data.autoQueue;
		}
		public function set quality($value:String):void
		{
			this.data.quality = $value;
			this._objVideoPlayer.setPlaybackQuality( $value );
		}
		public function get quality():String
		{
			return this._objVideoPlayer.getPlaybackQuality();
		}
		
		public function get qualityLevels():Array
		{
			return this._objVideoPlayer.getAvailableQualityLevels();
		}
	}
}