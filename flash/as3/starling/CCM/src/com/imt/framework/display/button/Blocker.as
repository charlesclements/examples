package com.imt.framework.display.button
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Blocker extends Sprite
	{
		public function Blocker()
		{
			super();
			
			addEventListener( MouseEvent.CLICK, onEvent, false, 0, true );
			useHandCursor = false;
			
		}
		
		
		private function onEvent(e:MouseEvent):void
		{
			
			
			trace("BLOCKED");
			
			
			
			
			
		}
		
		
	}
}