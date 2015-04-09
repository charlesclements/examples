package com.imt.framework.plugin.slideshow
{
	import flash.display.Sprite;
	import com.imt.framework.gadget.slideshow.Slideshow;
	
	public class MediaContainer extends Sprite
	{
		
		
		
		private var slideshow:Slideshow;
		
		
		public function MediaContainer()
		{
			super();
			
			
			slideshow = new SlideshowClip;
			addChild( slideshow );
			slideshow.initialize();
			
			
			
		}
	}
}