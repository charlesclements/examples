package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class ViewSequenceEvent extends GenericEvent
	{		
		public static  const SEQUENCE_COMPLETE:String = "ViewSequenceEvent.onSequenceComplete";
		
		public function ViewSequenceEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}