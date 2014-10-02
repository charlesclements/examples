package com.fatbird.plugins.stopwatch
{
	
	
	//import flash.events.EventDispatcher;
	//import flash.events.IEventDispatcher;
	//import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	//import starling.events.Event;
	//import starling.text.TextField;
	//import starling.text.TextFieldAutoSize;
	
	
	public class StopWatchFlash extends Sprite
	{
		
		public static const STOP:String="STOP";
		public static const START:String="START";
		public static const RESET:String="RESET";
		public static const CURRENT:String="CURRENT";
		public static const PAUSE:String="PAUSE";
		public static const RESUME:String="RESUME";
		
		private var startTime:int;
		private var stopTime:int;
		private var resumeTime:int;
		private var currTime:int;
		private var newTime:int;
		private var mainTimer:Timer = new Timer(100);
		private var timerText:TextField;
		
		
		//public function StopWatchFlash(target:IEventDispatcher=null)
		public function StopWatchFlash()
		{
			
			//super(target);
			super();
			// Textfield.
			timerText = new TextField;//(200,50,"hello");
			timerText.border=true;
			//timerText.alignPivot( "left", "top" );
			//timerText.width=450;
			timerText.width = 400;//stage.stageWidth;//=450;
			timerText.height=60;
			//timerText.x= 10;//300;
			//timerText.y= 10;//10;
			//timerText.fontSize = 48;
			//timerText. = 48;
			timerText.autoSize = TextFormatAlign.LEFT;
			addChild(timerText);
			// Timer stuff.
			updateTime();
			mainTimer.addEventListener(TimerEvent.TIMER, updateTime);
			
		}
		

		private function updateTime(TimerEvent=null):void
		{
			
			currTime = getTimer();
			newTime = currTime - startTime;
			timerText.text = "Time: "+ String( newTime );
			
		}
		
		
		public function startTimer():void
		{
			
			startTime = getTimer();
			mainTimer.start();
			dispatchEvent( new Event( START ) );
			
		}

		
		public function stopTimer():void
		{
			
			stopTime = getTimer();
			mainTimer.stop();
			//dispatchEvent( StopWatchFlash.STOP );
			dispatchEvent( new Event( STOP ) );
			
		}
		
		
		public function resetTimer():void
		{
			
			startTime = getTimer();
			updateTime();
			dispatchEvent( new Event( RESET ) );
			
		}
		
		public function continueTimer():void
		{
			
			resumeTime = getTimer();
			startTime += resumeTime - stopTime;
			mainTimer.start();
			dispatchEvent( new Event( RESUME ) );
			
		}
		
	}
	
}