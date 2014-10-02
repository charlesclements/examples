package com.bedrock.framework.engine.data
{
	dynamic public class BedrockAssetGroupData extends GenericData
	{
		public var id:String;
		public var initialLoad:Boolean;
		public var assets:Array;
		
		public function BedrockAssetGroupData( $data:Object )
		{
			super( $data );
			this.assets = new Array;
		}
		
	}
}