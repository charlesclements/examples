package com.bedrock.framework.engine.data
{
	import com.bedrock.framework.plugin.util.VariableUtil;
	
	dynamic public class GenericData
	{
		public function GenericData( $data:Object )
		{
			for (var d:String in $data) {
				this[ d ] = $data[ d ];
			}
		}
		
		public function export():Object
		{
			var data:Object = new Object;
			var p:String;
			for ( p in this ) {
				data[ p ] = this[ p ];
			}
			for each ( p in VariableUtil.getVariables( this ) ) {
				data[ p ] = this[ p ];
			}
			return data;
		}

	}
}