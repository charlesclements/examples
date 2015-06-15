package com.imt.game.background
{

	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class Layer extends Sprite
	{
		
		public var texture:Texture;
		private var image1:Image;
		private var image2:Image;
		private var image3:Image;
		public var isMobile:Boolean = true;
		private var _layer:int = 0;
		private var _parallax:Number = 0;
		
		
		public function Layer($texture:Texture, $name:String)
		{
			
			super();
			if( $name ) name = $name;
			// Add texture here.
			texture = $texture;
			//layer = $layer;
			addEventListener( Event.ADDED_TO_STAGE, onEvent );
			
		}
		
		
		// Handle all the events.
		private function onEvent(event:Event):void
		{
			
			switch( event.type )
			{
				
				case Event.ADDED_TO_STAGE:
					image1 = new Image( texture );
					image2 = new Image( texture );
					image3 = new Image( texture );
					// Image 1.
					image1.x = image1.y = 0;
					//image1.y = stage.stageHeight - image1.height;
					addChild( image1 );
					// Image 2.
					image2.x = width - 1;
					//image2.y = image1.y;
					addChild( image2 );
					// Image 3.
					image3.x = width - 1;
					//image3.y = image1.y;
					addChild( image3 );
					break;
				
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		

		public function get parallax():Number
		{
			
			return _parallax;
			
		}
		
		
		public function set parallax(value:Number):void
		{
			
			_parallax = value;
			
		}
		
		
		public function get layer():int
		{
			
			return _layer;
			
		}
		

		public function set layer(value:int):void
		{
			
			_layer = value;
			
		}
		
		
		public function remove():void
		{

			trace( this + "remove" );
			parent.removeChild( this );
			
		}
			

	}
	
}