package com.imt.framework.display.dialogue.view
{
	
	
	import com.imt.framework.display.IDisplay;
	import flash.display.Sprite;

	
	public class NewGenericDialogue extends Sprite implements IDisplay
	{
	
		
		public function NewGenericDialogue()
		{
			super();
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