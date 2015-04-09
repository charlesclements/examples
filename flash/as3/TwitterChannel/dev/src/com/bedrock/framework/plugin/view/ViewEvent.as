﻿package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.event.GenericEvent;
	public dynamic class ViewEvent extends GenericEvent
	{
		public static const INITIALIZE_COMPLETE:String="ViewEvent.onInitializeComplete";
		public static const INTRO_COMPLETE:String="ViewEvent.onIntroComplete";
		public static const OUTRO_COMPLETE:String="ViewEvent.onOutroComplete";
		public static const CLEAR_COMPLETE:String="ViewEvent.onClearComplete";
		public static const CHANGE:String = "ViewEvent.onChange";

		public function ViewEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	
	}
}