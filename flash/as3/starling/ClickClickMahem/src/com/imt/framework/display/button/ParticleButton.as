package com.imt.framework.display.button
{
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class ParticleButton extends AbstractButton
	{
		
		//public function GameButton($data:Object, upState:Texture, text:String="", downState:Texture = null)
		public function ParticleButton()
		{
			
			trace( "ParticleButton" );
			super( { id:"particle" }, Texture.fromBitmapData( new BitmapData( 25, 25, false, 0xff0000 ) ), "", null );
			
		}
		
		
		public function setup():void
		{
			
			trace( "ParticleButton - setup" );
			
			
			
		}
		
	}
		
}