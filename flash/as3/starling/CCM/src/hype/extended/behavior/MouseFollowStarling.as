/**
 *
 *   Joshua Davis
 *   http://www.joshuadavis.com
 *   studio@joshuadavis.com
 *
 *   Sep 25, 2009
 *
 */
 
package hype.extended.behavior {
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.behavior.IBehavior;
	
	import starling.display.DisplayObject;

	//import flash.display.DisplayObject;

	/**
	 * Makes the target track the mouse
	 */
	public class MouseFollowStarling extends AbstractBehavior implements IBehavior {

		/**
		 * Constructor
		 * 
		 * @param target Target object
		 */
		public function MouseFollowStarling(target:Object) {
			trace("MouseFollowStarling");
			super(target);
		}

		/**
		 * @protected
		 */
		public function run(target:Object):void {
			
			trace("MouseFollowStarling run");
			trace(target);
			
			var myTarget:DisplayObject = target as DisplayObject;
			
			myTarget.x = myTarget.stage.mouseX;
			myTarget.y = myTarget.stage.mouseY;
		}
	}
}
