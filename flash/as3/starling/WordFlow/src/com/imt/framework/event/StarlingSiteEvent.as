package com.imt.framework.event
{
	//import flash.events.Event;
	import starling.events.Event;

	//import starling.events.Event;
	
	public class StarlingSiteEvent extends Event
	{
		
		public static var SCORE_LOADED:String = "StarlingSiteEvent.onScoreLoaded";
		public static var MATCHED_SEQUENCE:String = "StarlingSiteEvent.onMatchedSequence";
		public static var MATCHED:String = "StarlingSiteEvent.onMatched";
		public static var NO_MATCH:String = "StarlingSiteEvent.onNoMatched";
		public static var ASSETS_LOADED:String = "StarlingSiteEvent.onAssetsLoaded";
		public static var ALL_ASSETS_LOADED:String = "StarlingSiteEvent.onAllAssetsLoaded";
		public static var WIN:String = "StarlingSiteEvent.onWin";
		public static var LOSE:String = "StarlingSiteEvent.onLose";
		public static var CARDS_MATCHED:String = "StarlingSiteEvent.onCardsMatched";
		public static var CARD_TOUCHED:String = "StarlingSiteEvent.onCardTouched";
		public static var START_GAME:String = "StarlingSiteEvent.onStartGame";
		public static var BACK_TO_BEGINNING:String = "StarlingSiteEvent.onBackToBeginning";
		public static var INITIALIZE_COMLETE:String = "StarlingSiteEvent.onInitializeComplete";
		public static var INTRO_COMLETE:String = "StarlingSiteEvent.onIntroComplete";
		public static var OUTRO_COMLETE:String = "StarlingSiteEvent.onOutroComplete";
		public static var TOUCHED:String = "StarlingSiteEvent.onTouched";
		public static var WHEEL_SPIN:String = "StarlingSiteEvent.wheel_spin";
		public static var TRANSITION:String = "StarlingSiteEvent.onTransition";
		public static var RESET:String = "StarlingSiteEvent.onReset";
		public static var ANSWER:String = "StarlingSiteEvent.onAnswer";
		public static var BUTTON_PRESS:String = "StarlingSiteEvent.onButtonPress";
		public static var KEYPAD_BUTTON_PRESS:String = "StarlingSiteEvent.onKeypadButtonPress";
		public static var CONFIRM_ANSWER:String = "StarlingSiteEvent.onConfirmAnswer";
		public static var QUESTION:String = "StarlingSiteEvent.onQuestion";
		public static var PLAY_VIDEO:String = "StarlingSiteEvent.onPlayVideo";
		public static var REPLAY_VIDEO:String = "StarlingSiteEvent.onReplayVideo";
		public static var CHANGE:String = "StarlingSiteEvent.onChange";
		public static var READY:String = "StarlingSiteEvent.onReady";
		public static var END:String = "StarlingSiteEvent.onEnd";
		public static var FINAL_VIDEO:String = "StarlingSiteEvent.onFinalVideo";
		public static var GAME_OVER:String = "StarlingSiteEvent.onGameOver";
		public static var GAME_COMPLETE:String = "StarlingSiteEvent.onGameComplete";
		public static var CLOSE_WINDOW:String = "StarlingSiteEvent.onCloseWindow";
		public static var TIMER_COMPLETE:String = "StarlingSiteEvent.onTimerComplete";
		public static var TIMER_BUFFER:String = "StarlingSiteEvent.onTimerBuffer";
		public static var SELECTION:String = "StarlingSiteEvent.onSelection";
		public static var XML_READY:String = "StarlingSiteEvent.onXmlReady";
		public static var VIDEO_XML_READY:String = "StarlingSiteEvent.onVideoXmlReady";
		public static var NEW_GAME:String = "StarlingSiteEvent.onNewGame";
		public static var NEXT_LEVEL:String = "StarlingSiteEvent.onNextLevel";
		public static var NEXT_GAME:String = "StarlingSiteEvent.onNextGame";
		public static var UPDATE:String = "StarlingSiteEvent.onUpdate";
		public static var UPDATE_STAGE:String = "StarlingSiteEvent.onUpdateStage";
		public static var SHOW_PRIZE:String = "StarlingSiteEvent.onShowPrize";
		public static var SUBMIT_CODE:String = "StarlingSiteEvent.onSubmitCode";
		public static var DISABLE_BUTTONS:String = "StarlingSiteEvent.onDisableButtons";
		public static var ENABLE_BUTTONS:String = "StarlingSiteEvent.onEnableButtons";
		public static var SHOW_LINE:String = "StarlingSiteEvent.onShowLine";
		public static var SHOW_GAMECENTER_UI:String = "StarlingSiteEvent.onShowGameCenterUI";
		public static var PLAY_SOUND:String = "StarlingSiteEvent.onPlaySound";
		
		public static var PAUSE:String = "StarlingSiteEvent.onPause";
		public static var RESUME:String = "StarlingSiteEvent.onResume";
		
		public static var PLAY_AGAIN:String = "StarlingSiteEvent.onPlayAgain";
		public static var PLAY_NEXT:String = "StarlingSiteEvent.onPlayNext";
		
		public static var PLAY_GAME:String = "StarlingSiteEvent.onPlayGame";
		public static var PLAY_GAME_CONFIRM:String = "StarlingSiteEvent.onPlayGameConfirm";
		public static var SHOW_PRIZE_MEDIA:String = "StarlingSiteEvent.onShowPrizeMedia";
		public static var DONE:String = "StarlingSiteEvent.onDone";
		public static var VACATION:String = "StarlingSiteEvent.onVacation";
		public static var PLAY_NEXT_AUDIO_TRACK:String = "StarlingSiteEvent.onPlayNextAudioTrack";
		public static var QUIT:String = "StarlingSiteEvent.onQuit";
		
		public static var NEW_TIME:String = "StarlingSiteEvent.onNewTime";
		public static var NEW_BEST_TIME:String = "StarlingSiteEvent.onNewBestTime";
		public static var CLEAR_SCORE:String = "StarlingSiteEvent.onClearScore";
		
		
		public function StarlingSiteEvent(type:String, data:Object=null, bubbles:Boolean=false)
		{
			super(type, bubbles, data);
		}
	}
}