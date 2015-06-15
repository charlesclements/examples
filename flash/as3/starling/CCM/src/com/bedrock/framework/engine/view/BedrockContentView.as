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
package com.bedrock.framework.engine.view
{
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.view.MovieClipView;
	import com.bedrock.framework.engine.data.BedrockContentData;

	public class BedrockContentView extends MovieClipView
	{
		/*
		Variable Declarations
		*/
		public var data:BedrockContentData;
		public var assets:HashMap;
		public var bundle:*;
		/*
		Constructor
		*/
		public function BedrockContentView()
		{
			super();
		}
		
	}
	
}