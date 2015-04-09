package com.bedrock.extras.cloner
{
	import flash.display.DisplayObjectContainer;
	
	import com.bedrock.framework.core.event.GenericEvent;

	public class ClonerEvent extends GenericEvent
	{
		public static  const INITIALIZE:String = "ClonerEvent.onInitialize";
		public static  const CREATE:String = "ClonerEvent.onCreate";
		public static  const REMOVE:String = "ClonerEvent.onRemove";		
		public static  const COMPLETE:String = "ClonerEvent.onComplete";		
		public static  const CLEAR:String = "ClonerEvent.onClear";

		public function ClonerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}