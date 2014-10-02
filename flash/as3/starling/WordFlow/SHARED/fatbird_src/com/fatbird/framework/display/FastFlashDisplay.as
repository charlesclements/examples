package com.fatbird.framework.display
{
	
	
	import flash.display.Bitmap;

	
	public class FastFlashDisplay extends AbstractFlashDisplay implements IDisplay
	{

		
		private var image:Bitmap;
		
		
		public function FastFlashDisplay($image:Bitmap)
		{
			
			super();
			image = $image;
			addChild( image );
			
		}
		
		
		public function initialize(data:Object=null):void{};
		public function refresh():void{};
		public function clear():void{};
		public function start():void{};
		public function intro():void{};
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};
		
		
	}
	
	
}