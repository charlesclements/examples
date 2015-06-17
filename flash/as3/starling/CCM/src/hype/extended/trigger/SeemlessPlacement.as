// Class created/modified by:
// Charles D Clements, Fast In Demand!
// CharlesClements@gmail.com

// I was using Hype within Starling, I generated particles 

package hype.extended.trigger {
	import flash.geom.Rectangle;
	
	import hype.framework.trigger.AbstractTrigger;
	import hype.framework.trigger.ITrigger;
	
	import starling.display.DisplayObject;

	//import flash.display.DisplayObject;

	/**
	 * Trigger that fires when an object has exited from a shape.
	 */
	public class SeemlessPlacement extends AbstractTrigger implements ITrigger {
		//protected var _shape:DisplayObject;
		protected var _rect:Rectangle;
		//protected var _shapeFlag:Boolean;
		protected var _enterFlag:Boolean;
		
		
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
		public function SeemlessPlacement(callback:Function, target:Object, rectangle:Rectangle, enterOnceFlag:Boolean=false) {
			super(callback, target);
			//_shape = shape;
			
			_rect = rectangle;
			
			
			//_shapeFlag = shapeFlag;
			
			_enterFlag = !enterOnceFlag;
		}
		
		public function run(target:Object):Boolean 
		{
			
			var result:Boolean = false;
			var c:DisplayObject = target as DisplayObject;
			
			
			
			// Do conditional in here.
			
			if( c.x < _rect.x ) c.x = _rect.width + _rect.y - 3;
			if( c.x > _rect.width ) c.x = _rect.y + 3;
			if( c.y < _rect.y ) c.y = _rect.height + _rect.y - 3;
			if( c.y > _rect.height ) c.y = _rect.y + 3;
			
			/*
			// if clip is inside.
			if ( displayTarget.x > _rect.x && displayTarget.x < _rect.width + _rect.x && displayTarget.y > _rect.y && displayTarget.y < _rect.height + _rect.y ) {
				_enterFlag = true;
			} else if (_enterFlag) {
				result = true;
				
				
			}
			*/
			return result;
		}
	}
}















