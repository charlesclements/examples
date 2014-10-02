package com.imt.framework.display.view
{
	
	
	import com.imt.assets.Assets;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.display.IPausable;
	import com.imt.framework.display.button.GameButton;
	import com.imt.framework.engine.data.GameData;
	import com.imt.framework.event.StarlingSiteEvent;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class PauseView extends AbstractStarlingDisplay implements IDisplay, IPausable
	{
		
		
		private var _resumeButton:GameButton;
		private var _endGameButton:GameButton;
		private var _pauseButton:GameButton;
		private var _bg:Image;
		
		
		public function PauseView()
		{
			super();
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			trace( this + " : initialize" );
			// Create BG here.
			_bg = new Image( Texture.fromColor( GameData.STAGE_WIDTH, GameData.STAGE_HEIGHT, 0xbb000000 ) );//, 0x000000, true
			_bg.visible = false;
			addChild( _bg );
			// Add buttons here.
			var atlas:TextureAtlas = Assets.getTextureAtlas( "assets" );
			// ResumeButton.
			_resumeButton = new GameButton( { id:"ResumeButton" }, atlas.getTexture( "text/resume" ) );
			_resumeButton.x = ( GameData.STAGE_WIDTH / 2 ) - ( _resumeButton.width / 2 );
			_resumeButton.y = 200;
			_resumeButton.visible = false;
			addChild( _resumeButton );
			// EndGame.
			_endGameButton = new GameButton( { id:"EndGameButton" }, atlas.getTexture( "text/end-game" ) );
			_endGameButton.x = ( GameData.STAGE_WIDTH / 2 ) - ( _endGameButton.width / 2 );
			_endGameButton.y = 400;
			_endGameButton.visible = false;
			addChild( _endGameButton );
			// PauseButton.
			_pauseButton = new GameButton( { id:"PauseButton" }, atlas.getTexture( "text/pause" ) );
			_pauseButton.x = _pauseButton.y = 10;//25;
			_pauseButton.visible = false;
			addChild( _pauseButton );
			
		}
		
		
		public function refresh():void
		{
			
			trace( this + " : refresh" );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.RESUME, onEvent );
			_resumeButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			_endGameButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			_pauseButton.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			// Visible.
			_pauseButton.visible = true;
			_resumeButton.visible = false;
			_endGameButton.visible = false;
			_bg.visible = false;
			
		}
		
		
		public function clear():void
		{
			
			trace( this + " : clear" );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.PAUSE, onEvent );
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.RESUME, onEvent );
			_resumeButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			_endGameButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			_pauseButton.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			// Visible.
			_pauseButton.visible = false;
			_resumeButton.visible = false;
			_endGameButton.visible = false;
			_bg.visible = false;
			
		}

		
		public function start():void
		{
		}
		
		public function intro():void
		{
		}
		
		public function outro():void
		{
		}
		
		public function cancel():void
		{
		}
		
		public function destroy():void
		{
		}
		
		
		public function pause():void
		{
			
			trace(this + " : pause");
			StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.PAUSE, {} ) );
		
		}
		
		
		public function resume():void
		{

			trace(this + " : resume");
			StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.RESUME, {} ) );
			
		}
		
		
		// Handle all the events.
		private function onEvent(event:Event):void
		{
			
			trace(this + " : onEvent: " + event.type);
			switch( event.type )
			{
				
				
				case StarlingSiteEvent.TOUCHED:
					//trace( this + " : " + event.type + " : " + event.data.id );
					switch( event.data.id )
					{
						
						case "ResumeButton":
							resume();
							break;
						
						case "EndGameButton":
							
							
							_pauseButton.visible = false;
							_resumeButton.visible = false;
							_endGameButton.visible = false;
							_bg.visible = false;
							
							
							
							StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.BACK_TO_BEGINNING, {} ) );
							break;
						
						case "PauseButton":
							pause();
							break;
		
					}
					break;
				
				case StarlingSiteEvent.PAUSE:
					_pauseButton.visible = false;
					_resumeButton.visible = true;
					_endGameButton.visible = true;
					_bg.visible = true;
					break;
				
				case StarlingSiteEvent.RESUME:
					_pauseButton.visible = true;
					_resumeButton.visible = false;
					_endGameButton.visible = false;
					_bg.visible = false;
					break;
		
			}
			
		}
		
	}
	
}
	
	
	
	
	