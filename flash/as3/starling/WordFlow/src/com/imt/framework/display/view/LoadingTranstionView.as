package com.imt.framework.display.view
{
	
	
	import com.imt.assets.Assets;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.display.IPausable;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	
	public class LoadingTranstionView extends AbstractStarlingDisplay implements IDisplay, IPausable
	{
		
		
		private var _gears:Sprite;
		private var _gear1:Sprite;
		private var _gear2:Sprite;
		private var _gear3:Sprite;
		private var _bg:Image;
		private var _speed:Number = 0.04;
		
		
		
		public function LoadingTranstionView()
		{
			super();
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			trace( this + " : initialize" );
			var atlas:TextureAtlas = Assets.getTextureAtlas( "assets" );
			// Create BG here.
			//_bg = new Image( Texture.fromColor( GameData.STAGE_WIDTH, GameData.STAGE_HEIGHT, 0xbb000000 ) );//, 0x000000, true
			_bg = new Image( atlas.getTexture( "loading/bg" ) );
			addChild( _bg );
			// Add buttons here.
			// ResumeButton.
			
			
			_gears = new Sprite;
			addChild( _gears );
			_gears.x = 100;
			_gears.y = 110;
			
			
			_gear1 = new Sprite;
			_gears.addChild( _gear1 );
			_gear1.addChild( new Image( atlas.getTexture( "loading/gear1" ) ) );
			_gear1.getChildAt( 0 ).x -= _gear1.width / 2;
			_gear1.getChildAt( 0 ).y -= _gear1.height / 2;
			_gear1.x = 267;
			_gear1.y = 300;
			
			_gear2 = new Sprite;
			_gears.addChild( _gear2 );
			_gear2.addChild( new Image( atlas.getTexture( "loading/gear2" ) ) );
			_gear2.getChildAt( 0 ).x -= _gear2.width / 2;
			_gear2.getChildAt( 0 ).y -= _gear2.height / 2;
			_gear2.x = 438;
			_gear2.y = 205;
			
			_gear3 = new Sprite;
			_gears.addChild( _gear3 );
			_gear3.addChild( new Image( atlas.getTexture( "loading/gear3" ) ) );
			_gear3.getChildAt( 0 ).x -= _gear3.width / 2;
			_gear3.getChildAt( 0 ).y -= _gear3.height / 2;
			_gear3.x = 594;
			_gear3.y = 312;
			
		
			
		}
		
		
		public function refresh():void
		{
			
			trace( this + " : refresh" );
			//stage.addEventListener( Event.ENTER_FRAME, onEvent );
			
		}
		
		
		public function clear():void
		{
			
			trace( this + " : clear" );
			stage.removeEventListener( Event.ENTER_FRAME, onEvent );
			
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
		
		}
		
		
		public function resume():void
		{

			trace(this + " : resume");
			
		}
		
		
		// Handle all the events.
		private function onEvent(event:Event):void
		{
			
			trace(this + " : onEvent: " + event.type);
			switch( event.type )
			{
				
				case Event.ENTER_FRAME:
					_gear1.rotation += _speed;
					_gear2.rotation -= _speed;
					_gear3.rotation += _speed;
					break;
				
		
			}
			
		}
		
	}
	
}
	
	
	
	
	