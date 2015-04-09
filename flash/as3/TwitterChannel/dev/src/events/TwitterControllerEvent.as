package events
{
	import flash.events.Event;
	
	public class TwitterControllerEvent extends Event
	{
		static public const GOT_MENTION:String = "gotMention";
		
		public var data:*;
		
		public function TwitterControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:TwitterControllerEvent = new TwitterControllerEvent(type, bubbles, cancelable);
			event.data = data;
			return event;
		}
	}
}