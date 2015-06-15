package com.fatbird.plugins.animation
{
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import starling.display.DisplayObject;

	
	public class Animate extends Object
	{

		
		public function Animate()
		{
			super();
		}
		
		
		public static function blink(o:DisplayObject, blinkNumber:uint=5):void
		{
			
			trace("blink +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
			var d:Number = 0.12
			var arr:Array = [];
			arr.push( new TweenMax( o, d, { y:"10", ease:Linear.easeNone } ) );
			arr.push( new TweenMax( o, d, { y:o.y, ease:Linear.easeNone } ) );
			var t:TimelineMax = new TimelineMax( { repeat:blinkNumber } );
			t.appendMultiple( arr, d, TweenAlign.SEQUENCE );
			t.play( 0 );
			
		}
		
	}
		
}