package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IAssetManager;
	import com.bedrock.framework.engine.data.BedrockAssetData;
	import com.bedrock.framework.engine.data.BedrockAssetGroupData;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	import com.bedrock.framework.plugin.util.XMLUtil2;

	public class AssetManager extends StandardBase implements IAssetManager
	{
		/*
		Variable Declarations
		*/
		private var _assets:HashMap;
		/*
		Constructor
	 	*/
	 	public function AssetManager()
		{
			super();
		}
		public function initialize( $data:XML ):void
		{
			this._parse( $data );
		}
		private function _parse( $data:XML ):void
		{
			this._assets = new HashMap;
			var assetGroupData:BedrockAssetGroupData;
			for each( var assetGroupXML:XML in $data.children() ) {
				assetGroupData = new BedrockAssetGroupData( XMLUtil2.getAttributesAsObject( assetGroupXML ) );
				for each( var assetXML:XML in assetGroupXML.children() ) {
					assetGroupData.assets.push( new BedrockAssetData( XMLUtil2.getAttributesAsObject( assetXML ) ) );
				}
				this.addGroup( assetGroupData );
			}
		}
		public function addGroup( $group:BedrockAssetGroupData ):void
		{
			this._assets.saveValue( $group.id, $group );
		}
		public function getGroup( $id:String ):BedrockAssetGroupData
		{
			return this._assets.getValue( $id );
		}
		public function hasGroup( $id:String ):Boolean
		{
			return this._assets.containsKey( $id );
		}
		public function filterGroups( $value:*, $field:String ):Array
		{
			return ArrayUtil.filter( this._assets.getValues(), $value, $field );
		}
		
		public function addAssetToGroup( $groupID:String, $asset:BedrockAssetData ):void
		{
			if ( this.hasGroup( $groupID ) ) {
				this.getGroup( $groupID ).assets.push( $asset );
			}
		}
	 	/*
		Accessors
	 	*/
		public function get data():HashMap
		{
			return this._assets;
		}
		
	}
}