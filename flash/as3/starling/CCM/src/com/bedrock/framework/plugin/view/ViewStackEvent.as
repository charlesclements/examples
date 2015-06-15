package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class ViewStackEvent extends GenericEvent
	{		
		public static const CHANGE:String = "ViewStackEvent.onChange";
		public static const AT_START:String =  "ViewStackEvent.onAtStart";
		public static const AT_FINISH:String =  "ViewStackEvent.onAtFinish";
		
		public function ViewStackEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}