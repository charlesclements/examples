package net.charlesclements.gadgets.display
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class SimpleAutoSmoothMovieClip extends MovieClip
	{
		public function SimpleAutoSmoothMovieClip()
		{
			super();
			
			takeSnapshot()
			
		}
		
		
		/* 
		Takes a picture of the phone to use bitmap smoothing.
		*/
		private function takeSnapshot():void
		{
			
			var b:Bitmap = new Bitmap( new BitmapData( width/scaleX, height/scaleY, true, 0xff0000 ), "auto", true );
			b.bitmapData.unlock();
			b.bitmapData.draw( this );
			
			var length:uint = this.numChildren;
			for(var i:uint = 0; i < length; i++) removeChildAt( 0 );
			
			addChild( b );
			
		}
		
	}
}