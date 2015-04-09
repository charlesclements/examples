
package events
{
	import flash.events.Event;
	
	import models.UserModel;
	
	public class UserDBControllerEvent extends Event
	{
		static public const USER_FOUND:String = "userFound";
		static public const NO_USER_FOUND:String = "noUserFound";
		
		public var user:UserModel;
		
		public function UserDBControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:UserDBControllerEvent = new UserDBControllerEvent(type, bubbles, cancelable);
			event.user = user;
			return event;
		}
	}
}