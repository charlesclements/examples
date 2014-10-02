﻿package com.bedrock.extras.form
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class CheckBoxEvent extends GenericEvent
	{
		public static const CHECK:String = "CheckBoxEvent.onCheck";
		public static const UNCHECK:String = "CheckBoxEvent.onUncheck";

		public function CheckBoxEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}