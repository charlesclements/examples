package model
{
	
	
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	public class AppModel_old extends EventDispatcher
	{
		
		private static var _initialized:Boolean = false;
		//public static var LOADER:Loaderm = false;
		
		public function AppModel_old(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function initialize():void
		{
			
			if( !_initialized )
			{
				
				trace( "AppModel - initialize()" );
				
				
				_initialized = true;
				
			}
			
			
			
		}
		
		
		
	}
	
	
}