package com.bedrock.extras.keyCapture
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class KeyCaptureEvent extends GenericEvent
	{
		public static const PHRASE_MATCHED:String = "phraseMatched";
		
		public function KeyCaptureEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}