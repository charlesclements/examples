package models
{
	import com.adobe.utils.DateUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class CalendarEventModel extends EventDispatcher
	{
		public var id:String;
		public var title:String;
		public var description:String;
		public var date:Date;
		
		public function CalendarEventModel(data:Object = null)
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
			
			if (data.hasOwnProperty("summary"))
			{
				title = data["summary"];
			}
			
			if (data.hasOwnProperty("description"))
			{
				description = data["description"];
			}
			
			if (data.hasOwnProperty("start"))
			{
				var start:Object = data["start"];
				date = DateUtil.parseW3CDTF(start["dateTime"]);
				
				if (title == "Daily Karma")
				{
					var hour:int = date.hours;
					var minutes:int = date.minutes;
					date = new Date();
					date.hours = hour;
					date.minutes = minutes;
				}
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

// json response from google

//		"kind": "calendar#event",
//		"etag": "\"78Bu1G8fWt0vPGZK2Ckfad3ZtNE/Z2NhbDAwMDAxMzY4NjA1NjQ3OTQzMDAw\"",
//		"id": "nb384ojbpnbuk7qap6k2vo5ls0",
//		"status": "confirmed",
//		"htmlLink": "https://www.google.com/calendar/event?eid=bmIzODRvamJwbmJ1azdxYXA2azJ2bzVsczAgd2hvc3lhYnVkZGhhQG0",
//		"created": "2013-05-15T08:14:07.000Z",
//		"updated": "2013-05-15T08:14:07.943Z",
//		"summary": "test event",
//		"creator": {
//			"email": "whosyabuddha@gmail.com",
//			"displayName": "Who'sya Buddha",
//			"self": true
//		},
//		"organizer": {
//			"email": "whosyabuddha@gmail.com",
//			"displayName": "Who'sya Buddha",
//			"self": true
//		},
//		"start": {
//			"dateTime": "2013-05-15T15:00:00+02:00"
//		},
//		"end": {
//			"dateTime": "2013-05-15T16:00:00+02:00"
//		},
//		"iCalUID": "nb384ojbpnbuk7qap6k2vo5ls0@google.com",
//		"sequence": 0,
//		"reminders": {
//			"useDefault": true
//		}