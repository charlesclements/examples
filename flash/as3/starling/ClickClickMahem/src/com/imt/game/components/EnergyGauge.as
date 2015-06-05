package com.imt.game.components
{
	
	
	import com.fatbird.utils.NumberFormater;
	import com.fatbird.utils.StopWatch;
	import com.fatbird.plugins.stopwatch.StopWatchFlash;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.imt.assets.Assets;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.event.StarlingSiteEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.computus.model.Timekeeper;
	import org.computus.model.TimekeeperEvent;
	
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	
	// extends GameButton 
	public class EnergyGauge extends AbstractStarlingDisplay implements IDisplay, IAnimatable
	{
		
		private var bg:Image
		private var energy:Image
		
		private var tween:TweenMax;
		//private var timeline:TimelineMax;
	
		//private var timerText:starling.text.TextField = new starling.text.TextField(200,50,"hello");
		//timer variables
	
		private var upCounter:int = 0;
		private var minCounter:int = 0;
		//private var stopwatchflash:StopWatchFlash;
		//private var myTimer:Timer = new Timer(100,0);
		
		//private var timekeeper:Timekeeper;
		
		
		
		//private var startTimer:int = 0;
		private var startTime:int = 0;
		private var endTime:int = 0;
		private var pauseTime:int = 0;
		
		
		public function advanceTime(time:Number):void{};
		
		
		public function EnergyGauge($data:Object=null)
		{
			
			super();	
			data = $data;
			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			if( !initialized )
			{
				
				trace( this + " : initialize" );
				createArtwork();
				//tween = new TweenMax( energy, 15, { scaleY:-0.01, onComplete:onEnergyGaugeComplete, ease:Linear.easeNone } );//y:bg.height - 5, 
				energy.visible = false;
				bg.visible = false;
				// Stopwatch.
				//stopwatchflash = new StopWatchFlash();
				//addChild( stopwatchflash );
				// Everything is initialized. Make it official.
				initialized = true;
				
			}
			
		}
		
		
		private function onEnergyGaugeComplete():void 
		{
			
			trace( this + " : onEnergyGaugeComplete()" );
			energy.visible = false;
			dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.DONE, { id:"EnergyGuage" } ) ); 
			
		}
		
		
		public function refresh():void
		{
			
			trace( this + " : refresh" );
			//StarlingDispatcher.addEventListener( StarlingSiteEvent.BACK_TO_BEGINNING, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.MATCHED_SEQUENCE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NO_MATCH, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.WIN, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.RESUME, onEvent );
			// Timer stuff.
			//timekeeper.addEventListener( TimekeeperEvent., timerHandler );
			
		}
		
		
		public function start():void
		{
			
			trace( this + " : start()" );
			
			
			/*
			//stopwatch.reset();// = new StopWatch();
			stopwatch.startTime = new Date;
			stopwatch.endTime = stopwatch.startTime;
			stopwatch.start();
			trace("Stopwatch : Started time: " + stopwatch.elapsedTime )
			*/
			
			//timekeeper.startTicking();
			
			
			//stopwatchflash.startTimer();
			
			
			/*

			myTimer.addEventListener (TimerEvent.TIMER, timerHandler);
			myTimer.reset();
			myTimer.start();
			startTime = getTimer();
			*/
			
			
		}
		
		
		public function intro():void
		{
			
			trace( this + " : intro : index : " + data.index );
			//TweenMax.to( this, 0.8, { delay:data.index * 0.6, x:data.targX, y:data.targY, scaleX:data.targScaleX, scaleY:data.targScaleY, onComplete:onIntroComplete, ease:Power4.easeOut } );
			//TweenMax.fromTo( this, 0.8, { autoAlpha:0, immediateRender:true }, { delay:data.index * 0.6, autoAlpha:1, x:data.targX, y:data.targY, scaleX:data.targScaleX, scaleY:data.targScaleY, onComplete:onIntroComplete, ease:Power4.easeOut } );
			
		}
		
		
		public function clear():void
		{
			
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.MATCHED_SEQUENCE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.NO_MATCH, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.WIN, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.RESUME, onEvent );
			// Stopwatch.
			//stopwatchflash.stopTimer();
			
		}
		
		
		
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};
		
		
		
		
		
		/*
		//public function timerHandler(event:TimekeeperEvent):void
		public function timerHandler(event:TimerEvent):void
		{
			
			
			
			//timekeeper.getValue()
			
			
			
			
			
			var score:int = 10;//timekeeper.getValue();
			//var score:int = stopwatch.getElapsedTime();
			//var score:int = stopwatch.getSecondsNumber();
			
			
			var scoreFormatted:String = NumberFormater.formatTime( score )
			timerText.text = scoreFormatted;
			
			
			
			
			
			
		}
		*/
		
		
		
		private function onIntroComplete():void
		{
			
			
		}
		
		
		private function onEvent(event:Event):void
		{
			
			// Reusable time variable.
			var t:Number;
			
			switch( event.type )
			{
				
				case StarlingSiteEvent.PAUSE:
					//stopwatchflash.stopTimer();
					break;
				
				case StarlingSiteEvent.RESUME:
					//stopwatchflash.continueTimer();
					break;
				
				case Event.ENTER_FRAME:
					
					break;
				
				case StarlingSiteEvent.WIN:
					trace(this + " : " + event.type);
					//timeline.reverse();
					break;
				
				case StarlingSiteEvent.MATCHED_SEQUENCE:
					//trace(this + " : " + event.type);
					//t = timeline.progress() - ( timeline.totalTime()  / timeline.totalDuration() );
					//timeline.progress( t );
/*					t = tween.progress() - ( tween.totalTime()  / tween.totalDuration() );
					tween.progress( t );*/
					break;
				
				case StarlingSiteEvent.NO_MATCH:
					//trace(this + " : " + event.type);
					// Current position in progress.
					//t = tween.progress() + ( tween.totalTime()  / tween.totalDuration() );
					//tween.progress( t );
					break;
				
				case starling.events.Event.ADDED_TO_STAGE:
					trace(this + " : " + event.type);
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
					initialize();
					break;
				
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		
		
		// Create artwork.
		private function createArtwork():void
		{
			
			trace(this + " : createArtwork");
			// Create new BG image.
			//bg = new Image( Assets.getTextureAtlas( "assets" ).getTexture( "components/energy_guage" ) );
			bg = new Image( Assets.getTextureAtlas( "assets" ).getTexture( "components/energy_guage" ) );
			//bg = new Image( Graphics.getMemoryPlaneAtlas().getTexture( "components/energy_guage" ) );
			addChild( bg );
			//addChild(timerText);
			// Energy bar.
			energy = new Image( Texture.fromBitmap( new Bitmap( new BitmapData( bg.width - 44, bg.height - 44, false, 0x0000ffff ), "auto", true ) ) );
			energy.scaleY = -1;
			energy.x = 22;
			energy.y = bg.height - 22;
			addChild( energy );
			
		}
		
	}
	
}