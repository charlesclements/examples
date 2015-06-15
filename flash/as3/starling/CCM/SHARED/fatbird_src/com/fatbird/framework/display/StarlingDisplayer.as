package com.fatbird.framework.display
{
	
	
	import starling.display.Sprite;
	
	
	public class StarlingDisplayer extends starling.display.Sprite
	{
		
		// This class is a container that can only contain one display object.
		public var currentDisplay:IDisplay;
		
		
		public function StarlingDisplayer($screen:IDisplay=null)
		{
			
			super();
			if ($screen != null ) change( $screen );
			
		}
		
		
		// Manages the views of Screens.
		public function change($display:IDisplay=null):StarlingDisplayer
		{
			
			//trace(this + " : change : " + $screen);
			// Call the clear() function on the existing child if there is one.
			if( numChildren > 0 ) if( getChildAt( 0 ) is IDisplay )( getChildAt( 0 ) as IDisplay ).clear();
			// Remove any children.
			removeChildren();
			// If $screen exists, add it to the display list.
			if( $display != null )
			{
				addChild( $display as Sprite );
				$display.refresh();
				
			}
			// Set the currentDisplay whether it is null or defined. 
			currentDisplay = $display;
			// Return the currentDisplay as an IDisplay.
			return this;
			
		}
		
		
	}
	
}