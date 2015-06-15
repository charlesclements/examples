package com.fatbird.framework.display
{
	
	
	import starling.display.Image;

	
	public class FastStarlingDisplay extends AbstractStarlingDisplay implements IDisplay
	{

		
		private var image:Image;
		
		
		public function FastStarlingDisplay($image:Image)
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