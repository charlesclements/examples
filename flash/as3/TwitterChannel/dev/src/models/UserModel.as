package models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class UserModel extends EventDispatcher
	{
		public var id:Number;
		public var firstname:String;
		public var lastname:String;
		public var twittername:String;
		public var rfid:String;
		
		public function UserModel(data:Object = null)
		{
			if (data)
			{
				fillModel(data);
			}
		}
		
		public function fillModel(data:Object):void
		{
			if (data.hasOwnProperty("id"))
			{
				id = data["id"];
			}
			
			if (data.hasOwnProperty("firstname"))
			{
				firstname = data["firstname"];
			}
			
			if (data.hasOwnProperty("lastname"))
			{
				lastname = data["lastname"];
			}
			
			if (data.hasOwnProperty("twittername"))
			{
				twittername = data["twittername"];
			}
			
			if (data.hasOwnProperty("rfid"))
			{
				rfid = data["rfid"];
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}