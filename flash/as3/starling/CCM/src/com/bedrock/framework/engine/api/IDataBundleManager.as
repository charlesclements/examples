package com.bedrock.framework.engine.api
{
	import com.bedrock.framework.plugin.storage.HashMap;
	
	public interface IDataBundleManager
	{
		function parse( $data:String ):void;
		
		function getBundle( $id:String, $type:String = null ):*;
		function hasBundle( $id:String ):Boolean;

		function get data():XML;
	}
}