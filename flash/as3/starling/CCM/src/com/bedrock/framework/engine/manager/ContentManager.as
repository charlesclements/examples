package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IContentManager;
	import com.bedrock.framework.engine.data.BedrockContentData;
	import com.bedrock.framework.engine.data.BedrockContentGroupData;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	import com.bedrock.framework.plugin.util.XMLUtil2;

	public class ContentManager extends StandardBase implements IContentManager
	{
		/*
		Variable Declarations
		*/
		private var _contents:Array;
		/*
		Constructor
		*/
		public function ContentManager()
		{
		}
		
		public function initialize( $data:XML ):void
		{
			this._parse( $data );
		}
		private function _parse( $data:XML ):void
		{
			this._contents = new Array;
			var contentData:BedrockContentData;
			for each( var contentXML:XML in $data..content ) {
				contentData = new BedrockContentData( XMLUtil2.getAttributesAsObject( contentXML ) );
				this.addContent( contentData );
			}
			var contentGroupData:BedrockContentGroupData;
			var subContentData:BedrockContentData;
			for each ( var contentGroupXML:XML in $data..contentGroup ) {
				contentGroupData = new BedrockContentGroupData( XMLUtil2.getAttributesAsObject( contentGroupXML ) );
				for each( var subContentXML:XML in contentGroupXML..content ) {
					subContentData = this.getContent( subContentXML.@id );
					subContentData[ BedrockData.INITIAL_TRANSITION ] = false;
					contentGroupData.deeplink += subContentData.id + "/"; 
					contentGroupData.contents.push ( subContentData ); 
				}
				contentGroupData.contents.sortOn( BedrockData.PRIORITY, Array.DESCENDING | Array.NUMERIC );
				this.addContent( contentGroupData );
			}
			
			this._contents.sortOn( BedrockData.PRIORITY, Array.DESCENDING | Array.NUMERIC );
		}
		public function addContent( $data:BedrockContentData ):void
		{
			if ( $data.id != null && !this.hasContent( $data.id ) ) {
				this._contents.push( $data );
			} else {
				this.error( "Content missing id!" );
			}
		}
		public function addAssetToContent( $contentID:String, $asset:Object ):void
		{
			if ( this.hasContent( $contentID ) ) {
				$asset.parentContent = $contentID;
				var content:Object = this.getContent( $contentID );
				content.assets.push( $asset );
			}  else {
				this.warning( "Content \"" + $contentID + "\" does not exist!" );
			}
		}
		public function getContent( $id:String ):BedrockContentData
		{
			if ( this.hasContent( $id ) ) {
				return this._contents[ ArrayUtil.findIndex( this._contents, $id, "id" ) ];
			} else {
				this.warning( "Content \"" + $id + "\" does not exist!" );
				return null;
			}
		}
		public function hasContent( $id:String ):Boolean
		{
			return ArrayUtil.containsItem( this._contents, $id, "id" );
		}
		public function filterContents( $value:*, $field:String ):Array
		{
			return ArrayUtil.filter( this._contents, $value, $field );
		}
		
		
		public function get data():Array
		{
			return this._contents;
		}
		
	}
}