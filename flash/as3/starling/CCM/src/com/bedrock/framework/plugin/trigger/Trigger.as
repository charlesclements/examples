package com.bedrock.framework.plugin.trigger
{
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.plugin.util.TimeUtil;
	
	import flash.utils.*;

	public class Trigger extends DispatcherBase
	{
		/*
		Variable Declarations
		*/
		public var silenceLogging:Boolean;
		
		private var _timerID:int;
		
		private var _intervalID:int;
		private var _intervalRepetitions:int;
		private var _intervalCount:int;
		
		private var _stopwatchID:int;
		private var _stopwatchStart:uint;
		private var _stopwatchEnd:uint;
		private var _stopwatchDifference:uint;
		/*
		Constructor
	 	*/
	 	public function Trigger()
		{
			this.silenceLogging = false;
			this._timerID = -1;
			this._intervalID = -1;
			this._stopwatchID = -1;
			super();
		}
		/*
		Timer
		*/
		public function startTimer( $seconds:Number ):void
		{
			if ( !this.timerRunning ) {
				this.status("Start Timer");
				this._timerID = setTimeout( this._timerTrigger, $seconds * 1000 );
				this.dispatchEvent( new TriggerEvent( TriggerEvent.TIMER_START, this ) );
			}
		}
		public function stopTimer():void
		{
			if ( this.timerRunning ) {
				this.status( "Stop Timer" );
				clearTimeout(this._timerID);
				this._timerID = -1;
				this.dispatchEvent( new TriggerEvent(TriggerEvent.TIMER_STOP, this ) );
			}
		}
		private function _timerTrigger():void
		{
			this.dispatchEvent( new TriggerEvent( TriggerEvent.TIMER_TRIGGER, this));
			this.stopTimer();
		}
		/*
		Interval
		*/
		public function startInterval( $seconds:Number, $repetitions:int = -1):void
		{
			if ( !this.intervalRunning ) {
				this._intervalID = setInterval( this._intervalTrigger, $seconds * 1000 );
				this._intervalRepetitions = $repetitions;
				this._intervalCount = 0;
				this.dispatchEvent(new TriggerEvent(TriggerEvent.INTERVAL_START, this ) );
				this.status("Start Interval");
			}
		}
		public function stopInterval():void
		{
			if ( this.intervalRunning ) {
				clearInterval( this._intervalID );
				this._intervalCount = 0;
				 this._intervalID = -1;
				this.dispatchEvent(new TriggerEvent(TriggerEvent.INTERVAL_STOP, this, { loops:this._intervalRepetitions } ) );
				this.status("Stop Interval");
			}			
		}
		private function _intervalTrigger():void
		{
			this.dispatchEvent( new TriggerEvent( TriggerEvent.INTERVAL_TRIGGER, this, { index:this._intervalCount, repetitions:this._intervalRepetitions } ) );
			this._intervalCount++;
			if (this._intervalRepetitions > 0) {
				if (this._intervalCount >= this._intervalRepetitions) {
					this.stopInterval();
				}
			}
		}
		/*
		Stopwatch
		*/
		public function startStopwatch( $updateInterval:Number = 0.5 ):void
		{
			if ( !this.stopwatchRunning ){
				this.status("Start Stopwatch");
				this.clearStopwatch();
				this.dispatchEvent(new TriggerEvent( TriggerEvent.STOPWATCH_START, this) );
				this._stopwatchStart = getTimer();
				this._stopwatchID = setInterval( this._updateStopwatch, ( $updateInterval * 1000 ) );
			}
		}
		/*
		Stop the timer
		*/
		public function stopStopwatch():Object
		{
			if (this.stopwatchRunning) {
				clearInterval(this._stopwatchID);
				this._stopwatchID = -1;
				this.status("Stop Stopwatch" );
				this.dispatchEvent( new TriggerEvent(TriggerEvent.STOPWATCH_STOP, this, this.elapsed) );
				return this.elapsed;
			}
			return null;
		}
		/*
		Clear the timer
		*/
		public function clearStopwatch():void
		{
			this._stopwatchID = -1;
			this._stopwatchStart = 0;
			this._stopwatchEnd = 0;
			this._stopwatchDifference = 0;
		}
		/*
		Update difference
		*/
		private function _refreshStopwatch():void
		{
			if ( this.stopwatchRunning ) this._stopwatchEnd = getTimer();
			this._stopwatchDifference = (this._stopwatchEnd - this._stopwatchStart);
		}
		private function _updateStopwatch():void
		{
			this.dispatchEvent( new TriggerEvent( TriggerEvent.STOPWATCH_TRIGGER, this, this.elapsed ) );
		}
		
		override public function status( $trace:* ) :String
		{
			if ( !this.silenceLogging ) {
				return super.status( $trace );
			}
			return null;
		}
	 	/*
		Accessors
	 	*/
		public function get elapsed():Object
		{
			this._refreshStopwatch();
			return TimeUtil.parseMilliseconds(this._stopwatchDifference);
		}
		public function get elapsedMilliseconds():uint
		{
			this._refreshStopwatch();
			return this._stopwatchDifference;
		}
		public function get intervalRunning():Boolean
		{
			return ( this._intervalID != -1 );
		}
		public function get timerRunning():Boolean
		{
			return ( this._timerID != -1 );
		}
		public function get stopwatchRunning():Boolean
		{
			return ( this._stopwatchID != -1 );
		}
		
	}
}