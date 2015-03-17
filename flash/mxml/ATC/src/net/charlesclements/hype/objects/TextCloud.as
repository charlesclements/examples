package net.charlesclements.hype.objects
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class TextCloud extends MovieClip
	{
		
		// Variables
		private var _list:Object;
		private var _words:Array;
		public var text:TextField;
		private var _format:TextFormat;
		private var _timer:Timer;
		private var _incr:int;
		
		
		// Constructor
		public function TextCloud()
		{
			
			super();
			
		}
		
		public function setup($list:Object, $time:int=700):TextCloud
		{
			
			// Sets XmlList.
			_list = $list;
			
			// Actions
			createWords();
			createTextfield();
			applyFormat();
			setupTimer( $time );
			
			return this;
			
		}
		
		
		// Creates an Array of each word that will be used.
		private function createWords():void
		{
			
			_words = [ _list.user.name ].concat( String( _list.text ).split( " " ) );
			trace(_words);
			
		}
		
		
		// Creates visual items on stage;
		private function createTextfield():void
		{
			
			// Textfield stuff.
			text = new TextField;
			text.autoSize = TextFieldAutoSize.CENTER;
			text.border = true;
			text.width = 100;
			text.x = -1 * ( text.width / 2 );
			
			
			//text.text = "HELLO";
			
			
			addChild( text );
			
		}
		
		
		// Creates visual items on stage;
		private function applyFormat():void
		{
			
			// Textformat.
			_format = new TextFormat();
			_format.size = 30;
			text.setTextFormat( _format );
			
		}
		
		
		// Creates visual items on stage;
		private function setupTimer($time:int):void
		{
			
			_timer = new Timer( $time, 0 );
			
		}
		
		
		// Tells anime to start running.
		public function run():TextCloud
		{

			trace("run");
			
			_incr = 0;
			
			_timer.addEventListener( TimerEvent.TIMER, onTimerHandler );
			_timer.start();
			
			return this;
			
		}
		
		// Should kill everything.
		public function kill():TextCloud
		{
			
			_timer.stop();
			_timer.addEventListener( TimerEvent.TIMER, onTimerHandler );
			
			text.text = "";
			
			return this;
			
		}
		
		
		private function onTimerHandler(e:TimerEvent):void
		{
			
			//trace("RUNNING");
			
			if( _incr < _words.length ) text.text = _words[ _incr++ ];
			else _timer.stop();
			
			// Reapply the TextFormat.
			applyFormat();
			
			
			
		}
		
		
	}
}