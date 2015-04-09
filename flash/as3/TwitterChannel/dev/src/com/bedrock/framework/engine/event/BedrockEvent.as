package com.bedrock.framework.engine.event
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class BedrockEvent extends GenericEvent
	{
		public static const TRANSITION:String="BedrockEvent._onTransition";
		public static const TRANSITION_PREPARED:String="BedrockEvent._onTransitionPrepared";
		public static const TRANSITION_COMPLETE:String="BedrockEvent._onTransitionComplete";
		
		public static const PREPARE_INITIAL_LOAD:String="BedrockEvent._onPrepareInitialLoad";
		public static const PREPARE_INITIAL_TRANSITION:String="BedrockEvent._onPrepareInitialTransition";
		
		public static const CONFIG_LOADED:String="BedrockEvent.onConfigLoaded";
		public static const INITIALIZE_COMPLETE:String="BedrockEvent.onInitializeComplete";

		public static const DEEPLINK_CHANGE:String="BedrockEvent.onDeeplinkChange";
		public static const DEEPLINKING_INITIALIZED:String="BedrockEvent.onDeeplinkingInitialized";

		public static const LOAD_BEGIN:String="BedrockEvent.onLoadBegin";
		public static const LOAD_ERROR:String="BedrockEvent.onLoadError";
		public static const LOAD_COMPLETE:String="BedrockEvent.onLoadComplete";
		public static const LOAD_CLOSE:String="BedrockEvent.onLoadClose";
		public static const LOAD_PROGRESS:String="BedrockEvent.onLoadProgress";
		public static const LOAD_NEXT:String="BedrockEvent.onLoadNext";
		public static const LOAD_RESET:String="BedrockEvent.onLoadReset";

		public static const SHOW_BLOCKER:String="BedrockEvent.onShowBlocker";
		public static const HIDE_BLOCKER:String="BedrockEvent.onHideBlocker";
		
		public static const DATA_BUNDLE_CHANGE:String="BedrockEvent.onDataBundleChange";
		public static const DATA_BUNDLE_LOADED:String="BedrockEvent.onDataBundleLoaded";
		public static const DATA_BUNDLE_ERROR:String="BedrockEvent.onDataBundleError";
		
		public static const LOCALE_CHANGE:String="BedrockEvent.onLocaleChange";
		public static const LOCALE_LOADED:String="BedrockEvent.onLocaleLoaded";
		public static const LOCALE_ERROR:String="BedrockEvent.onLocaleError";
		
		public function BedrockEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}