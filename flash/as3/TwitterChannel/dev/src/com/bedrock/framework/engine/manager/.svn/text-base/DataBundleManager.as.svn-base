package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IDataBundleManager;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.util.VariableUtil;
	import com.bedrock.framework.plugin.util.XMLUtil2;
	
	public class DataBundleManager extends StandardBase implements IDataBundleManager
	{
		/*
		Variable Declarations
		*/
		private var _data:XML;
		/*
		Constructor
		*/
		public function DataBundleManager()
		{
			XML.ignoreComments = true;
			XML.ignoreWhitespace = true;
		}
		/*
		Creation Functions
		*/
		public function parse( $data:String ):void
		{
			this._data = new XML( $data );
		}
		public function getBundle( $id:String, $type:String = null ):*
		{
			var bundleType:String = $type || this._getBundleAsXML( $id ).@type;
			switch( bundleType ) {
				case "object" :
					return this._getBundleAsObject( $id );
					break;
				case "hashmap" :
					return this._getBundleAsHashMap( $id );
					break;
				case "array" :
					return this._getBundleAsArray( $id );
					break;
				case "xml" :
					return this._getBundleAsXML( $id );
					break;
			}
		}
		public function hasBundle( $id:String ):Boolean
		{
			return ( this._getBundleAsXML( $id ) != null );
		}
		/*
		Get Functions
		*/
		private function _getBundleAsXML( $id:String ):XML
		{
			return XMLUtil2.sanitizeXML( XMLUtil2.filterByAttribute( this._data, "id", $id ) );
		}
		private function _getBundleAsObject( $id:String ):Object
		{
			return XMLUtil2.getAsObject( this._getBundleAsXML( $id ) );
		}
		private function _getBundleAsHashMap( $id:String ):HashMap
		{
			var objData:Object = this._getBundleAsObject( $id );
			var mapData:HashMap = new HashMap();
			mapData.importObject( objData );
			return mapData;
		}
		private function _getBundleAsArray( $id:String ):Array
		{
			var arrData:Array = new Array;
			var xmlData:XML = this._getBundleAsXML( $id );
			for each ( var xmlItem:XML in xmlData.children() ) {
				if ( xmlItem.hasComplexContent() ) {
					arrData.push( XMLUtil2.getAsObject( xmlItem ) );
				} else {
					if ( xmlItem.attributes().length() > 0 ) {
						arrData.push( XMLUtil2.getAsObject( xmlItem ) );
					} else {
						arrData.push( VariableUtil.sanitize( xmlItem.toString() ) );
					}
				}
			}
			return arrData;
		}
		/*
		Property Definitions
		*/
		public function get data():XML
		{
			return this._data;
		}
	}
}