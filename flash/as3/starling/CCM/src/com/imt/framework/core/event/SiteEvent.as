package com.imt.framework.core.event
{
	import flash.events.Event;

	//import starling.events.Event;
	
	public class SiteEvent extends Event
	{
		
		public static var INTRO_COMLETE:String = "SiteEvent.onIntroComplete";
		public static var OUTRO_COMLETE:String = "SiteEvent.onOutroComplete";
		public static var TOUCHED:String = "SiteEvent.onTouched";
		public static var WHEEL_SPIN:String = "SiteEvent.wheel_spin";
		public static var TRANSITION:String = "SiteEvent.onTransition";
		public static var RESET:String = "SiteEvent.onReset";
		public static var ANSWER:String = "SiteEvent.onAnswer";
		public static var BUTTON_PRESS:String = "SiteEvent.onButtonPress";
		public static var KEYPAD_BUTTON_PRESS:String = "SiteEvent.onKeypadButtonPress";
		public static var CONFIRM_ANSWER:String = "SiteEvent.onConfirmAnswer";
		public static var QUESTION:String = "SiteEvent.onQuestion";
		public static var PLAY_VIDEO:String = "SiteEvent.onPlayVideo";
		public static var REPLAY_VIDEO:String = "SiteEvent.onReplayVideo";
		public static var CHANGE:String = "SiteEvent.onChange";
		public static var READY:String = "SiteEvent.onReady";
		public static var END:String = "SiteEvent.onEnd";
		public static var FINAL_VIDEO:String = "SiteEvent.onFinalVideo";
		public static var GAME_OVER:String = "SiteEvent.onGameOver";
		public static var GAME_COMPLETE:String = "SiteEvent.onGameComplete";
		public static var CLOSE_WINDOW:String = "SiteEvent.onCloseWindow";
		public static var TIMER_COMPLETE:String = "SiteEvent.onTimerComplete";
		public static var SELECTION:String = "SiteEvent.onSelection";
		public static var XML_READY:String = "SiteEvent.onXmlReady";
		public static var VIDEO_XML_READY:String = "SiteEvent.onVideoXmlReady";
		public static var NEW_GAME:String = "SiteEvent.onNewGame";
		public static var NEXT_GAME:String = "SiteEvent.onNextGame";
		public static var UPDATE:String = "SiteEvent.onUpdate";
		public static var SHOW_PRIZE:String = "SiteEvent.onShowPrize";
		public static var SUBMIT_CODE:String = "SiteEvent.onSubmitCode";
		public static var DISABLE_BUTTONS:String = "SiteEvent.onDisableButtons";
		public static var ENABLE_BUTTONS:String = "SiteEvent.onEnableButtons";
		public static var SHOW_LINE:String = "SiteEvent.onShowLine";
		public static var PLAY_SOUND:String = "SiteEvent.onPlaySound";
		public static var PLAY_GAME:String = "SiteEvent.onPlayGame";
		public static var SHOW_PRIZE_MEDIA:String = "SiteEvent.onShowPrizeMedia";
		public static var DONE:String = "SiteEvent.onDone";
		public static var VACATION:String = "SiteEvent.onVacation";
		public static var PLAY_NEXT_AUDIO_TRACK:String = "SiteEvent.onPlayNextAudioTrack";
		
		
		public function SiteEvent(type:String, data:Object=null, bubbles:Boolean=false)
		{
			super(type, bubbles, data);
		}
	}
}