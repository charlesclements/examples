package com.imt.game.vehicles{			import com.greensock.TweenMax;	import com.imt.assets.Assets;	import com.imt.framework.display.AbstractStarlingDisplay;	import com.imt.framework.display.IDisplay;	import starling.core.Starling;	import starling.display.Image;	import starling.display.MovieClip;	import starling.display.Sprite;	import starling.events.Event;
	
		public class Rocket extends AbstractStarlingDisplay implements IDisplay	{						public var centerX:int = 200;		public var groundY:int = 620;		private var _rocket:Image;		private var _flame:MovieClip;		private var _engine:Sprite;						public function Rocket()		{						trace( this );			super();			name = "Rocket"			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);					}						public function initialize(data:Object=null):void		{						if( !initialized )			{								trace( this + " : initialize" );				createArtwork();				initialized = true;							}					}		
				public function refresh():void		{						//starling.core.Starling.juggler.add( clip );			//Starling.juggler.add( _rocket );			Starling.juggler.add( _flame );					}		
		
		public function clear():void
		{
			
			Starling.juggler.remove( _flame );
			
		}
				
		public function start():void{};
		public function intro():void{};
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};						private function onEvent(event:Event):void		{									switch( event.type )			{								case Event.ENTER_FRAME:										break;												case starling.events.Event.ADDED_TO_STAGE:					trace(this + " : " + event.type);					removeEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);					initialize();					break;								default:					trace(this + " : Unhandled event.");								}					}						// Create artwork.		private function createArtwork():void		{						trace( this + " : createArtwork" );			_engine = new Sprite;			with( _engine )			{								x = 120;				y = 125;							}			addChild( _engine );			// Fire behind the rocket.			_flame = new MovieClip( Assets.getTextureAtlas( "assets" ).getTextures( "vehicles/rocket/engine_flame/flame" ), 30 );				with( _flame as MovieClip )			{								x -= _flame.width;				y -= ( _flame.height / 2 );											}			_engine.addChild( _flame );			Starling.juggler.add( _flame );			// Rocket body.			_rocket = new Image( Assets.getTextureAtlas( "assets" ).getTexture( "vehicles/rocket/rocket" ) );				addChild( _rocket );					}						public function set speed($speed:Number):void		{						$speed = ( $speed > 1.4 ) ? 1.4 : $speed;			TweenMax.to( _engine, 1, { scaleX:$speed, scaleY:$speed, overwrite:1 } );					}						public function get speed():Number		{						return _engine.scaleX;					}			}	}