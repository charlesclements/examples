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
package com.bedrock.framework.engine.builder
{
	import com.bedrock.framework.core.base.MovieClipBase;
	
	import flash.text.Font;

	public class SharedFontsBuilder extends MovieClipBase
	{
		public function SharedFontsBuilder()
		{
			super();
		}
		
		protected function registerFont( $font:Class ):void
		{
			Font.registerFont( $font );
		}
	}
}