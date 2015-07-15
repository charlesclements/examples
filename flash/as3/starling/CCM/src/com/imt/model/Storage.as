package com.imt.model
{
	public class Storage extends Object
	{
		
		
		public static var WIDTH:uint = 0;
		public static var HEIGHT:uint = 0;
		
		private var _coins:uint = 0;
		private var _score:uint = 0;
		
		public function Storage()
		{
			super();
		}
		
		
		public function saveCoins(coins:uint=1):void
		{
			
			_coins += coins;
			
		}
		
		public function coins():uint
		{
			
			return _coins;
			
		}
		
		public function spendCoins(coins:uint=1):void
		{
			
			_coins - coins;
			
		}
		
		
		
		
	}
}