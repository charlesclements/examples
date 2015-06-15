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
package com.bedrock.framework.plugin.view
{
	import flash.events.IEventDispatcher;
	
	public interface IView extends IEventDispatcher
	{
		function initialize($data:Object=null):void;
		function intro($data:Object=null):void;
		function outro($data:Object=null):void;
		function clear():void;
		
		function get hasInitialized():Boolean;
	}
}