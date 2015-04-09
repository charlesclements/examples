package events
{
	import flash.events.Event;
	
	public class ArduinoControllerEvent extends Event
	{
		static public const RFID_FOUND:String = "rfidFound";
		
		public var rfid:String;
		
		public function ArduinoControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:ArduinoControllerEvent = new ArduinoControllerEvent(type, bubbles, cancelable);
			event.rfid = rfid;
			return event;
		}
	}
}