package com.bedrock.framework.plugin.util
{
	import com.bedrock.framework.core.base.StaticBase;

	public class TimeUtil extends StaticBase
	{
		public static function getDisplayTime($time:Object):Object
		{
			var objTemp:Object=new Object;
			objTemp.minutes=TimeUtil.getDisplayMinutes($time.minutes);
			objTemp.seconds=TimeUtil.getDisplaySeconds($time.seconds);
			objTemp.milliseconds=TimeUtil.getDisplayMilliseconds($time.milliseconds);
			return objTemp;
		}
		/*
		Returns formatted minutes as a string.
		*/
		public static function getDisplayMinutes($minutes:Number):String
		{
			var strMinutes:String=$minutes.toString();
			if ($minutes < 10) {
				strMinutes="0" + strMinutes;
			} else if (strMinutes == "60") {
				strMinutes="00";
			}
			return strMinutes;
		}
		/*
		Returns formatted seconds as a string.
		*/
		public static function getDisplaySeconds($seconds:Number):String
		{
			var strSeconds:String=$seconds.toString();
			if ($seconds < 10) {
				strSeconds="0" + strSeconds;
			} else if (strSeconds == "60") {
				strSeconds="00";
			}
			return strSeconds;
		}
		/*
		Returns formatted milliseconds as a string.
		*/
		public static function getDisplayMilliseconds($milliseconds:Number):String
		{
			var strMilliseconds:String=$milliseconds.toString();
			if ($milliseconds < 10) {
				strMilliseconds=TimeUtil.__getZeros(3) + strMilliseconds;
			} else if ($milliseconds < 100) {
				strMilliseconds=TimeUtil.__getZeros(2) + strMilliseconds;
			} else if ($milliseconds < 1000) {
				strMilliseconds=TimeUtil.__getZeros(1) + strMilliseconds;
			}
			return strMilliseconds.substring( 0, 2 );
		}
		private static function __getZeros($total:Number = 0):String
		{
			var strZeros:String = "";
			var numLength:int = $total;
			for (var i:int = 0 ; i < numLength; i++) {
				strZeros += "0";
			}
			return strZeros;
		}
		/*
		Parse getTimer() function into minutes, seconds and millseconds.
		Returns parsed time within an object in numerical format.
		*/
		public static function parseMilliseconds($milliseconds:uint):Object
		{
			var data:Object = new Object;
			data.total = $milliseconds;
			
			data.milliseconds = data.total  % 1000;
			data.minutes = Math.floor(Math.floor(data.total  / 1000) / 60);
			
			if (data.minutes != 0) {
				data.seconds=Math.floor(Math.floor(data.total / 1000) - data.minutes * 60);
			} else {
				data.seconds=Math.floor(data.total  / 1000);
			}
			data.displaySeconds = TimeUtil.getDisplaySeconds( data.seconds );
			data.displayMinutes = TimeUtil.getDisplayMinutes( data.minutes );
			data.displayMilliseconds = TimeUtil.getDisplayMilliseconds( data.milliseconds );
			
			return data;
		}
		
		public static function parseSeconds( $seconds:Number ):Object
		{
			var data:Object = new Object;
			data.total = $seconds;
			
			data.seconds=data.total  % 60;
			data.minutes=Math.floor( data.total  / 60);
			data.milliseconds=data.total  - Math.floor( data.total  );
			
			data.displaySeconds = TimeUtil.getDisplaySeconds( data.seconds );
			data.displayMinutes = TimeUtil.getDisplayMinutes( data.minutes );
			data.displayMilliseconds = TimeUtil.getDisplayMilliseconds( data.milliseconds );
			
			return data;
		}
	}
}