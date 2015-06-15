package com.imt.framework.gadget.twitter
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class TweetCloud extends MovieClip
	{
		public function TweetCloud()
		{
			super();
		}
		
		public var info:MovieClip;
		private var _text:TextField;
		
		
		// Draws a line to the target.
		public function setup($xml:XML, $delay:Number=0):TweetCloud
		{
			
			//trace("TweetCloud setup");
			
			target.gotoAndStop( "BIG" );
			
			_list = new XMLList( $xml );
			
			TweenMax.delayedCall( $delay, createTweetCloud );
			
			return this;
			
		}
		
		
		// Creates everything in the TweetCloud after delay.
		private function createTweetCloud():void
		{
			
			// Target property.
			target.x = new uint( _list[0].target.@x );
			target.y = new uint( _list[0].target.@y );
			target.scaleX = target.scaleY = 0.1;
			
			// Text placement..
			info.x = new uint( _list[0].content.@x );
			info.y = new uint( _list[0].content.@y );
			
			// Create satellite for text to follow.
			_satellite = new Sprite;
			_satellite.x = info.x;
			_satellite.y = info.y;
			addChild( _satellite );
			
			// Behaviour stuff.
			_rhythm = new SimpleRhythm( run );
			_swarm = new Swarm( _satellite, new Point(target.x, target.y), 1, 0.05, 30 );
			
			// Add line.
			_line = new Sprite;
			addChild( _line );
			
			
			var s:Number = 4;
			var t:Number = 1;
			TweenMax.to( target, t, { scaleX:s, scaleY:s, ease:Elastic.easeOut } );
			TweenMax.delayedCall( t * 0.7, showText );
			TweenMax.to( target, 2, { delay:t + 0.2, scaleX:1, scaleY:1, ease:Elastic.easeInOut, onComplete:introTargetComplete } );
			
		}
		
		
		private function showText():void
		{
			
			trace("showText")
			// Setup Textfield and Draw line immediately.
			setupTextfield().setupTextformat().addBehaviour().update().randomizeText();
			
		}
		
		
		private function introTargetComplete():void
		{
			
			// Play pulsing.
			target.play();
			
		}
		
		
		
		
		
		// Formats the text for display.
		private function setupTextfield():TweetCloud
		{
			
			_text = ( info.txt as TextField );
			_text.text = "Loading...";
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.width = 300;
			//_text.border = true;
			
			return this;
			
		}
		
		
		
		// Formats the text for display.
		private function setupTextformat():TweetCloud
		{
			
			_textformat = new TextFormat();
			//_textformat.font = "Stratum";
			_textformat.color = 0xffffff;
			_textformat.size = 12;
			
			return this;
		}
		
		
		private function randomizeText():TweetCloud
		{
			
			
			var t:TextRandomizer = new TextRandomizer( 50, [ { textfield:_text, step:0, value:_content, inc:2, aheadCount:4 } ] );
			t.start();
			//t.
			
			return this;
			
		}
		
		
		
		
		// Updates the text and the lines.
		public function update():TweetCloud
		{
			
			addText().drawLine();
			
			return this;
			
		}
		
		
		// Updates the text and the lines.
		public function addBehaviour():TweetCloud
		{
			
			
			_swarm.start();
			_rhythm.start();
			
			return this;
			
		}
		
		
	}
}