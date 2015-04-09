package com.imt.framework.display
{
	
	import com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.dialogue.AbstractDialogue;
	import com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.dialogue.AdvancedDialogue;
	
	import flash.display.Sprite;
	
	public class Container extends Sprite
	{
		
		public var currentWindow:AbstractDialogue;
		
		public function Container($clip:*)
		{
			super();
			
			changePanel( $clip );
			
			
		}
		
		
		// Manages the views of the panels.
		public function changePanel($clip:*=null):Container
		{

			var l:int = numChildren;
			//for( var i:uint = 0; i < l; i++ ) ( removeChildAt( 0 ) as AdvancedDialogue ).stopTimer();
			for( var i:uint = 0; i < l; i++ ) removeChildAt( 0 );
			if( $clip ) addChild( $clip );
			
			return this;
			
		}
		
	}
	
}