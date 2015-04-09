package models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class TweetModelNew extends EventDispatcher
	{
		public var id:int;
		public var message:String;
		public var type:String
		
		public function TweetModelNew(data:Object = null)
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
			
			if (data.hasOwnProperty("message"))
			{
				message = data["message"];
			}
			
			if (data.hasOwnProperty("type"))
			{
				type = data["type"];
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}