package model
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.utils.HttpStatus;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import entities.Tokens;
	
	public class FloxModel extends EventDispatcher
	{
		
		
		
		//you already know the entity ID
		private static var userTokenId:String = "user-token";
		
		
		
		
		public function FloxModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function initialize():void
		{
			
			trace( "FloxModel - initialize" );
			
			Flox.init("CUypaEGPmG8MW3GE", "FX20bmYfeXTLSlQR", "0.1");
			
			// Check to see if any tokens exist from the start.
			
			
			
			
			
			
			
			
			//load the associated entity of type Savegame
			Entity.load(Tokens, userTokenId,
				function onComplete(tokens:Tokens):void {
					//Everything worked just fine and an entity has been retrieved from the server.
					//This savegame is never null.
				},
				function onError(error:String, httpStatus:int):void {
					
					
					trace(error);
					trace(httpStatus);
					trace(HttpStatus.NOT_FOUND);
					
					
					if(httpStatus == HttpStatus.NOT_FOUND) {
						//There's no entity on the server that matches the given type and ID.
						
						
						// Add initial tokens here since they dont exist yet.
						
						
						
						// Save Tokens entity.
						
						
						
					} else {
						//Something went wrong during the load operation: The player's device may be offline.
					}
				}
			);
			
			
			
			
			
			
			
		}
		
		
		public static function addTokens(tokens:uint):void
		{
			
			trace( "FloxModel - addTokens : " + tokens );
			
			
			
			
		}
		
		public static function remainingTokens():uint
		{
			
			trace( "FloxModel - remainingTokens " );
			
			return 1;
			
			
		}
		
		
		
		
	}
}