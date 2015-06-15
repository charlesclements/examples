package com.imt.game.components
{
	
	
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class GenericObject extends AbstractStarlingDisplay implements IDisplay
	{
		
		
		private var clip:Image;
		private var texture:Texture;

		
		public function GenericObject($texture:Texture)
		{
			
			super();
			texture = $texture;
			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			
			if( !initialized )
			{
				
				trace( "initialize" );
				createArtwork();
				initialized = true;
				
			}
			
		}
		
		//public function initialize(data:Object=null):void{};
		public function refresh():void{};
		public function clear():void{};
		public function start():void{};
		public function intro():void{};
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};
		
		
		// Handles most of the site events.
		private function onEvent(event:Event):void
		{
			
			
			switch( event.type )
			{
				
				case Event.ENTER_FRAME:
					
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
			
			trace("createArtwork");
			clip = new Image( texture );	
			//clip = new Image( Graphics.getMemoryPlaneAtlas().getTexture( texture ) );	
			//clip.x = Math.ceil( -clip.width * 0.5 );
			//clip.y = Math.ceil( -clip.height * 0.5 );
			addChild( clip );
			//starling.core.Starling.juggler.add( hero );
			
		}
		
	}
	
}