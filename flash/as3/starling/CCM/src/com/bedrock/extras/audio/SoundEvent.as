package com.bedrock.framework.plugin.audio
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class SoundEvent extends GenericEvent
	{
		public static const SOUND_COMPLETE:String = "SoundEvent.onSoundComplete";
		
		public function SoundEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}