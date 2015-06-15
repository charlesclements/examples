﻿/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
*/
package com.bedrock.framework.core.logging
{
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.core.event.LogEvent;
	
	import flash.utils.Dictionary;

	public class EventLogger implements ILogger
	{
		private var _categoryDictionary:Dictionary;
		
		public function EventLogger()
		{
			this.createCategoryLabels();
		}
		
		private function createCategoryLabels():void
		{
			this._categoryDictionary = new Dictionary;
			this._categoryDictionary[LogLevel.DEBUG.toString()] = LogEvent.DEBUG;
			this._categoryDictionary[LogLevel.ERROR.toString()] = LogEvent.ERROR;
			this._categoryDictionary[LogLevel.FATAL.toString()] = LogEvent.FATAL;
			this._categoryDictionary[LogLevel.STATUS.toString()] = LogEvent.STATUS;
			this._categoryDictionary[LogLevel.WARNING.toString()] = LogEvent.WARNING;
		}
		
		
		public function log( $trace:*, $data:LogData ):String
		{
			BedrockDispatcher.dispatchEvent( new LogEvent( this._categoryDictionary[ $data.category ], this, $data ) );
			return null;
		}
		
	}
}