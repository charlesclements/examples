package com.imt.framework.engine.controller
{

	import com.bedrock.framework.plugin.storage.SuperArray;
	import com.demonsters.debugger.MonsterDebugger;
	import com.imt.assets.Assets;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.display.StarlingDisplayer;
	import com.imt.framework.event.StarlingSiteEvent;
	import com.imt.game.GameOverlay;
	
	import flash.system.ApplicationDomain;
	
	import starling.display.Sprite;
	import starling.events.Event;

	
	public class StageController extends Sprite implements IDisplay
	{
		
		
		private var display:StarlingDisplayer
		private var overlay:IDisplay;
		//private var Assets.LEVELS:SuperArray;
		public static const HOME:String = "GameController.HOME";
		public static const STAGE:String = "GameController.STAGE";
		public static const OPTIONS:String = "GameController.OPTIONS";
		
		 
		public function StageController()
		{
			
			trace(this);
			super();
			addEventListener( Event.ADDED_TO_STAGE, _onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			trace(this + " initialize");
			
			
			
			
			Assets.LEVELS = new SuperArray( data.levels );
			Assets.ASSETS_PATH = ( data.assetsPath == null ) ? "" : data.assetsPath;
			// Events.
			StarlingDispatcher.addEventListener( StarlingSiteEvent.ALL_ASSETS_LOADED, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.CHANGE, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.PLAY_GAME, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.BACK_TO_BEGINNING, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NEXT_LEVEL, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NEW_GAME, _onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.QUIT, _onEvent );
			// Displays game content.
			display = new StarlingDisplayer();
			addChild( display );
			// UI overlay.
			overlay = new GameOverlay;
			( overlay as Sprite ).addEventListener( Event.COMPLETE, _onEvent );
			addChild( overlay as Sprite );
			
		}
		
		
		// Functions required by implemented IDisplay.
		public function refresh():void
		{ 
			
			trace(this + " : refresh");
			overlay.refresh();
		
		}
		
		
		public function clear():void{ trace(this + " : clear") };
		public function start():void{ trace(this + " : start") };
		public function intro():void{};
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};
		
		
		private function _doStagesInitializing($e:StarlingSiteEvent=null):void
		{
			
			trace(this + " : _doStagesInitializing" );
			var l:SuperArray = Assets.LEVELS;
			var s:IDisplay = ( l.selectedItem as IDisplay );
			( s as Sprite ).removeEventListener( "InitializeComplete", _doStagesInitializing );
			s = ( l.selectedItem as IDisplay );
			if( ( s as AbstractStarlingDisplay ).initialized == false ) 
			{
				
				//MonsterDebugger.trace( this, "Do INIT : " + l.selectedIndex, "_doStagesInitializing" );
				trace(this + " : _doStagesInitializing - Do INIT" );
				( s as Sprite ).addEventListener( StarlingSiteEvent.INITIALIZE_COMLETE, _doStagesInitializing );
				s.initialize();
				
			}
			else
			{
				
				//MonsterDebugger.trace( this, "Dont do INIT : " + l.selectedIndex, "_doStagesInitializing" );
				//trace(this + " : _doStagesInitializing - Dont do INIT" );
				trace(this + " : _doStagesInitializing - Dont do INIT" );
				( s as Sprite ).removeEventListener( StarlingSiteEvent.INITIALIZE_COMLETE, _doStagesInitializing );
				var num:uint = l.selectedIndex;
				l.selectNext();
				if( num == l.selectedIndex )
				{
					
					Assets.LEVELS.setSelected( 0 );
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.ALL_ASSETS_LOADED ) );
					
				}
				else
				{
					
					_doStagesInitializing()
					
				}
				
			}
			
		}
		
		
		// Handle all the events.
		private function _onEvent(event:Event):void
		{
			
			/*trace("");
			trace("");
			trace("+");
			trace(this + " : " + event.type);*/
			var s:IDisplay;
			switch( event.type )
			{
				
				case StarlingSiteEvent.QUIT:
					s = display.currentDisplay;
					display.change(  );
					s.destroy();
					break;
				
				case StarlingSiteEvent.ALL_ASSETS_LOADED:
					// Show home page.
					break;
				
				case Event.COMPLETE:
					//playGame();
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.ALL_ASSETS_LOADED ) );
					break;
				
				case StarlingSiteEvent.BACK_TO_BEGINNING:
					//display.currentDisplay.clear();
					display.change();
					overlay.clear();
					Assets.LEVELS.setSelected( 0 );
					break;
				
				case StarlingSiteEvent.NEXT_LEVEL:
					s = display.currentDisplay;
					display.change(  );
					s.destroy();
					s = Assets.LEVELS.selectNext();
					_playGame();
					break;
				
				case StarlingSiteEvent.NEW_GAME:
					s = display.currentDisplay;
					display.change(  );
					s.destroy();
					s = Assets.LEVELS.setSelected( 0 );
					overlay.refresh();
					_playGame();
					break;
				
				case StarlingSiteEvent.PLAY_GAME:
					overlay.refresh();
					_playGame();
					break;
				
				case StarlingSiteEvent.CHANGE:
					// Doing nothing right now.
					break;
				
				case starling.events.Event.ADDED_TO_STAGE:
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, _onEvent);
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.READY ) );
					dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.READY ) );
					break;
				/*
				case StarlingSiteEvent.INITIALIZE_COMLETE:
					trace(this + " StarlingSiteEvent.INITIALIZE_COMLETE");
					break;
				*/
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		
		
		private function _playGame($event:Object=null):void
		{
			
			trace(this + " : playGame");
			var s:IDisplay = Assets.LEVELS.getSelected();
			if( ( s as AbstractStarlingDisplay ).initialized )
			{
				
				trace(this + " : playGame : " + ( s as Sprite ).name + " initialized and ready to play." );
				Assets.LEVELS.getSelected().removeEventListener( StarlingSiteEvent.INITIALIZE_COMLETE, _onEvent );
				( overlay as GameOverlay ).removeLoadingScreen();
				display.change( s );
				overlay.refresh();
				overlay.start();
				
			}
			else 
			{
				
				trace(this + " : playGame : " + ( s as Sprite ).name + " not yet initialized, will initialize now." );
				// Add loading graphic here.
				( overlay as GameOverlay ).showLoadingScreen();
				( s as Sprite ).addEventListener( StarlingSiteEvent.INITIALIZE_COMLETE, _playGame );
				s.initialize();
				
			}
			
		}		
		
	}
	
	
}
