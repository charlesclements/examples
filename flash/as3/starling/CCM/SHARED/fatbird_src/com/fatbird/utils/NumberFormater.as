package com.fatbird.utils
{
	 
	
	public class NumberFormater 
	{


		// Vars.
		// Strings.
		private static var hrs_str:String
		private static var mins_str:String;
		private static var secs_str:String;
		private static var milli_str:String;
		private static var time:String = "";
		
		// Numbers.
		private static var milli:Number = 0;
		private static var secs:Number = 0;
		private static var mins:Number = 0;
		private static var hrs:Number = 0;
		
		
		// Format a given time value.
		public static function formatTime( value:int, separator:String=":", showHrs:Boolean=true, showMins:Boolean=true, showSecs:Boolean=true, showMilliSecs:Boolean=false ) : String
		{
			
			//trace("NumberFormater : " + value);
			
			// Clear vars.
			hrs_str = mins_str = secs_str = milli_str = time = "";
			
			// Check if value is 0 or continue.
			if( value == 0 ){ milli = secs = mins = hrs = 0; } 
			else 
			{
				
				milli = Math.floor( value );
				secs = Math.floor( milli/1000 );
				mins = Math.floor(secs/60);
				hrs = Math.floor(mins/60);
				milli %= 1000;
				secs %= 60;
				mins %= 60;
				
			}
			
			// Check double and single digit placements.
			if( hrs < 10 ){ hrs_str = "0" + String( hrs ); }
			else{ hrs_str = String( hrs ); }
			if( mins < 10 ){ mins_str = "0" + String( mins ); }
			else{ mins_str = String( mins ); }
			if( secs < 10 ){ secs_str = "0" + String( secs ); }
			else{ secs_str = String( secs ); }
			
			//trace( "milli : " + milli );
			
			if( milli < 10 ){ milli_str = "00" + String( milli ); }
			else{ milli_str = String( milli ); }
			
			// Check what to display.
			if( showHrs ){ time += hrs_str + separator; }
			if( showMins ){ time += mins_str + separator; }
			if( showSecs ){ time += secs_str + separator; }
			if( showMilliSecs ){ time += milli_str; }
			time = time.substring( 0, time.length-1 );
			
			// Return formatted time.
			return time;
			
		}
		
		
		public static function formatTimeWithDays(n:Number):String
		{
			var timeSeconds:Number = n / 1000;
			var timeLeft:Number = timeSeconds;
			
			var days:Number = Math.floor(timeLeft / 86400);
			timeLeft -= days * 86400;
			
			var hours:Number =  Math.floor(timeLeft / 3600);
			timeLeft -= hours * 3600;
			
			var minutes:Number =  Math.floor(timeLeft / 60);
			timeLeft -= minutes * 60;
			
			var seconds:Number =  Math.floor(timeLeft);
			
			var dayformat:String = String( (days<10)? "0"+days : days );			var hourformat:String = String( (hours<10)? "0"+hours : hours );			var minformat:String = String( (minutes<10)? "0"+minutes : minutes );
			var secformat:String = String( (seconds<10)? "0"+seconds : seconds );
			
			return dayformat + ":" + hourformat + ":" + minformat + ":" + secformat;
		}
		
		
		public static function formatMoney(n:Number):String
		{
			
			var nArray:Array = String(n).split("");
			var text:String = "$";
			var total : int = nArray.length;
			
			var offset:Number = (total % 3)-1;
			for(var i:int = 0; i < total; i++)
			{
				text += nArray[i];
				if((i - offset) % 3 == 0 && i != total-1)text+=",";	
			}
			
			return text;
		}
		
		
		public static function formatNumber(n:Number):String
		{
			
			var nArray:Array = String(n).split("");
			var text:String = "";
			var total : int = nArray.length;
			
			var offset:Number = (total % 3)-1;
			for(var i:int = 0; i < total; i++)
			{
				text += nArray[i];
				if((i - offset) % 3 == 0 && i != total-1)text+=",";	
			}
			
			return text;
		}
		
		
		public static function formatPosition(n:Number):String
		{
			var sn:String = String(n).substr(-1, 1);
			
			if(sn == "1")
			{
				return n + "st";
			}
			else if(sn == "2")
			{
				return n + "nd";
			}
			else if(sn == "3")
			{
				return n + "rd";
			}
			
			return n + "th";
			
		}

	}

}

