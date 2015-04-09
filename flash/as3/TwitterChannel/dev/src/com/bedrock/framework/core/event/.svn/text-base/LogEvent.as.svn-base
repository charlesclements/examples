/**
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
package com.bedrock.framework.core.event
{
	import com.bedrock.framework.core.event.GenericEvent;

	public class LogEvent extends GenericEvent
	{
		
		public static const FATAL:String = "LogEvent.onFatal";
	    public static const ERROR:String = "LogEvent.onError";
	    public static const WARNING:String = "LogEvent.onWarning";
	    public static const DEBUG:String = "LogEvent.onDebug";
	    public static const STATUS:String = "LogEvent.onStatus";	
		
		
		public function LogEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}