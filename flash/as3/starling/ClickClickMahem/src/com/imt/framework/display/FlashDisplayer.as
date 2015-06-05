package com.imt.framework.display
{
	import flash.display.Sprite;
	
	
	public class FlashDisplayer extends Sprite
	{
		
		public var currentDisplay:AbstractFlashDisplay;
		
		
		// This class is a container that can only contain one display object.
		public function FlashDisplayer($screen:IDisplay=null)
		{
			
			super();
			if ($screen != null ) change( $screen );
			
		}
		
		
		// Manages the views of Screens.
		public function change($screen:IDisplay=null):FlashDisplayer
		{
			
			trace(this + " : changePanel : " + $screen);
			// Call the clear() function on the existing child if there is one.
			if( numChildren > 0 ) if( getChildAt( 0 ) is IDisplay )( getChildAt( 0 ) as IDisplay ).clear();
			// Remove any children.
			removeChildren();
			//trace(this + " : removeChildren");
			// If $screen exists, add it to the display list.
			if( $screen != null )
			{
				addChild( $screen as Sprite );
				//trace(this + " : added");
				$screen.refresh()//.intro();
				currentDisplay = $screen as AbstractFlashDisplay;
				
			}
			return this;
			
		}
		
	}
	
}