package com.imt.game
{
	
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.fatbird.plugins.stopwatch.StopWatchStarling;
	import com.greensock.TweenMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	import com.imt.assets.Assets;
	import com.imt.assets.fonts.Fonts;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.FastStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.display.StarlingDisplayer;
	import com.imt.framework.display.button.GameButton;
	import com.imt.framework.display.view.PauseView;
	import com.imt.framework.engine.data.GameData;
	import com.imt.framework.event.StarlingSiteEvent;
	import com.imt.framework.gadget.ios.gamecenter.GameCenterGadget;
	import com.imt.framework.gadget.text.BlinkingText;
	import com.imt.framework.gadget.text.TemporaryText;
	import com.imt.game.gadgets.GamePlay;
	
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class GameOverlay extends AbstractStarlingDisplay implements IDisplay
	{
		
		
		private var splashPage:Image;
		//private var energyGuage:IDisplay;
		private var _defaultLoadingGraphic:IDisplay;
		private var _pauseView:IDisplay;
		// Buttons.
		private var instructionsButton:GameButton;
		//private var backButton:GameButton;
		private var showGamecenter:GameButton;
		private var startButton:GameButton;
		private var clearButton:GameButton;
		private var readyGraphic:Image;
		private var playButton:GameButton;
		private var playAgainButton:GameButton;
		private var aboutButton:GameButton;
		private var quitButton:GameButton;
		private var nextLevelButton:GameButton;
		private var newGameButton:GameButton;
		// Text.
		private var textHolder:StarlingDisplayer;
		private var textLose:TemporaryText;
		private var textWin:TemporaryText;
		private var textMatch:TemporaryText;
		private var textNoMatch:TemporaryText;
		// Vocals.
		private var matchedVocals:Array;
		private var assets:Assets;
		// Game
		private var gamePlay:IDisplay;
		//
		private var _isWinner:Boolean = false;
		private var _gamecenter:GameCenterGadget;
		private var stopwatch:StopWatchStarling;
		private var textNewBestTime:BlinkingText;
		
		
		public function GameOverlay()
		{
			
			super();
			trace(this)
			name = "GameOverlay";
			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			StarlingDispatcher.addEventListener( StarlingSiteEvent.START_GAME, onEvent);
			StarlingDispatcher.addEventListener( StarlingSiteEvent.BACK_TO_BEGINNING, onEvent);
			
		}
		
		
		public function initialize($data:Object=null):void
		{
			
			if( !initialized )
			{
				
				trace(this + " : initialize()")
				// AssetEngine.
				Assets.createLoader( name );
				
				
				
				
				var path:String = Assets.ASSETS_PATH + "media/graphics/games/ccm/";
				Assets.appendXML( name, new XMLLoader( path + "new-assets.xml", {  } ), "new-assets.xml" );
				Assets.appendTexture( name, new ImageLoader( path + "new-assets.png", {  } ), "new-assets.png" );
				
				/*				
				var path:String = Assets.ASSETS_PATH + "media/graphics/games/memory_plane_game/";
				Assets.appendXML( name, new XMLLoader( path + "assets.xml", {  } ), "assets.xml" );
				Assets.appendTexture( name, new ImageLoader( path + "assets.png", {  } ), "assets.png" );
				*/
				
				
				
				
				
				
				// Audio
				path = Assets.ASSETS_PATH + "media/sounds/memory_game/";
				Assets.appendSfx( name, new MP3Loader( path + "music/NewIntroMusic.mp3", { autoPlay:false, volume:0.6, repeat:-1 } ), "BG_MUSIC" );
				//Assets.appendSfx( name, new MP3Loader( path + "music/BG_music_loop_103bpm.mp3", { autoPlay:false, volume:0.6, repeat:-1 } ), "BG_MUSIC" );
				Assets.appendSfx( name, new MP3Loader( path + "ui/match.mp3", { autoPlay:false, volume:0.8 } ), "MATCH_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "ui/no_match.mp3", { autoPlay:false, volume:0.65 } ), "NO_MATCH_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "ui/touch.mp3", { autoPlay:false } ), "SELECT_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "ui/access_granted.mp3", { autoPlay:false } ), "ACCESS_GRANTED" );
				
				// Fonts
				path = Assets.ASSETS_PATH + "media/fonts/bitmap/";//
				// Light
				Assets.appendXML( name, new XMLLoader( path + "Game-Light-ipad.fnt", {  } ), "Game-Light-ipad.fnt" );
				Assets.appendTexture( name, new ImageLoader( path + "Game-Light-ipad.png", {  } ), "Game-Light-ipad.png" );
				// Reg
				Assets.appendXML( name, new XMLLoader( path + "Game-Reg-ipad.fnt", {  } ), "Game-Reg-ipad.fnt" );
				Assets.appendTexture( name, new ImageLoader( path + "Game-Reg-ipad.png", {  } ), "Game-Reg-ipad.png" );
				// Med
				Assets.appendXML( name, new XMLLoader( path + "Game-Med-ipad.fnt", {  } ), "Game-Med-ipad.fnt" );
				Assets.appendTexture( name, new ImageLoader( path + "Game-Med-ipad.png", {  } ), "Game-Med-ipad.png" );
				// Bold
				Assets.appendXML( name, new XMLLoader( path + "Game-Bold-ipad.fnt", {  } ), "Game-Bold-ipad.fnt" );
				Assets.appendTexture( name, new ImageLoader( path + "Game-Bold-ipad.png", {  } ), "Game-Bold-ipad.png" );
				
				
				
				/*
				path = Assets.ASSETS_PATH + "media/sounds/memory_game/plane/";//
				Assets.appendSfx( name, new MP3Loader( path + "plane_idle.mp3", { autoPlay:false, repeat:-1  } ), "PLANE_IDLE_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "plane_engine_running.mp3", { autoPlay:false } ), "PLANE_ENGINE_RUNNING_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "plane_coasting.mp3", { autoPlay:false, repeat:-1 } ), "PLANE_COASTING_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "plane_outro_sputters.mp3", { autoPlay:false } ), "PLANE_OUTRO_SPUTTERS_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "plane_flies_off.mp3", { autoPlay:false } ), "PLANE_FLIES_OFF_SND" );
				
				path = "media/sounds/memory_game/voice/";//Assets.ASSETS_PATH + 
				Assets.appendSfx( name, new MP3Loader( path + "good_job_44100.mp3", { autoPlay:false } ), "VOICE_GOOD_JOB_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "awww.mp3", { autoPlay:false } ), "VOICE_AWWW_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "come_on.mp3", { autoPlay:false } ), "VOICE_COME_ON_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "lets_do_it.mp3", { autoPlay:false } ), "VOICE_LETS_DO_IT_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "match_the_cards.mp3", { autoPlay:false } ), "VOICE_MATCH_THE_CARDS_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "neos_world.mp3", { autoPlay:false } ), "VOICE_NEOS_WORLD_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "oh_wow.mp3", { autoPlay:false } ), "VOICE_OH_WOW_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "okay.mp3", { autoPlay:false } ), "VOICE_OKAY_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "play_with_me.mp3", { autoPlay:false } ), "VOICE_PLAY_AGAIN_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "neos_world.mp3", { autoPlay:false } ), "VOICE_PLAY_WITH_ME_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "play.mp3", { autoPlay:false } ), "VOICE_PLAY_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "ready.mp3", { autoPlay:false } ), "VOICE_READY_SND" );
				Assets.appendSfx( name, new MP3Loader( path + "wow.mp3", { autoPlay:false } ), "VOICE_WOW_SND" );
				
				*/
				
				// Finalize Assets.
				StarlingDispatcher.addEventListener( StarlingSiteEvent.ASSETS_LOADED, _onAssetsReady );
				Assets.load( name );
				
			}
			
		}
		
		
		public function refresh():void
		{
			
			trace(this + " : refresh()");
			// Stopwatch.
			stopwatch.addEventListener( StopWatchStarling.START, onEvent );
			stopwatch.addEventListener( StopWatchStarling.STOP, onEvent );
			stopwatch.addEventListener( StopWatchStarling.PAUSE, onEvent );
			stopwatch.addEventListener( StopWatchStarling.RESUME, onEvent );
			// Events.
			playButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			playAgainButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			nextLevelButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			newGameButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			// Global events.
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NEW_BEST_TIME, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.LOSE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.WIN, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NO_MATCH, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.MATCHED_SEQUENCE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.MATCHED, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.CARDS_MATCHED, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.DONE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.PLAY_GAME, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.RESUME, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.SCORE_LOADED, onEvent );
			( gamePlay as Sprite ).addEventListener( StarlingSiteEvent.CARD_TOUCHED, onEvent );
			//StarlingDispatcher.addEventListener( StarlingSiteEvent.START_GAME, onEvent );
			// Visiblity.
			playButton.visible = false;
			//aboutButton.visible = false;
			playAgainButton.visible = false;
			nextLevelButton.visible = false;
			nextLevelButton.blink( false );
			newGameButton.visible = false;
			textLose.visible = false;
			textWin.visible = false;
			textMatch.visible = false;
			textNoMatch.visible = false;
			//textNewBestTime.visible = false;
			
			
			
			
			
			
			
			// Do ready vocal.
			//Assets.getSfx( "VOICE_READY_SND" ).gotoSoundTime( 0, true );
			/*
			// Tween.
			TweenMax.to( readyGraphic, 0, { autoAlpha:0 } );
			TweenMax.to( readyGraphic, 0.6, { autoAlpha:1, delay:0.5, onComplete:readyGraphicComplete } );
			TweenMax.to( readyGraphic, 0.6, { autoAlpha:0, delay:2 } );
			*/
		}
		
		
		public function clear():void
		{
			
			trace(this + " : clear()");
			// Stopwatch.
			stopwatch.removeEventListener( StopWatchStarling.START, onEvent );
			stopwatch.removeEventListener( StopWatchStarling.STOP, onEvent );
			stopwatch.removeEventListener( StopWatchStarling.PAUSE, onEvent );
			stopwatch.removeEventListener( StopWatchStarling.RESUME, onEvent );
			// Events.
			playButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			//aboutButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			playAgainButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			nextLevelButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			//quitButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			// Global events.
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.LOSE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.WIN, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.NO_MATCH, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.CARDS_MATCHED, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.MATCHED, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.MATCHED_SEQUENCE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.DONE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.PLAY_GAME, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.RESUME, onEvent );
			( gamePlay as Sprite ).removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			// Clear tweens.
			TweenMax.killTweensOf( readyGraphic );
			// Visiblity.
			playButton.visible = false;
			//aboutButton.visible = false;
			// Text.
			textLose.visible = false;
			textWin.visible = false;
			textMatch.visible = false;
			textNoMatch.visible = false;
			// Clear gadgets.
			gamePlay.clear();
			// Stopwatch.
			stopwatch.stopTimer();
			
		}
		
		
		public function start():void
		{
			
			trace(this + " : start()");
			// Tween.
			TweenMax.to( readyGraphic, 0, { autoAlpha:0 } );
			TweenMax.to( readyGraphic, 0.6, { autoAlpha:1, delay:0.5, onComplete:readyGraphicComplete } );
			TweenMax.to( readyGraphic, 0.6, { autoAlpha:0, delay:2 } );
			
		}
		
		
		public function intro():void{};
		
		
		public function outro():void
		{
			
			// Anime.
			//function onSayPlayAgain():void { Assets.getSfx( "VOICE_PLAY_AGAIN_SND" ).gotoSoundTime( 0, true ) };
			//TweenMax.delayedCall( 3, onSayPlayAgain );
			// Play Again.
			//playAgainButton.visible = true; 
			TweenMax.to( playAgainButton, 0, { autoAlpha:0 } );
			TweenMax.to( playAgainButton, 0.25, { delay:2, autoAlpha:1 } );
			//playAgainButton.blink();
			// Play Again.
			//newGameButton.visible = true; 
			TweenMax.to( newGameButton, 0, { autoAlpha:0 } );
			TweenMax.to( newGameButton, 0.25, { delay:2, autoAlpha:1 } );
			//newGameButton.blink();
			// Add condition here that dictates what button get seen.
			if( _isWinner && Assets.LEVELS.length > 1 && Assets.LEVELS.selectedIndex != Assets.LEVELS.lastIndex )
			{
				
				//nextLevelButton.visible = true; 
				TweenMax.to( nextLevelButton, 0, { autoAlpha:0 } );
				TweenMax.to( nextLevelButton, 0.25, { delay:2, autoAlpha:1 } );
				nextLevelButton.blink();
				//TweenMax.delayedCall( 0.5, nextLevelButton.blink );
				
			}
			// Quit.
			// Does the following actually in use? 
			// Needs to be added to the stage in the creation of the button.
			//quitButton.visible = true;
			
		}
		
		
		public function cancel():void{};
		public function destroy():void{};
		
		
		protected function _onAssetsReady(event:StarlingSiteEvent):void
		{
			
			if( event.data.name == name )
			{
				
				trace("");
				trace(this + " : _onAssetsReady " + event.type + " : " + event.data.name);
				Assets.getSfx( "BG_MUSIC" ).gotoSoundTime( 0, true );
				//Assets.getSfx( "VOICE_NEOS_WORLD_SND" ).gotoSoundTime( 0, true );
				StarlingDispatcher.removeEventListener( StarlingSiteEvent.ASSETS_LOADED, _onAssetsReady );
				Assets.createTextureAtlas( "assets", Assets.getTexture( "new-assets.png" ), Assets.getXML( "new-assets.xml" )  );
				var atlas:TextureAtlas = Assets.getTextureAtlas( "assets" );
				// Sounds.
				matchedVocals = [];
				/*
				matchedVocals.push( Assets.getSfx( "VOICE_OKAY_SND" ) );	
				matchedVocals.push( Assets.getSfx( "VOICE_LETS_DO_IT_SND" ) );
				matchedVocals.push( Assets.getSfx( "VOICE_PLAY_WITH_ME_SND" ) );
				matchedVocals.push( Assets.getSfx( "VOICE_WOW_SND" ) );
				*/
				
				Fonts.createFont( "Game-Light", Assets.getBitmap( "Game-Light-ipad.png" ), Assets.getXML( "Game-Light-ipad.fnt" ) );
				Fonts.createFont( "Game-Reg", Assets.getBitmap( "Game-Reg-ipad.png" ), Assets.getXML( "Game-Reg-ipad.fnt" ) );
				Fonts.createFont( "Game-Med", Assets.getBitmap( "Game-Med-ipad.png" ), Assets.getXML( "Game-Med-ipad.fnt" ) );
				Fonts.createFont( "Game-Bold", Assets.getBitmap( "Game-Bold-ipad.png" ), Assets.getXML( "Game-Bold-ipad.fnt" ) );
				
				// Splash page.
				//splashPage = new Image( Assets.getTexture( "SplashPage" ) );
				//splashPage = new Image( atlas.getTexture( "splash_page/MemoryPlane" ) );
				splashPage = new Image( Texture.fromColor( 1024, 748, 0x333333 ) );
				
				
				
				
				
				
				
				
				addChild( splashPage );
				// Instructions.
				instructionsButton = new GameButton( { id:"instructionsButton" }, Texture.fromColor( 300, 300, 0xCCCCCC, true, 1 ) );
				instructionsButton.x = 100;//GameData.STAGE_WIDTH - startButton.width - 25;
				instructionsButton.y = 220;
				instructionsButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
				instructionsButton.blink();
				instructionsButton.visible = true;
				addChild( instructionsButton );
				
				
				
				// Start button.
				//startButton = new GameButton( { id:"startButton" }, Assets.getTextureAtlas( "memory_plane" ).getTexture( "text/play_game" ) );
				//startButton = new GameButton( { id:"startButton" }, atlas.getTexture( "text/play_game" ) );
				startButton = new GameButton( { id:"startButton" }, atlas.getTexture( "play-game0000" ) );
				startButton.x = GameData.STAGE_WIDTH - startButton.width - 25;
				startButton.y = 500;
				startButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
				startButton.blink();
				addChild( startButton );
				
				//Clear Score button
				clearButton = new GameButton( { id:"clearButton" }, Texture.fromBitmapData( new BitmapData( 25, 25, false, 0xff0000 ) ) );
				clearButton.x = GameData.STAGE_WIDTH / 2 - 150;// - startButton.width;// - 25;
				clearButton.y = 70;
				clearButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
				//addChild( clearButton );
				
				showGamecenter = new GameButton( { id:"showGamecenter" }, Texture.fromBitmapData( new BitmapData( 25, 25, false, 0xffff00 ) ) );
				showGamecenter.x = GameData.STAGE_WIDTH / 2 - 150;// - startButton.width;// - 25;
				showGamecenter.y = 100;
				showGamecenter.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
				//addChild( showGamecenter );
				
				
				
				
				
				
				// Ready.
				readyGraphic = new Image( atlas.getTexture( "ready0000" ) );
				readyGraphic.x = ( GameData.STAGE_WIDTH / 2 ) - ( readyGraphic.width / 2 );
				readyGraphic.y = ( GameData.STAGE_HEIGHT / 2 ) - ( readyGraphic.height / 2 ) - 100;
				readyGraphic.visible = false;
				addChild( readyGraphic );
				// PlayButton.
				playButton = new GameButton( { id:"PlayButton" }, atlas.getTexture( "play-game0000" ) );
				playButton.x = ( GameData.STAGE_WIDTH / 2 ) - ( playButton.width / 2 );
				playButton.y = 300;
				playButton.visible = false;
				addChild( playButton );
				// PlayAgainButton.
				//playAgainButton = new GameButton( { id:"PlayAgainButton" }, Assets.getTextureAtlas( "game_text" ).getTexture( "play_again" ) );
				playAgainButton = new GameButton( { id:"PlayAgainButton" }, atlas.getTexture( "play-again0000" ) );
				playAgainButton.x = 400;//( GameData.STAGE_WIDTH * 0.25 ) - ( playButton.width / 2 );
				playAgainButton.y = 310;
				playAgainButton.visible = false;
				addChild( playAgainButton );
				// PlayAgainButton.
				//playAgainButton = new GameButton( { id:"PlayAgainButton" }, Assets.getTextureAtlas( "game_text" ).getTexture( "play_again" ) );
				//newGameButton.x = ( GameData.STAGE_WIDTH * 0.25 ) - ( newGameButton.width / 2 );
				newGameButton = new GameButton( { id:"NewGameButton" }, atlas.getTexture( "new-game0000" ) );
				newGameButton.x = 10;
				newGameButton.y = 310;
				newGameButton.visible = false;
				addChild( newGameButton );
				
				
				
				/*
				// NextLevelButton.
				//nextLevelButton = new GameButton( { id:"NextLevelButton" }, Assets.getTextureAtlas( "game_text" ).getTexture( "next_level" ) );
				//nextLevelButton.x = ( GameData.STAGE_WIDTH * 0.75 ) - ( nextLevelButton.width / 2 );
				nextLevelButton = new GameButton( { id:"NextLevelButton" }, atlas.getTexture( "next-level0000" ) );
				nextLevelButton.x = GameData.STAGE_WIDTH - nextLevelButton.width - 10;
				nextLevelButton.y = 310;
				nextLevelButton.visible = false;
				addChild( nextLevelButton );
				*/
				/*
				// AboutButton.
				aboutButton = new GameButton( { id:"AboutButton" }, atlas.getTexture( "ui/AboutButton" ) );
				aboutButton.x = ( GameData.STAGE_WIDTH / 2 ) - ( aboutButton.width / 2 );
				aboutButton.y = 450;
				aboutButton.visible = false;
				//addChild( aboutButton )
				// Quit button.
				quitButton = new GameButton( { id:"QuitButton" }, atlas.getTexture( "ui/QuitButton" ) );
				quitButton.x = ( GameData.STAGE_WIDTH / 2 ) - ( quitButton.width / 2 );
				quitButton.y = 400;
				*/
				
				
				//quitButton.visible = false;
				//addChild( quitButton ); // Never added to stage.
				// Anything text related should go in here.
				textHolder = new StarlingDisplayer();
				addChild( textHolder );
				trace("+");
				// Create
				textWin = new TemporaryText( atlas.getTexture( "win0000" ) );
				trace("+");
				textLose = new TemporaryText( atlas.getTexture( "try-again0000" ) );
				trace("+");
				//textMatch = new TemporaryText( atlas.getTexture( "match0000" ) );
				//textNoMatch = new TemporaryText( atlas.getTexture( "no_match0000" ) );
				textNewBestTime = new BlinkingText( atlas.getTexture( "new-best-time0000" ) );
				// Add to stage.
				textHolder.addChild( textWin as Sprite );
				textWin.visible = false;
				textWin.refresh();
				textWin.y = 60;
				textHolder.addChild( textLose as Sprite );
				trace("+");
				textLose.visible = false;
				textLose.refresh();
				textLose.y = 200;
				textHolder.addChild( textMatch as Sprite );
				textMatch.visible = false;
				textMatch.y = 50;
				textMatch.refresh();
				trace("+");
				// New Best Time.
				addChild( textNewBestTime );
				textNewBestTime.refresh();
				textNewBestTime.y = 165;//400;
				
				trace("+");
				
				// textNoMatch.
				textHolder.addChild( textNoMatch as Sprite );
				textNoMatch.visible = false;
				textNoMatch.refresh();
				textNoMatch.y = 50;
				// Stopwatch
				stopwatch = new StopWatchStarling;
				addChild( stopwatch );
				//
				_createMemoryGame();
				// Do pause.
				_pauseView = new PauseView();
				_pauseView.initialize();
				addChild( _pauseView as Sprite );
				// Add quick iDisplay.
				_defaultLoadingGraphic = new FastStarlingDisplay( new Image( Assets.getTextureAtlas( "assets" ).getTexture( "loading/bg" ) ) );
				_defaultLoadingGraphic.initialize();
				//
				initialized = true;
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
			
		}	
		
		
		private function readyGraphicComplete():void
		{
			
			trace(this + " : readyGraphicComplete()");
			//Assets.getSfx( "VOICE_MATCH_THE_CARDS_SND" ).playSound();
			_isWinner = false;
			gamePlay.refresh();
			//memoryManager.start();     
			// PauseView.
			_pauseView.refresh();
			stopwatch.startTimer();
			
		}
		
		
		// Handle all the events.
		private function onEvent(event:starling.events.Event):void
		{
			
			trace("GameOverlay : onEvent: " + event.type);
			switch( event.type )
			{
				
				
				
				case StopWatchStarling.START:
					break;
				
				case StopWatchStarling.STOP:
					break;
				
				case StopWatchStarling.RESUME:
					break;
				
				case StopWatchStarling.PAUSE:
					break;
				
				//case StarlingSiteEvent.START_GAME:
				case StarlingSiteEvent.NEW_BEST_TIME:
					Assets.getSfx( "ACCESS_GRANTED" ).gotoSoundTime( 0, true );
					textNewBestTime.start();
					break;
				
				//case StarlingSiteEvent.START_GAME:
				case StarlingSiteEvent.SCORE_LOADED:
					trace ("SCORE_LOADED HAS BEEN ACHIEVED");
					//stopwatch.setDiplayTime( event.data.score );
					stopwatch.setBestTime( event.data.score );
					break;
				
				//case StarlingSiteEvent.START_GAME:
				case StarlingSiteEvent.PLAY_GAME:
					//backButton.visible = true;
					splashPage.visible = false;
					// Text.
					textWin.outro();
					textLose.outro();
					stopwatch.startTimer();
					break;
				
				case StarlingSiteEvent.BACK_TO_BEGINNING:
					trace(this + " : StarlingSiteEvent.BACK_TO_BEGINNING.");
					Assets.getSfx( "BG_MUSIC" ).gotoSoundTime( 0, true );
					//Assets.getSfx( "VOICE_NEOS_WORLD_SND" ).gotoSoundTime( 0, true );
					startButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
					instructionsButton.visible = true;
					startButton.visible = true;
					splashPage.visible = true;
					//backButton.visible = false;
					playAgainButton.visible = false;
					nextLevelButton.visible = false;
					newGameButton.visible = false;
					//( energyGuage as Sprite ).visible = false;
					startButton.blink();
					gamePlay.clear();
					// PauseView.
					_pauseView.clear();
					break;
				
				case StarlingSiteEvent.DISABLE_BUTTONS:
					//trace(this + " : StarlingSiteEvent.DISABLE_BUTTONS.");
					removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
					//disable();
					break;
				
				case StarlingSiteEvent.ENABLE_BUTTONS:
					//trace(this + " : StarlingSiteEvent.DISABLE_BUTTONS.");
					addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
					//disable();
					break;
				
				case StarlingSiteEvent.LOSE:
					_isWinner = false;
					textHolder.change( textLose );
					textLose.intro();
					gamePlay.outro();
					//Assets.getSfx( "VOICE_AWWW_SND" ).playSound();
					outro();
					break;
				
				case StarlingSiteEvent.WIN:
					//Assets.getSfx( "VOICE_OH_WOW_SND" ).playSound();
					_isWinner = true;
					textHolder.change( textWin ).currentDisplay.intro();
					outro();
					gamePlay.outro();
					_pauseView.clear();
					stopwatch.stopTimer();
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.NEW_TIME, { time:stopwatch.getTime() } ) );
					break;
				
				case StarlingSiteEvent.CARD_TOUCHED:
					//trace( this + " : StarlingSiteEvent.CARD_TOUCHED" );
					Assets.getSfx( "SELECT_SND" ).gotoSoundTime( 0, true );
					//Assets.getSfx( "SELECT_SND" ).playSound();
					break;
				
				case StarlingSiteEvent.NO_MATCH:
					Assets.getSfx( "NO_MATCH_SND" ).gotoSoundTime( 0, true );
					textHolder.change( textNoMatch ).currentDisplay.start();
					break;
				
				case StarlingSiteEvent.CARDS_MATCHED:
					Assets.getSfx( "MATCH_SND" ).gotoSoundTime( 0, true );
					textHolder.change( textMatch ).currentDisplay.start();
					break;
				
				case StarlingSiteEvent.MATCHED_SEQUENCE:
					Assets.getSfx( "MATCH_SND" ).gotoSoundTime( 0, true );
					break;
				
				case StarlingSiteEvent.PAUSE:
					Assets.getSfx( "BG_MUSIC" ).pauseSound();
					stopwatch.stopTimer();
					break;
				case StarlingSiteEvent.RESUME:
					//Assets.getSfx( "BG_MUSIC" ).pauseSound();
					stopwatch.continueTimer();
					break;
				
				case StarlingSiteEvent.DONE:
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.PAUSE, {} ) );
					break;
				
				case StarlingSiteEvent.TOUCHED:
					//trace( this + " : " + event.type + " : " + event.data.id );
					switch( event.data.id )
					{
						
						case "startButton":
							startButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
							instructionsButton.visible = false;
							startButton.visible = false;
							splashPage.visible = false;
							startButton.blink( false );
							//backButton.visible = true;
							// Event.
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.PLAY_GAME ) );
							Assets.getSfx( "BG_MUSIC" ).pauseSound();
							break;
						
						case "clearButton":
							stopwatch.setBestTime(0);
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.CLEAR_SCORE) );
							break;
						
						case "showGamecenter":
							//stopwatch.setBestTime(0);
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.SHOW_GAMECENTER_UI ) );
							break;
						
						case "backButton":
							trace("backButton");
							//backButton.visible = false;
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.BACK_TO_BEGINNING ) );
							//trace("backButton END");
							break;
						
						case "instructionsButton":
							//Assets.getSfx( "VOICE_MATCH_THE_CARDS_SND" ).playSound();
							break;
						
						case "PlayAgainButton" :
							_hideTextButtons();
							// Audio.
							//Assets.getSfx( "PLANE_IDLE_SND" ).pauseSound();
							//Assets.getSfx( "VOICE_READY_SND" ).playSound();
							// Anime.
							TweenMax.to( readyGraphic, 0, { autoAlpha:0 } );
							TweenMax.to( readyGraphic, 0.6, { autoAlpha:1, delay:0.5, onComplete:readyGraphicComplete } );
							TweenMax.to( readyGraphic, 0.6, { autoAlpha:0, delay:2 } );
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.PLAY_AGAIN ) );
							break;
						/*
						case "NextLevelButton":
							_hideTextButtons();
							Assets.getSfx( "BG_MUSIC" ).pauseSound();
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.NEXT_LEVEL ) );
							break;
						*/
						case "NewGameButton":
							Assets.getSfx( "BG_MUSIC" ).pauseSound();
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.NEW_GAME ) );
							break;
						
						case "AboutButton":
							
							break;
						
						case "QuitButton":
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.QUIT, {} ) );
							break;
						
						default:
							trace(this + " : Unhandled StarlingSiteEvent.TOUCHED event - " + event.data.id);
							
					}
					break;
				
				case starling.events.Event.ADDED_TO_STAGE:
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
					if( !initialized ) initialize();
					break;
				
				case starling.events.Event.ENTER_FRAME:
					trace(this + " : " + event.type);
					break;
				
				default:
					trace(this + " : Unhandled event - " + event.type );
					
					
			}
			
		}
		
		
		private function _hideTextButtons():void
		{
			
			playAgainButton.visible = false;
			playAgainButton.blink( false );
			newGameButton.visible = false;
			newGameButton.blink( false );
			nextLevelButton.visible = false;
			nextLevelButton.blink( false );
			//quitButton.visible = false;
			playButton.visible = false;
			//aboutButton.visible = false;
			//backButton.visible = true;
			// Text.
			textLose.visible = false;
			textWin.visible = false;
			textMatch.visible = false;
			textNoMatch.visible = false;
			
		}
		
		
		// Creates components to be used in game.
		public function showLoadingScreen():void
		{
			
			trace(this + " : showLoadingScreen()");
			addChild( _defaultLoadingGraphic as starling.display.Sprite );
			_defaultLoadingGraphic.refresh();
			
		}
		
		
		// Creates components to be used in game.
		public function removeLoadingScreen():void
		{
			
			trace(this + " : removeLoadingScreen()");
			if( contains( _defaultLoadingGraphic as starling.display.Sprite ) ) 
			{
				
				_defaultLoadingGraphic.clear();
				removeChild( _defaultLoadingGraphic as starling.display.Sprite );
				
			}
			
		}
		
		
		// Creates components to be used in game.
		private function _createMemoryGame():void
		{
			
			trace(this + " : createMemoryGame()");
			
			/*
			//var xml:XML = Assets.getXML( "cards.xml" );
			//var c:TextureAtlas = Assets.createTextureAtlas( "cards_atlas", Assets.getTexture( "cards.png" ), xml );
			*/
			// Game.
			Assets.GAME_PLAY = gamePlay = new GamePlay;
			addChild( gamePlay as Sprite );
			gamePlay.initialize( { atlas:Assets.getTextureAtlas( "assets" ), xml:Assets.getXML( "assets.xml" ), alias:name } );
		}
		
		
	}
	
	
}
