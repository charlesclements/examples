package com.fatbird.plugins.stopwatch
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.fatbird.utils.NumberFormater;
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
		private var startTime:int;
		private var stopTime:int;
		private var resumeTime:int;
		private var currTime:int;
		private var newTime:int;
		private var mainTimer:Timer = new Timer(100);
		private var timerTextValue:TextField;
		private var timerTextLabel:TextField;
		private var bestTimeTextLabel:TextField;
		private var bestTimeTextValue:TextField;
		private var holder:Sprite;
		
		
		//public function StopWatchStarling(target:IEventDispatcher=null)
		public function StopWatchStarling()
		{
			
			//trace("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			trace(this);
			///super(target);
			super();
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
			
			
			
			//MonsterDebugger.trace( this, Fonts.getFont( "NeoFont2-ipadhd" ) );
			//trace( Fonts.getFont( "NeoFont2-ipadhd" ) );
			
		//	Fonts.createFont( "NeoFont2-ipadhd", Assets.getBitmap( "NeoFont2-ipadhd.png" ), Assets.getXML( "NeoFont2-ipadhd.fnt" ) );
			
			
			
			
			timerTextLabel = new TextField( 200, h, "Time:", "Game-Bold", s, 0xffffff );
			holder.addChild( timerTextLabel );
			with( timerTextLabel )
			{
				
				//border = true;
				//width = 400;
				//height=60;
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
				
				//border = true;
				//width = 400;
				//height = 60;
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
				//x = timerTextValue.x + 150;
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
			//timerText.text = "Time: "+ String( newTime );
			//timerText.text = String( newTime );
			var s:String = com.fatbird.utils.NumberFormater.formatTime( newTime );
			timerTextValue.text = s;
			//trace( s );
			
		}
		
		
		public function startTimer():void
		{
			
			//trace("startTimer ++++++++++");
			startTime = getTimer();
			mainTimer.start();
			holder.visible = true;
			dispatchEvent( new starling.events.Event( START ) );
			
		}

		
		public function stopTimer():void
		{
			
			stopTime = getTimer();
			mainTimer.stop();
			holder.visible = false;
			//dispatchEvent( StopWatchStarling.STOP );
			dispatchEvent( new starling.events.Event( STOP ) );
			
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
		
		
	}
	
}