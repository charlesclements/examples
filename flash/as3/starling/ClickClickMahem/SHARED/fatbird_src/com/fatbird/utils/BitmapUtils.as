package com.fatbird.utils
{

	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	 
	public class BitmapUtils
	{

		
		public function BitmapUtils()
		{
				
		}
			
		
		public static function getBitmapData(clip:Sprite, padding:int = 0):BitmapData
		{
			
			var bitmapData:BitmapData = new BitmapData(clip.width + padding * 2, clip.height + padding * 2, true, 0);
			
			var m:Matrix = new Matrix();
			m.tx = padding;			m.ty = padding;
			
			bitmapData.draw(clip, m);	
			
			return bitmapData;		
			
		}
		
		
		public static function getBitmap(clip:Sprite, padding:int = 0):Bitmap
		{
			
			return new Bitmap(getBitmapData(clip, padding));
			
		}

	}
	
}
	