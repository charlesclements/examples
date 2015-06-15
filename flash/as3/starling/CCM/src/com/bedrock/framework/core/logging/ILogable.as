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
package com.bedrock.framework.core.logging
{

	/**
	 *  All loggers within the logging framework must implement this interface.
	 */
	public interface ILogable
	{
		function debug( $trace:*):String;
		function error( $trace:*):String;
		function fatal( $trace:*):String;
		function todo( $trace:*):String;
		function status( $trace:*):String;
		function warning( $trace:*):String;
	}

}