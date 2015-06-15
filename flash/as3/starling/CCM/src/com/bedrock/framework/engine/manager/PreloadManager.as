package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IPreloadManager;
	import com.bedrock.framework.engine.view.IPreloader;
	import com.bedrock.framework.plugin.trigger.Trigger;
	import com.bedrock.framework.plugin.trigger.TriggerEvent;
	
	public class PreloadManager extends StandardBase implements IPreloadManager
	{
		/*
		Variable Declarations
		*/
		private var _trigger:Trigger;
		private var _preloader:IPreloader;
		
		private var _timeInSeconds:Number;
		private var _timeInMilliseconds:Number;
		
		private var _loadProgress:uint;
		private var _timerProgress:uint;
		
		private var _useTimer:Boolean;
		private var _timerDone:Boolean;
		private var _loaderDone:Boolean;
		/*
		Constructor
		*/
		public function PreloadManager()
		{
			
		}
		public function initialize( $preloaderTime:Number = 0 ):void
		{
			this.minimumTime = $preloaderTime;
			this._createTrigger();
		}
		/*
		Create
		*/
		private function _createTrigger():void
		{
			this._trigger = new Trigger();
			this._trigger.addEventListener( TriggerEvent.TIMER_TRIGGER, this._onTimerTrigger );
			this._trigger.addEventListener( TriggerEvent.STOPWATCH_TRIGGER, this._onStopwatchTrigger);
			this._trigger.silenceLogging = true;
		}
		
		private function _reset():void
		{
			this._loaderDone = false;
			this._timerDone = false;
			this._loadProgress = 0;
			this._timerProgress = 0;
		}
		/*
		Update
		*/
		public function loadBegin():void
		{
			this._reset();
			if ( this._useTimer ) {
				this._trigger.clearStopwatch();
				this._trigger.startTimer( this._timeInSeconds );
				this._trigger.startStopwatch( 0.01 );
			}
			this._updatePreloader( 0 );
		}
		public function loadComplete():void
		{
			this._loaderDone = true;
			this._stopPreloader();
		}
		/*
		Preloader Functions
		*/
		private function _updatePreloader( $progress:uint ):void
		{
			this._preloader.displayProgress( $progress / 100 );
		}
		private function _stopPreloader():void
		{
			if (this._useTimer) {
				if ( this._timerDone && this._loaderDone ) {
					this._killPreloader();
				}				
			} else {
				this._killPreloader();
			}
		}
		private function _killPreloader():void
		{
			if ( this._useTimer ) {
				this._trigger.stopTimer();
				this._trigger.stopStopwatch();
			}
			this._updatePreloader( 100 );
			this._preloader.outro();
		}
		
		private function _getPercentage():uint
		{
			if ( this._useTimer ) {
				if ( this._loadProgress < this._timerProgress ) {
					return this._loadProgress;
				} else {
					return this._timerProgress;
				}
			} else {
				return this._loadProgress;
			}
		}
		
		/*
		Trigger Handlers
		*/
		private function _onStopwatchTrigger( $event:TriggerEvent ):void
		{
			this._timerProgress = Math.round( ( this._trigger.elapsedMilliseconds / this._timeInMilliseconds) * 100 );
			this._updatePreloader( this._getPercentage() );
		}
		private function _onTimerTrigger($event:TriggerEvent):void
		{
			this._timerDone = true;
			this._stopPreloader();
		}
		/*
		Accessors
		*/
		public function set minimumTime( $seconds:Number ):void
		{
			this._timeInSeconds = $seconds;
			this._timeInMilliseconds = this._timeInSeconds * 1000;
			this._useTimer = ( this._timeInSeconds > 0 );
		}
		
		public function set progress( $progress:Number ):void
		{
			var tempProgress:uint = Math.round( $progress * 100 );
			if ( tempProgress > this._loadProgress ) {
				this._loadProgress = tempProgress;
				this._updatePreloader( this._getPercentage() );
			}
		}
		
		public function set preloader( $preloader:IPreloader ):void
		{
			this._preloader = $preloader;
			this._reset();
			this._updatePreloader( 0 );
		}
	}

}
	
