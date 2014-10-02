package com.imt.framework.display
{

	public interface IDisplay
	{
		
		function initialize(data:Object=null):void;
		function refresh():void;
		function clear():void;
		function start():void;
		function intro():void;
		function outro():void;
		function cancel():void;
		function destroy():void;
		
		/*
		// Functions required by implemented IDisplay.
		public function initialize(data:Object=null):void{};
		public function refresh():void{};
		public function clear():void{};
		public function start():void{};
		public function intro():void{};
		public function outro():void{};
		public function cancel():void{};
		public function destroy():void{};
		*/
			
	}
}

