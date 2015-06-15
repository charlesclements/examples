package flox.model
{
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	
	import flox.entity.MyPlayer;
	
	import starling.events.EventDispatcher;
	
	public class FloxModel extends EventDispatcher
	{
		
		
		public function FloxModel()
		{
			super();
		}
		
		
		public static function intialize():void
		{
			
			trace("FloxModel - intialize");
			
			Flox.playerClass = MyPlayer;
			
			// Init FLOX.
			Flox.init("fetviSOsbJaIYV3B", "eGFHx7eXpnYSKTck", "0.9");
			
			
			//Who's currently playing?
			var currentPlayer:MyPlayer = Player.current as MyPlayer;

			
			//trace( currentPlayer.createdAt.toString() == currentPlayer.updatedAt.toString() );
			
			//trace(currentPlayer.coins);
			
			if( currentPlayer.createdAt.toString() == currentPlayer.updatedAt.toString() && currentPlayer.coins < 0 )
			{
				
				
				trace("Setting the COINS!!");
				// Add coins at intro.
				currentPlayer.coins = 100;
				trace(currentPlayer.coins);
				
			}
			
			
			
			
		}
		
		
		
		
		
	}
}