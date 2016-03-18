package model
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.utils.HttpStatus;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import dispatcher.Dispatcher;
	
	import entities.UserTokens;
	
	import events.AppEvent;
	
	public class FloxModel extends EventDispatcher
	{
		
		
		
		//you already know the entity ID
		private static var userTokenId:String = "user-token";
		private static var userTokens:UserTokens;// = new UserTokens;
		
		
		
		
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
			Entity.load(UserTokens, userTokenId,
				function onComplete(tokens:UserTokens):void {
					//Everything worked just fine and an entity has been retrieved from the server.
					//This savegame is never null.
					
					userTokens = tokens;
					
					trace(userTokens.tokens);
					
					
					
				},
				function onError(error:String, httpStatus:int):void {
					
					
					trace(error);
					trace(httpStatus);
					trace(HttpStatus.NOT_FOUND);
					
					
					if(httpStatus == HttpStatus.NOT_FOUND) {
						//There's no entity on the server that matches the given type and ID.
						
						
						// Add initial tokens here since they dont exist yet.
						
						//create a new savegame
						userTokens = new UserTokens;
						userTokens.id = userTokenId;
						
						// Initialize userTokens here?

						//userTokens.
						//save it to Flox using the instance method
						userTokens.saveQueued();
						
						trace(userTokens.tokens);
						
						// Save Tokens entity.
						
						
						
					} else {
						//Something went wrong during the load operation: The player's device may be offline.
					}
				}
			);
			
			
			
			
			
			
			
		}
		
		
		
		
		
		
		
		
		public static function useToken():void
		{
			
			/*
			userTokens.tokens -= 1; 
			userTokens.saveQueued();
			trace( "FloxModel - useToken : remaining : " + userTokens.tokens );
			
			if( userTokens.tokens <= 0 )
			{
				
				Dispatcher.dispatchEvent( new AppEvent( AppEvent.NO_MORE_TOKENS, {} ) );
				
				
				
			}
			*/
			
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