package com.fatbird.utils
{
	 
	
	public class NumberFormater 
	{

		/*
		public static function formatTime(n:int):String
		{
			var timeMilliseconds:Number = int((n/30) * 100);
	
			var minutes:Number = int(timeMilliseconds / 100 / 60);
			var seconds:Number = int(timeMilliseconds / 100 - (minutes * 60));
			var milliseconds:Number = int(timeMilliseconds - (seconds*100)-(minutes*100 * 60));
			
			var minformat:String = String( (minutes<10)? "0"+minutes : minutes );
			var secformat:String = String( (seconds<10)? "0"+seconds : seconds );
			var milformat:String = String( (milliseconds<10) ? "0"+milliseconds : milliseconds );
			
			return minformat + ":" + secformat + ":" + milformat;
			
		}
		*/
		
		
		/*
		@usage
		var time:String = getTime(....., "-", false, true, true); // returns XX-XX as mins-secs
		*/
		
		public static function formatTime( value:int, separator:String=":", showHrs:Boolean=true, showMins:Boolean=true, showSecs:Boolean=true, showMilliSecs:Boolean=false ) : String
		{
			//milliseconds to hrs:mins:secs
			var hrs_str:String
			var mins_str:String;
			var secs_str:String;
			var milli_str:String;
			var time:String = "";
			
			var milli:Number = 0;
			var secs:Number = 0;
			var mins:Number = 0;
			var hrs:Number = 0;
			
			if( value == 0 ) {
				milli = 0;
				secs = 0;
				mins =0;
				hrs = 0;
			} else {
				milli = Math.floor( value );
				secs = Math.floor( milli/1000 );
				mins = Math.floor(secs/60);
				hrs = Math.floor(mins/60);
				milli %= 1000;
				secs %= 60;
				mins %= 60;
			}
			if( hrs < 10 ){
				hrs_str = "0" + String( hrs );
			}else{
				hrs_str = String( hrs );
			}
			if( mins < 10 ){
				mins_str = "0" + String( mins );
			}else{
				mins_str = String( mins );
			}
			if( secs < 10 ){
				secs_str = "0" + String( secs );
			}else{
				secs_str = String( secs );
			}
			if( milli < 10 ){
				milli_str = "0" + String( milli );
			}else{
				milli_str = String( milli );
			}
			
			if( showHrs ){
				time += hrs_str + separator;
			}
			if( showMins ){
				time += mins_str + separator;
			}
			if( showSecs ){
				time += secs_str + separator;
			}
			if( showMilliSecs ){
				time += milli_str;
			}
			time = time.substring( 0, time.length-1 );
			
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

