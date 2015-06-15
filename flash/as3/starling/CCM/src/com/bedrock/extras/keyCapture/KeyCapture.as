package com.bedrock.extras.keyCapture
{
	import com.bedrock.framework.core.base.DispatcherBase;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class KeyCapture extends DispatcherBase
	{
		/*
		Variable Declarations
		*/	
		private var _stage:Stage;
		private var _phrases:Array;
		private var _capture:String;
		/*
		Constructor
		*/				
		public function KeyCapture()
		{
			this.reset();
		}
		
		public function initialize( $stage:Stage ):void
		{
			this.status("Initialized!");
			this._stage = $stage;
			this._stage.addEventListener( KeyboardEvent.KEY_DOWN, this._onKeyDownHandler);
		}
		public function reset():void
		{
			this._phrases = new Array;
			this._capture = "";
		}
		public function clear():void
		{
			this._stage.removeEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDownHandler);
		}
		
		public function addPhrase($phrase:String):void
		{
			this._phrases.push( $phrase );
		}
		/*
	
		*/
		/*
		Add Character to phrase
		*/
		private function _addCharacterToCapture($character:String):String
		{
			this._capture += $character;
			return this._capture;
		}
		private function _searchForPhrase($capture:String):void
		{
			for each ( var phrase:String in this._phrases ) {
				if ( $capture.search( phrase.toUpperCase() ) != -1 ) {
					this.status("Phrase matched!");
					this.dispatchEvent(new KeyCaptureEvent( KeyCaptureEvent.PHRASE_MATCHED, this, { phrase:strPhrase.toLowerCase() } ) );
					this.reset();
				}
			}
		}
		/*
		Event Handlers
		*/
		private function _onKeyDownHandler($event:KeyboardEvent):void
		{
			this._searchForPhrase( this._addCharacterToCapture( String.fromCharCode($event.keyCode ) ) );
		}
		/*
		Property Definitions
		*/
	}
}