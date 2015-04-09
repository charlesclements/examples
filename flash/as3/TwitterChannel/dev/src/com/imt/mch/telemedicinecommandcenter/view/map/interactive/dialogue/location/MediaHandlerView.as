package com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.dialogue.location
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Power4;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.plugin.slideshow.Slideshow;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import settings.Settings;
	
	public class MediaHandlerView extends Sprite implements IDisplay
	{
		
		
		public var mcDontUseImages:MovieClip;
		//public var slideshow:Slideshow;
		public var slideshow:Slideshow;
		
		
		
		public function MediaHandlerView()
		{
			super();
		}
		
		
		public function initialize():IDisplay
		{
			
			
			//arr.push( new TweenMax( mediaHandler, t, { y:-90, colorTransform:{ tint:0x000000, tintAmount:1 } } ) );
			//TweenMax.to( this, 0, { autoAlpha:0 } );
			
			// Set scale var so that it wont get affected later on a resize.
			//Slideshow.THUMB_ORIGINAL_SCALE = slideshow.thumbnailsContainer.height;
			
			// Get media going.
			slideshow = new SlideshowClip;
			slideshow.initialize();
			addChild( slideshow );
			return null;
			
		}
		
		
		public function refresh():IDisplay
		{
			return null;
		}
		
		
		public function start():IDisplay
		{
			
			// Set scale var so that it wont get affected later on a resize.
			Slideshow.THUMB_ORIGINAL_SCALE = slideshow.thumbnailsContainer.height;
			return null;
			
		}
		
		
		public function intro():IDisplay
		{
			return null;
		}
		
		
		public function outro():IDisplay
		{
			return null;
		}
		
		
		public function clear():IDisplay
		{
			return null;
		}
		
		
		public function destroy():IDisplay
		{
			return null;
		}
		
		
		public function editAnime():TimelineMax
		{
			
			// Do editing tween anime.
			var timeline:TimelineMax = new TimelineMax;
			var t:Number = Settings.ANIMATION_TIME;
			var s:Number = ( 200 / Slideshow.THUMB_ORIGINAL_SCALE );
			//var s:Number = ( 200 / slideshow.thumbnailsContainer.height );// Height could change on a resize.
			var arr:Array = [];
			arr.push( new TweenMax( slideshow.thumbnailsContainer, t * 0.8, { scale:s, x:0, onUpdate:slideshow.blitMask.update, ease:Power4.easeOut } ) );
			arr.push( new TweenMax( slideshow.blitMask, t, { height:200, ease:Power4.easeOut } ) );
			arr.push( new TweenMax( mcDontUseImages, t * 0.8, { delay:t * 0.7, y:40, colorTransform:{ tint:0x000000, tintAmount:0 } } ) );
			timeline.insertMultiple( arr, 0, TweenAlign.NORMAL, 0 );//-0.5
			return timeline;
			
		}
		
	}
		
}