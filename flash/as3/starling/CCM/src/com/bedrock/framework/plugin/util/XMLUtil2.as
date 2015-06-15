package com.bedrock.framework.plugin.util
{
	import com.bedrock.framework.core.base.StaticBase;
	
	public class XMLUtil2 extends StaticBase
	{
		
		public static function getAsObject( $data:* ):Object
		{
			return VariableUtil.combineObjects(  XMLUtil2.getAttributesAsObject( $data ), XMLUtil2.getNodesAsObject( $data ) );
		}
		
		public static function getNodesAsObject( $data:* ):Object
		{
			var xmlData:XML = XMLUtil2.sanitizeXML( $data );
			var objConversion:Object = new Object;
			
			if ( xmlData.hasComplexContent() ) {
				var numLength:Number = xmlData.children().length();
				for (var i:int = 0; i  < numLength; i++) {
					objConversion[ xmlData.child( i ).name() ] = VariableUtil.sanitize( xmlData.child( i ) );
				}
			}
			return objConversion;
		}
		public static function getAttributesAsObject( $node:* ):Object
		{
			var objResult:Object = new Object();
			
			var xmlTemp:XMLList = new XMLList($node);
			var xmlAttributes:XMLList = xmlTemp.attributes();
			
			var numLength:int = xmlAttributes.length();
			for (var i:int = 0; i < numLength; i ++) {
				objResult[ xmlAttributes[ i ].name().toString() ] = VariableUtil.sanitize( xmlAttributes[ i ] );
			}	
				
			return objResult;
		}

		public static function sanitizeXML( $data:* ):XML
		{
			if ( $data is XML ) {
				return $data;
			} else if ( XMLList( $data ).length() == 1 ) {
				return new XML( $data );
			} else {
				var xmlData:XML = new XML( <data/> );
				xmlData.appendChild( $data );
				return xmlData;
			}
		}
		
		public static function filterByAttribute( $data:*, $attribute:String, $value:* ):XMLList
		{
			if ( $data is XML ) {
				return $data.children().(attribute($attribute) == $value.toString() );
			} else {
				return $data.(attribute($attribute) == $value.toString() );
			}
		}
		public static function filterByNode( $data:XML, $name:String, $value:String):XML
		{
			if ( $data is XML ) {
				return $data.children().(child($name) == $value);
			} else {
				return $data.(child($name) == $value);
			}
		}
		
		
	}
}