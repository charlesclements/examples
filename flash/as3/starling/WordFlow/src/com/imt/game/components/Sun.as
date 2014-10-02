package com.imt.game.components
{
	
	
	import com.bedrock.extras.util.MathUtil;
	import com.imt.assets.Assets;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class Sun extends AbstractStarlingDisplay implements IDisplay, IAnimatable
	{
		
		
		private var clip:Image;

		
		public function Sun()
		{
			
			super();
			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			
			if( !initialized )
			{
				
				trace( this + " : initialize" );
				createArtwork();
				initialized = true;
				
			}
			
			
		}
		
		
		public function refresh():void
		{
			
			addEventListener( Event.ENTER_FRAME, onEvent );
			Starling.juggler.add( this );
			
		}
		
		
		public function clear():void
		{
			
			removeEventListener( Event.ENTER_FRAME, onEvent );
			Starling.juggler.remove( this );
			
		}
		
		
		public function start():void{};
		public function intro():void{};
		public function outro():void{};
		
		
		public function cancel():void{};
		public function destroy():void{};
		
		
		public function advanceTime(time:Number):void
		{
			
			
			
			
			
			
		}
		
		
		// Handles most of the site events.
		private function onEvent(event:Event):void
		{
			
			
			switch( event.type )
			{
				
				case Event.ENTER_FRAME:
					rotation += MathUtil.degreesToRadians( 0.035 );
					break;
				
				case starling.events.Event.ADDED_TO_STAGE:
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
					trace(this + " : " + event.type);
					initialize();
					break;
				
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		
		
		// Create artwork.
		private function createArtwork():void
		{
			
			trace("createArtwork");
			clip = new Image( Assets.getTextureAtlas( "Stage1_1" ).getTexture( "sun" ) );	
			
			
			
			clip.x = - clip.width / 2;
			clip.y = - clip.height / 2;
			addChild( clip );
			
		}
		
	}
	
}