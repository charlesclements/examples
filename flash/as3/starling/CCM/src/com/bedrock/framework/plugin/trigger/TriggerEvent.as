package com.bedrock.framework.plugin.trigger
{
	import com.bedrock.framework.core.event.GenericEvent;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class TriggerEvent extends GenericEvent
	{
		public static  const TIMER_START:String = "TriggerEvent.onTimerStart";
		public static  const INTERVAL_START:String = "TriggerEvent.onIntervalStart";
		public static  const STOPWATCH_START:String = "TriggerEvent.onStopwatchStart";
		
		public static  const TIMER_STOP:String = "TriggerEvent.onTimerStop";
		public static  const INTERVAL_STOP:String = "TriggerEvent.onIntervalStop";
		public static  const STOPWATCH_STOP:String = "TriggerEvent.onStopwatchStop";
		
		public static  const TIMER_TRIGGER:String = "TriggerEvent.onTimerTrigger";
		public static  const INTERVAL_TRIGGER:String = "TriggerEvent.onIntervalTrigger";
		public static  const STOPWATCH_TRIGGER:String = "TriggerEvent.onStopwatchTrigger";
		
		public function TriggerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}