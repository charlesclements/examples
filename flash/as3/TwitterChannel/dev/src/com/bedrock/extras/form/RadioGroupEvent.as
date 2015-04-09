package com.bedrock.extras.form
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class RadioGroupEvent extends GenericEvent
	{
		
		public static const SELECTED:String = "RadioEvent.onSelected"
		
		public function RadioGroupEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}