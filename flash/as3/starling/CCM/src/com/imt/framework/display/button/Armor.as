package com.imt.framework.display.button
{
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class Armor extends AbstractButton
	{
		
		public function Armor()
		{
			
			//trace( "ParticleButton" );
			super( { id:"particle" }, Texture.fromBitmapData( new BitmapData( 25, 25, false, 0xff0000 ) ), "", Texture.fromBitmapData( new BitmapData( 25, 25, false, 0x00ff00 ) ) );
			
		}
		
		
		public function reset():void
		{
			
			trace( "ParticleButton - reset" );
			
			
			
		}
		
		
		public function removeMe():void
		{
			
			//trace( "ParticleButton - removeMe" );
			parent.removeChild( this );
			
		}
		
		
		public function setup():void
		{
			
			trace( "ParticleButton - setup" );
			
			
			
		}
		
		
	}
		
}