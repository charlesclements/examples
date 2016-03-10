package events
{
	import flash.events.Event;

	//import starling.events.Event;
	
	public class AppEvent extends Event
	{
		
		public static var INTRO_COMLETE:String = "AppEvent.onIntroComplete";
		public static var OUTRO_COMLETE:String = "AppEvent.onOutroComplete";
		public static var TOUCHED:String = "AppEvent.onTouched";
		public static var WHEEL_SPIN:String = "AppEvent.wheel_spin";
		public static var TRANSITION:String = "AppEvent.onTransition";
		public static var RESET:String = "AppEvent.onReset";
		public static var ANSWER:String = "AppEvent.onAnswer";
		public static var BUTTON_PRESS:String = "AppEvent.onButtonPress";
		public static var KEYPAD_BUTTON_PRESS:String = "AppEvent.onKeypadButtonPress";
		public static var CONFIRM_ANSWER:String = "AppEvent.onConfirmAnswer";
		public static var QUESTION:String = "AppEvent.onQuestion";
		public static var PLAY_VIDEO:String = "AppEvent.onPlayVideo";
		public static var REPLAY_VIDEO:String = "AppEvent.onReplayVideo";
		public static var CHANGE:String = "AppEvent.onChange";
		public static var READY:String = "AppEvent.onReady";
		public static var END:String = "AppEvent.onEnd";
		public static var FINAL_VIDEO:String = "AppEvent.onFinalVideo";
		public static var GAME_OVER:String = "AppEvent.onGameOver";
		public static var GAME_COMPLETE:String = "AppEvent.onGameComplete";
		public static var CLOSE_WINDOW:String = "AppEvent.onCloseWindow";
		public static var TIMER_COMPLETE:String = "AppEvent.onTimerComplete";
		public static var SELECTION:String = "AppEvent.onSelection";
		public static var XML_READY:String = "AppEvent.onXmlReady";
		public static var VIDEO_XML_READY:String = "AppEvent.onVideoXmlReady";
		public static var NEW_GAME:String = "AppEvent.onNewGame";
		public static var NEXT_GAME:String = "AppEvent.onNextGame";
		public static var UPDATE:String = "AppEvent.onUpdate";
		public static var SHOW_PRIZE:String = "AppEvent.onShowPrize";
		public static var SUBMIT_CODE:String = "AppEvent.onSubmitCode";
		public static var DISABLE_BUTTONS:String = "AppEvent.onDisableButtons";
		public static var ENABLE_BUTTONS:String = "AppEvent.onEnableButtons";
		public static var SHOW_LINE:String = "AppEvent.onShowLine";
		public static var PLAY_SOUND:String = "AppEvent.onPlaySound";
		public static var PLAY_GAME:String = "AppEvent.onPlayGame";
		public static var SHOW_PRIZE_MEDIA:String = "AppEvent.onShowPrizeMedia";
		public static var DONE:String = "AppEvent.onDone";
		public static var VACATION:String = "AppEvent.onVacation";
		public static var PLAY_NEXT_AUDIO_TRACK:String = "AppEvent.onPlayNextAudioTrack";
		public static var NO_MORE_TOKENS:String = "AppEvent.onNoMoreTokens";
		
		public function AppEvent(type:String, data:Object=null, bubbles:Boolean=false)
		{
			super(type, bubbles, data);
		}
	}
}