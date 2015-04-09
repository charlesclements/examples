package events
{
	import flash.events.Event;
	
	import models.CalendarEventModel;
	
	public class CalendarControllerEvent extends Event
	{
		public static const GOT_EVENT:String = "gotEvent";
		
		public var model:CalendarEventModel
		
		public function CalendarControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:CalendarControllerEvent = new CalendarControllerEvent(type, bubbles, cancelable);
			event.model = model;
			return event;
		}
	}
}