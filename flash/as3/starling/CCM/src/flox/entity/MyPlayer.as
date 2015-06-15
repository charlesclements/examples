package flox.entity
{
	
	
	import com.gamua.flox.Player;
	
	
	public class MyPlayer extends Player
	{
		
		private var _coins:int = -1;
		
		public function MyPlayer()
		{
			super();
		}
		
		
		public function set coins( num:int ):void
		{
			
			trace( this + "set coins : " + num );
			
			_coins = num;
			saveQueued();
			
			
			
		}
				
		
		public function get coins():int
		{
			
			trace( this + "get coins" );
			return _coins;
			
		}
				
				
				
		
		
	}
	
}