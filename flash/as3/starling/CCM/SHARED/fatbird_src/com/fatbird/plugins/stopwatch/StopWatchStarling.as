package com.fatbird.plugins.stopwatch
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.fatbird.utils.NumberFormater;
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.imt.assets.Assets;
	import com.imt.assets.fonts.Fonts;
	import com.imt.framework.engine.data.GameData;
	
	import flash.events.TimerEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	
	public class StopWatchStarling extends Sprite
	{
		
		public static const STOP:String="StopWatch.onStop";
		public static const START:String="StopWatch.onStart";
		public static const RESET:String="StopWatch.onReset";
		public static const CURRENT:String="StopWatch.onCurrent";
		public static const PAUSE:String="StopWatch.onPause";
		public static const RESUME:String="StopWatch.onResume";
		public static const TIMER_COMPLETE:String="StopWatch.onTimerComplete";
		private var startTime:int;
		private var stopTime:int;
		private var resumeTime:int;
		private var currTime:int;
		private var newTime:int;
		private var _countDownTime:int;
		private var mainTimer:Timer = new Timer(100);
		private var countdownTimer:Timer = new Timer(100);
		private var timerTextValue:TextField;
		private var timerTextLabel:TextField;
		private var bestTimeTextLabel:TextField;
		private var bestTimeTextValue:TextField;
		private var holder:Sprite;
		private var blinkTween:TimelineMax;
		
		
		//public function StopWatchStarling(target:IEventDispatcher=null)
		public function StopWatchStarling()
		{
			
			trace(this);
			super();
			
			// Setup blinking.
			blinkTween = new TimelineMax( { repeat:-1} );
			
			// Holder.
			holder = new Sprite;
			addChild( holder );
			holder.visible = false;
			holder.x = 75;
			
			// Vars.
			var s:int = 40;
			var h:int = 60;
			var _y:int = 10;
			
			// Label.
			timerTextLabel = new TextField( 200, h, "Time:", "Game-Bold", s, 0xffffff );
			holder.addChild( timerTextLabel );
			
			with( timerTextLabel )
			{
				
				x = 10;//300;
				y = _y;
				//fontSize = 40;
				autoSize = TextFormatAlign.LEFT;
				hAlign = HAlign.LEFT;
				
			}

			// Value.
			timerTextValue = new TextField( 500, h, "", "Game-Med", s, 0xffffff );
			holder.addChild( timerTextValue );
			with( timerTextValue )
			{
				
				x = 130;//300;
				y = _y;
				//fontSize = 40;
				autoSize = TextFormatAlign.LEFT;
				hAlign = HAlign.LEFT;
				
			}
			
			
			// Best time label.
			bestTimeTextLabel = new TextField( 400, h, "", "Game-Bold", s, 0xffffff );
			addChild(bestTimeTextLabel);
			with( bestTimeTextLabel )
			{
				
				//border = true;
				hAlign = HAlign.LEFT;
				//width = 400;//stage.stageWidth;//=450;
				//height=60;
				x = GameData.STAGE_WIDTH - width;//500;//300;
				y = _y;
				//fontSize = 40;
				//autoSize = TextFormatAlign.LEFT;
				
			}
			
			// Best time value.
			bestTimeTextValue = new TextField( 400, h, "", "Game-Med", s, 0xffffff );
			addChild(bestTimeTextValue);
			with( bestTimeTextValue )
			{
				
				//border = true;
				hAlign = HAlign.LEFT;
				//width = 400;//stage.stageWidth;//=450;
				//height=60;
				//x = GameData.STAGE_WIDTH - width - 35;//500;//300;
				x = bestTimeTextLabel.x + 210;//500;//300;
				y = _y;
				//fontSize = 40;
				//autoSize = TextFormatAlign.LEFT;
				
			}
			// Timer stuff.
			mainTimer.addEventListener(TimerEvent.TIMER, updateTime);
			
		}
		

		private function updateTime(TimerEvent=null):void
		{
			
			currTime = getTimer();
			newTime = currTime - startTime;
			//var s:String = com.fatbird.utils.NumberFormater.formatTime( newTime );
			var s:String = com.fatbird.utils.NumberFormater.formatTime( newTime, "", false, true, true, true );
			timerTextValue.text = s;
			
		}
		
		
		public function startTimer(countDownTime:int = -1):void
		{
			
			if( countDownTime > 0 )
			{
				
				_countDownTime = countDownTime;
				countdownTimer = new Timer( countDownTime );
				countdownTimer.addEventListener(TimerEvent.TIMER, _countdownTimerHandler);
				countdownTimer.start();
				
				
			}
			
			startTime = getTimer();
			mainTimer.start();
			holder.visible = true;
			dispatchEvent( new starling.events.Event( START ) );
			
		}
		
		
		
		
		public function _countdownTimerHandler(e:TimerEvent):void
		{
			
			trace( this + " : _countdownTimerHandler");
			
			//currTime = getTimer();
			//newTime = currTime - startTime;
			//var s:String = com.fatbird.utils.NumberFormater.formatTime( newTime );
			
			
			stopTimer();
			holder.visible = true;
			var s:String = com.fatbird.utils.NumberFormater.formatTime( _countDownTime, "", false, true, true, true );
			timerTextValue.text = s;
			
			blink( true, 5 );
			
			dispatchEvent( new starling.events.Event( TIMER_COMPLETE ) );
			
		}

		
		public function stopTimer():void
		{
			
			stopTime = getTimer();
			mainTimer.stop();
			countdownTimer.stop();
			holder.visible = false;
			//dispatchEvent( StopWatchStarling.STOP );
			dispatchEvent( new starling.events.Event( STOP ) );
			//updateTime();
			
		}
		
		
		public function resetTimer():void
		{
			
			startTime = getTimer();
			holder.visible = true;
			updateTime();
			dispatchEvent( new starling.events.Event( RESET ) );
			
		}
		
		
		public function continueTimer():void
		{
			
			trace("continueTimer");
			resumeTime = getTimer();
			startTime += resumeTime - stopTime;
			mainTimer.start();
			countdownTimer.start();
			holder.visible = true;
			dispatchEvent( new starling.events.Event( RESUME ) );
			
		}
		
		
		public function getTime():int
		{
			
			trace("getTime");
			return newTime;
			
		}
		
		
		public function setDiplayTime(n:int):void
		{
			
			trace("setDiplayTime: " + n);
			timerTextValue.text = String( n );
			
		}
		
		
		public function setBestTime(n:int):void
		{
			
			trace("setBestTime: " + n);
			// Label.
			bestTimeTextLabel.text = "Best Time:"
			bestTimeTextLabel.redraw();
			// Value.
			var s:String = com.fatbird.utils.NumberFormater.formatTime( n );
			bestTimeTextValue.text = s;
			bestTimeTextValue.redraw();
			// Visible.
			bestTimeTextLabel.visible = ( n>0 );
			bestTimeTextValue.visible = ( n>0 );
			
		}
		
		
		
		public function blink(doBlinking:Boolean=true, repeat:int=-1):void
		{
			
			trace(this + " : blink : "  + doBlinking );
			
			if( doBlinking )
			{
				
				blinkTween.clear();
				
				//TweenMax.to( this, 0, { alpha:0 } );
				
				
				blinkTween = new TimelineMax( { repeat:repeat} );
				var arr:Array = [];
				
				//var X:int = x;
				
				arr.push( new TweenMax( this, 0, { delay:0.5, alpha:0 } ) );
				arr.push( new TweenMax( this, 0, { delay:0.5, alpha:1 } ) );
				//arr.push( new TweenMax( this, 0, { delay:0, alpha:1 } ) );
/*				arr.push( new TweenMax( this, 0.2, { delay:0.5, x:X + 15 } ) );
				arr.push( new TweenMax( this, 0.2, { delay:0.05, x:X } ) );*/
				blinkTween.appendMultiple( arr, 0, TweenAlign.SEQUENCE );
				
				blinkTween.play( 0 );
				
			}
			else
			{
				
				blinkTween.gotoAndStop( 0 );
				blinkTween.clear();
				
			}
			
			
			
		}
		
		
	}
	
}