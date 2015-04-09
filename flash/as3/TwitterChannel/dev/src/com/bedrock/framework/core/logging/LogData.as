package com.bedrock.framework.core.logging
{
	import com.bedrock.framework.plugin.trigger.Trigger;
	
	import flash.utils.Dictionary;
	
	public class LogData
	{
		public var className:String;
		public var functionName:String;
		public var classPath:String;
		public var timeStamp:String;
		public var detailLow:String;
		public var detailMedium:String;
		public var detailHigh:String;
		public var category:uint;
		public var categoryLabel:String;
		public var categoryColor:uint;
		
		private static const __STACK_LINE:int = 4;
		private static var __trigger:Trigger;
		private static var __colors:Dictionary;
		private static var __labels:Dictionary;
		private static var __initialized:Boolean = false;
		
		public function LogData( $error:Error, $category:uint )
		{
			if ( LogData.__initialized == false ) {
				LogData.__createTrigger();
				LogData.__createCategoryColors();
				LogData.__createCategoryLabels();
				LogData.__initialized = true;
			}
			
			this._applyTimeStamp();
			this._parseStackTrace( $error );
			
			this.category = $category;
			
			this.categoryColor = LogData.__colors[ $category.toString() ];
			this.categoryLabel ="[" +  LogData.__labels[ $category.toString() ] + "] ";
		}
		
		private function _parseStackTrace( $error:Error ):void
		{
			var stackTrace:String = $error.getStackTrace();
			
			var lines:Array = stackTrace.split("\n");
			var relevantLine:String = lines[ LogData.__STACK_LINE ];
			var startIndex:int;
			var endIndex:int;
			var culledLine:String;
			
			//Grab class path
			startIndex = relevantLine.indexOf("at");
			endIndex = relevantLine.indexOf("::");
			this.classPath = relevantLine.substring(startIndex + 3, endIndex);
			
			//Grab class name
			startIndex = relevantLine.indexOf("::");
			endIndex = relevantLine.indexOf("/");
			this.className = relevantLine.substring(startIndex + 2, endIndex);
			
			//Grab function name
			culledLine = relevantLine.substring(endIndex + 1, relevantLine.length);
			startIndex = culledLine.indexOf("::");
			endIndex = culledLine.lastIndexOf(")");
			this.functionName = culledLine.substring(startIndex + 1, endIndex + 1);
			
			this.detailLow = "[" + this.className + "] ";
			this.detailMedium = "[" + this.className + "." + this.functionName + "] ";
			this.detailHigh = "[" + this.classPath + "::" + this.className + "." + this.functionName + "] ";
		}
		
		private function _applyTimeStamp():void
		{
			var time:Object = LogData.__trigger.elapsed;
			this.timeStamp = "[" + time.displayMinutes + ":" + time.displaySeconds + ":" + time.displayMilliseconds + "] ";
		}
		
		private static function __createTrigger():void
		{
			LogData.__trigger = new Trigger;
			LogData.__trigger.silenceLogging = true;
			LogData.__trigger.startStopwatch( 0.01 );
		}
		private static function __createCategoryColors():void
		{
			LogData.__colors = new Dictionary;
			LogData.__colors[ LogLevel.STATUS.toString() ] = 0x33cc33;
			LogData.__colors[ LogLevel.TODO.toString() ] = 0x0000ff;
			LogData.__colors[ LogLevel.DEBUG.toString() ] = 0x0033cc;
			LogData.__colors[ LogLevel.WARNING.toString() ] = 0xff9900;
			LogData.__colors[ LogLevel.ERROR.toString() ] = 0xcc0000;
			LogData.__colors[ LogLevel.FATAL.toString() ] = 0xff00ff;
		}
		private static function __createCategoryLabels():void
		{
			LogData.__labels = new Dictionary;
			LogData.__labels[ LogLevel.STATUS.toString() ] = "STATUS";
			LogData.__labels[ LogLevel.TODO.toString() ] = "TO-DO";
			LogData.__labels[ LogLevel.DEBUG.toString() ] = "DEBUG";
			LogData.__labels[ LogLevel.WARNING.toString() ] = "WARNING";
			LogData.__labels[ LogLevel.ERROR.toString() ] = "ERROR";
			LogData.__labels[ LogLevel.FATAL.toString() ] = "FATAL";
		}
		
	}
}