package com.bedrock.extras.video
{
	import com.bedrock.framework.core.base.SpriteBase;
	import com.bedrock.framework.plugin.audio.AudioMixer;
	import com.bedrock.framework.plugin.data.VideoPlayerData;
	import com.bedrock.framework.plugin.event.TriggerEvent;
	import com.bedrock.framework.plugin.event.VideoEvent;
	import com.bedrock.framework.plugin.timer.IntervalTrigger;
	import com.bedrock.framework.plugin.util.MathUtil;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class VideoPlayer extends SpriteBase
	{
		/*
		Variable Definitions
		*/
		//Objects
		public var data:VideoPlayerData;
		
		private var _objVideo:Video;
		private var _objConnection:NetConnection;
        private var _objStream:NetStream;
        private var _audioMixer:AudioMixer;
        private var _objSharedTrigger:IntervalTrigger;
		private var _objClient:Object;
		//String
		private var _strURL:String;
		//Numbers
		private var _duration:Number;   
		//Boolean     
        private var _paused:Boolean;
        private var _bolLoadAndPause:Boolean;
        private var _playComplete:Boolean;
        private var _bolMuted:Boolean;
       
        /*
        Constructor
        */	
		public function VideoPlayer()
		{
			this._bolMuted = false;
			this._paused = false;
			this._playComplete = false;
			this._objSharedTrigger = new IntervalTrigger(0.1);
			this._objSharedTrigger.silenceLogging = true;
			
		}
		public function initialize( $data:VideoPlayerData ):void
		{
			this.data = $data;
			
			this.createPlayer( this.data.width, this.data.height );
			this.createConnection();
			this.createClient();
			this.createNetStream( this.data.connection );
			//
			this.createInternalListeners();
			this.createAudioMixer();
		}
		private function createPlayer( $width:int, $height:int ):void
		{
			this._objVideo = new Video( $width, $height );
			this._objVideo.smoothing = this.data.smoothing;
			this.addChild(this._objVideo);
		}
		private function createConnection():void
		{
			this._objConnection = new NetConnection();
			this._objConnection.addEventListener(NetStatusEvent.NET_STATUS, this._onStatusHandler);			
            this._objConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this._onSecurityError);
		}
		
		private function createClient():void
		{
			this._objClient = new Object();
			this._objClient._onMetaData = this._onMetaData;
			this._objClient._onCuePoint = this._onCuePoint;
			this._objClient._onPlayStatus = this._onPlayStatus;
		}
		
		private function createNetStream($connection:String = null):void
		{
			this._objConnection.connect($connection);
            //
            this._objStream = new NetStream(this._objConnection);
            this._objStream.client = this._objClient;
            this._objStream.addEventListener(NetStatusEvent.NET_STATUS, this._onStatusHandler);
            this._objStream.addEventListener(IOErrorEvent.IO_ERROR, this._onIOError);
            this._objStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this._onSyncError);
            //
			this._objVideo.attachNetStream(this._objStream);
		}
		
		private function createInternalListeners():void
		{
			this.addEventListener(VideoEvent.BUFFER_FULL, this._onBufferFull);
			this.addEventListener(VideoEvent.STREAM_BUFFER_EMPTY, this._onBufferEmpty);
			this.addEventListener(VideoEvent.PLAY_START, this._onPlayStart);
			this.addEventListener(VideoEvent.PLAY_STOP, this._onPlayStop);	
			//this.addEventListener(VideoEvent.SEEK_INVALID, this.dispatchEvent);
			this.addEventListener(VideoEvent.BUFFER_FLUSH, this._onBufferFlush);		
		}
		
		private function createAudioMixer():void
		{
			this._audioMixer = new AudioMixer(this._objStream);		
		}
		/*
		Basic Functions
		*/
		public function play($url:String = null,$duration = 0):void
		{
			this._duration = $duration;
			this._strURL = $url || this._strURL;
			this._paused = false;	
			
			if (this.data.loadAndPause) {
				this.mute();
			}

			this._objSharedTrigger.addEventListener(TriggerEvent.TRIGGER, this._onLoadTrigger);
			this._objSharedTrigger.addEventListener(TriggerEvent.TRIGGER, this._onBufferTrigger);
			this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onProgressTrigger);
			
			this._objVideo.clear()
			
			this._objSharedTrigger.startInterval();
			this._objStream.play(this._strURL);
		}
		public function stop():void
		{	
			this._objVideo.clear()
			this._objStream.close();
			this._objSharedTrigger.stopInterval();
			this.dispatchEvent(new VideoEvent(VideoEvent.STOP, this));
		}
		public function clear():void
		{
			this._objConnection.close();
			this._objStream.close();
			this._objVideo.clear();
			this._objSharedTrigger.stopInterval();
			this.dispatchEvent(new VideoEvent(VideoEvent.CLEAR, this));
		}
		
		public function clearScreen():void
		{
			this._objVideo.clear();
		}
		/*
		Muting
		*/
		public function mute():void
		{
			this._bolMuted = true;
			this._audioMixer.mute();
			this.dispatchEvent(new VideoEvent(VideoEvent.MUTE, this));
		}
		public function unmute():void
		{
			this._bolMuted = false;
			this._audioMixer.unmute();
			this.dispatchEvent(new VideoEvent(VideoEvent.UNMUTE, this));
		}
		public function toggleMute():Boolean
		{
			var bolMute:Boolean = this._audioMixer.toggleMute();
			if (bolMute) {
				this.dispatchEvent(new VideoEvent(VideoEvent.MUTE, this));
			} else {
				this.dispatchEvent(new VideoEvent(VideoEvent.UNMUTE, this));
			}
			return bolMute;
		}
		/*
		Pausing
		*/
		public function pause():void
		{
			if (!this._paused) {
				this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onProgressTrigger);   
				this._objStream.pause();
				this._paused = true;
				this.dispatchEvent(new VideoEvent(VideoEvent.PAUSE, this));
			}
		}
		public function resume():void
		{
			if (this._paused) {
				this._objSharedTrigger.addEventListener(TriggerEvent.TRIGGER, this._onProgressTrigger); 
				this._objStream.resume();
				this._paused = false;
				this.dispatchEvent(new VideoEvent(VideoEvent.RESUME, this));
			}
		}
		/*
		Seek
		*/
		public function seekWithTime($time:Number):void
        {
        	this._objSharedTrigger.startInterval()
            this.dispatchEvent(new VideoEvent(VideoEvent.SEEK_START, this));
            this._objStream.seek($time);
        }
        
        public function seekWithPercentage($percent:Number):void
        {
            var numTime:Number = (this.duration * ($percent /100));
			this.seekWithTime(numTime);
        }
		
		private function checkForCompletion():Boolean
		{
			return ( Math.floor( this._objStream.time ) >= Math.floor( this._duration ) );
		}
		/*
		Event Handlers
		*/
		private function _onStatusHandler($event:NetStatusEvent):void
		{	
			this.dispatchEvent( new VideoEvent( $event.info.code, this, $event ) );
		}
		private function _onSecurityError($event:SecurityErrorEvent):void
		{
			this.dispatchEvent(new VideoEvent(VideoEvent.ERROR, this, {text:$event.text}));
		}
		private function _onSyncError($event:AsyncErrorEvent):void
		{
			this.dispatchEvent(new VideoEvent(VideoEvent.ERROR, this, {text:$event.text, error:$event.error}));
		}
		private function _onIOError($event:IOErrorEvent):void
		{
			this.dispatchEvent(new VideoEvent(VideoEvent.ERROR, this, {text:$event.text}));
		}

		private function _onPlayStart($event:VideoEvent):void
		{
			this._playComplete = false;
			this._objSharedTrigger.addEventListener(TriggerEvent.TRIGGER, this._onProgressTrigger);
			this.dispatchEvent(new VideoEvent(VideoEvent.BUFFER_EMPTY, this, $event.details));
			if (this._bolLoadAndPause) {
				this.dispatchEvent( new VideoEvent( VideoEvent.QUEUE_COMPLETE, this ) );			
				this.pause();
				this.seekWithTime(0);			
				this.unmute();
			}
		}
		private function _onPlayStop($event:VideoEvent):void
		{
			this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onProgressTrigger);
			if ( this.checkForCompletion() ) {
				this._playComplete = true;
				this._objSharedTrigger.stopInterval();
				this.dispatchEvent(new VideoEvent(VideoEvent.PLAY_COMPLETE, this, $event.details));
			}
		}
		
		private function _onBufferEmpty($event:VideoEvent):void
		{
			if(!this._playComplete){
				this.dispatchEvent(new VideoEvent(VideoEvent.BUFFER_EMPTY, this, $event.details));
				this._objSharedTrigger.addEventListener(TriggerEvent.TRIGGER, this._onBufferTrigger);
			}
		}
		
		private function _onBufferFull($event:VideoEvent):void
		{
			this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onBufferTrigger);
		}
		
		private function _onBufferFlush($event:VideoEvent):void
		{
			this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onBufferTrigger);
			this.dispatchEvent(new VideoEvent(VideoEvent.BUFFER_FULL, this, $event.details));
		}
		
		private function _onSeekInvalid($event:VideoEvent):void
		{
			
		}
		/*
		Trigger Handlers
		*/
		private function _onBufferTrigger($event:TriggerEvent):void
		{	
			var numPercent:int = MathUtil.calculatePercentage(this._objStream.bufferLength, this._objStream.bufferTime);
			//
			var objDetails:Object = new Object();
			objDetails.bufferLength = this._objStream.bufferLength;
			objDetails.bufferTime = this._objStream.bufferTime;
			objDetails.percent = (numPercent > 100) ? 100 : numPercent;
			//
			this.dispatchEvent(new VideoEvent(VideoEvent.BUFFER_PROGRESS, this, objDetails));
		}
		private function _onLoadTrigger($event:TriggerEvent):void
		{
			var numPercent:int = MathUtil.calculatePercentage(this._objStream.bytesLoaded, this._objStream.bytesTotal);
			
			var objDetails:Object = new Object();
			objDetails.bytesLoaded = this._objStream.bytesLoaded;
			objDetails.bytesTotal = this._objStream.bytesTotal;		
			objDetails.percent = (numPercent > 100) ? 100 : numPercent;
			
			if (numPercent == 100) {
				this.dispatchEvent(new VideoEvent(VideoEvent.LOAD_COMPLETE, this, objDetails));
				this._objSharedTrigger.removeEventListener(TriggerEvent.TRIGGER, this._onLoadTrigger);
			}
			
			this.dispatchEvent(new VideoEvent(VideoEvent.LOAD_PROGRESS, this, objDetails));
		}
		private function _onProgressTrigger($event:TriggerEvent):void
		{	
			var numPercent:int = MathUtil.calculatePercentage(this._objStream.time, this._duration);
			
			var objDetails:Object = new Object();
			objDetails.position = this._objStream.time;
			objDetails.duration = this._duration;
			objDetails.percent = (numPercent > 100) ? 100 : numPercent;
			this.dispatchEvent(new VideoEvent(VideoEvent.PLAY_PROGRESS, this, objDetails));
		}
		/*
		Weird Handlers
		*/
		private function _onCuePoint($info:Object):void
		{
			this.dispatchEvent(new VideoEvent(VideoEvent.CUE_POINT, this, $info));			
		}
		private function _onMetaData($info:Object):void
		{
			this._duration = $info.duration;
			this.dispatchEvent(new VideoEvent(VideoEvent.META_DATA, this, $info));
		}	
		
		private function _onPlayStatus($info:Object):void
		{
			
		}
		/*
		Property Definitions
		*/
		public function get isPaused():Boolean
		{
			return this._paused;
		}
		public function set smoothing($status:Boolean):void
		{
			this.data.smoothing = $status;
			this._objVideo.smoothing = this.data.smoothing;
		}
		public function get smoothing():Boolean
		{
			return this._objVideo.smoothing;
		}
		public function set deblocking($status:int):void
		{
			this.data.deblocking = $status;
			this._objVideo.deblocking = this.data.deblocking;
		}
		public function get deblocking():int
		{
			return this._objVideo.deblocking;
		}
		public function set bufferTime($value:Number):void
		{
			this.data.bufferTime = $value;	
			this._objStream.bufferTime = this.data.bufferTime;
		}
		public function get bufferTime():Number
		{
			return this._objStream.bufferTime;
		}
		public function get duration():Number
		{
			return this._duration;
		}
		public function get position():Number
		{
			return this._objStream.time;
		}
		/**
		* Change the video's sound volume.
		* @param value The volume, ranging from 0 (silent) to 1 (full volume). 
	 	*/
		public function set volume($value:Number):void
		{
			try{
				this._audioMixer.volume = $value;
				this.dispatchEvent( new VideoEvent(VideoEvent.VOLUME, this, { volume:$value } ) );
			} catch($error:Error){
			}
		}
		
		public function get volume():Number
		{
			return this._audioMixer.volume;
		}
		/**
		* Change the video's sound panning.
		* @param value The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). A value of 0 represents no panning (center). 
	 	*/
		public function set panning($value:Number):void
		{
			try{
				this._audioMixer.panning = $value;
				this.dispatchEvent( new VideoEvent( VideoEvent.PANNING, this, { panning:$value } ) );
			} catch($error:Error){
			}
		}
		
		public function get panning():Number
		{
			return this._audioMixer.panning;
		}
		
		public function get isMuted():Boolean{
			return this._bolMuted;
		}
	}
}