package com.bedrock.framework.engine.data
{
	dynamic public class BedrockContentGroupData extends BedrockContentData
	{
		public var contents:Array;
		
		public function BedrockContentGroupData( $data:Object )
		{
			super( $data );
			this.contents = new Array;
		}
	}
}