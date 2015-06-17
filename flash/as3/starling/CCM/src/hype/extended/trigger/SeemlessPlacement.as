// Created/modified by:
// Charles D Clements, Fast In Demand
// CharlesClements@gmail.com

// I was using Hype within Starling for generated particles.

package hype.extended.trigger {
	import flash.geom.Rectangle;
	
	import hype.framework.trigger.AbstractTrigger;
	import hype.framework.trigger.ITrigger;
	
	import starling.display.DisplayObject;


	/**
	 * Trigger that fires when an object has exited from a shape.
	 */
	public class SeemlessPlacement extends AbstractTrigger implements ITrigger 
	{
		
		
		protected var _rect:Rectangle;
		
		
		/**
		 * Constructor
		 * 
		 * @param callback Function to call when this trigger fires
		 * @param target Target object to track
		 * @param shape DisplayObject that defines the shape
		 * @param enterOnceFlag True if the target must enter the shape at least once to fire trigger 
		 * @param shapeFlag True if the actual shape of the shape is to be used (defaults to false)
		 * @param enterOnceFlag True if the object must enter the shape at least once (defaults to false)
		 */
		public function SeemlessPlacement(target:Object, rectangle:Rectangle) 
		{
			
			super( function(){}, target);
			_rect = rectangle;
			
		}
		
		
		public function run(target:Object):Boolean 
		{
			
			// Do conditional placement.
			var c:DisplayObject = target as DisplayObject;
			if( c.x < _rect.x ) c.x = _rect.width + _rect.y - 3;
			if( c.x > _rect.width ) c.x = _rect.y + 3;
			if( c.y < _rect.y ) c.y = _rect.height + _rect.y - 3;
			if( c.y > _rect.height ) c.y = _rect.y + 3;
			
			return false;
		}
	
		
	}
	
	
}















