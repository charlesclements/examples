package com.bedrock.framework.core.logging
{
	import flash.utils.describeType;
	
	public class TraceLogger implements ILogger
	{
		/*
		Variable Delcarations
		*/
		public static const DYNAMIC:String = "dynamic";
		public static const STATIC:String = "static";
		public static const PRIMITIVE:String = "primitive";
		public static const DATA:String = "data";
		public static const NULL:String = "null";
		
		private var _detailDepth:uint;
		
		public var data:LogData;
		/*
		Constructor
		*/
		public function TraceLogger( $detailDepth:uint = 10 )
		{
			this._detailDepth = $detailDepth;
			
		}
		/*
		Creation Functions
		*/
		public function log( $trace:*, $data:LogData ):String
		{
			this.data = $data;
			var strTrace:String = this._format( $trace, null, $data.category );
			trace( strTrace );
			return strTrace;
		}
		
		
		
		private function _format( $trace:*, $target:*, $category:int ):String
		{
			if ( $trace != null ) {
				switch( this._getType( describeType( $trace ).@name ) ) {
					case TraceLogger.DYNAMIC :
					case TraceLogger.STATIC :
						if ( this._detailDepth > 0 ) {
							return this._getComplexFormat( $trace, this.data.detailMedium, this.data.categoryLabel, this.data.timeStamp );
						} else {
							return this.data.detailMedium + this.data.categoryLabel + this.data.timeStamp + ": " + $trace.toString();
						}
						break;
					case TraceLogger.PRIMITIVE :
						return this.data.detailMedium + this.data.categoryLabel + this.data.timeStamp + ": " + $trace.toString();
						break;
					case TraceLogger.DATA :
						return this.data.detailMedium + this.data.categoryLabel + this.data.timeStamp + ": " + $trace.toXMLString();
						break;
				}
			} else {
				return this.data.detailMedium + this.data.timeStamp + this.data.categoryLabel + " : null";
			}
			
			return new String;
		}
		
		
		private function _getComplexFormat( $object:*, $target:*, $category:String, $time:String ):String
		{
			var strReturn:String = new String;
			strReturn += $target + $category + $time + "\n";
			strReturn += ("------------------------------------------------" + "\n");
			switch( this._getType( describeType( $object ).@name ) ) {
				case TraceLogger.DYNAMIC :
					strReturn += this._getDynamicFormat( $object, this._detailDepth );
					break;
				case TraceLogger.STATIC :
					strReturn += this._getStaticFormat( $object, this._detailDepth );
					break;
			}
			
			return strReturn;
		}
		
		
		private function _getDynamicFormat( $object:*, $detailLevel:uint = 3, $depth:uint = 0 ):String
		{
			var numDepth:uint = $depth += 1;
			var objTrace:Object = $object;
			
			var strReturn:String = new String;
			if ( $depth <= $detailLevel ) {
				
				var xmlDescription:*;
				for (var t:String in objTrace ) {
					
					xmlDescription = describeType( objTrace[ t ] );
					
					switch( this._getType( xmlDescription.@name ) ) {
						case TraceLogger.DYNAMIC :
							strReturn += this._getVariableFormat( xmlDescription.@name, t, objTrace[ t ], numDepth, "+") + this._getDynamicFormat( objTrace[ t ], $detailLevel, numDepth+1 );
							break;
						case TraceLogger.STATIC :
							strReturn += this._getVariableFormat( xmlDescription.@name, t, objTrace[ t ], numDepth, "+") + this._getStaticFormat( objTrace[ t ], $detailLevel, numDepth+1 );
							break;
						case TraceLogger.PRIMITIVE :
						case TraceLogger.DATA :
							strReturn += this._getVariableFormat( xmlDescription.@name, t, objTrace[ t ], numDepth );
							break;
					}
					
				}
			}
			return strReturn;
		}
		
		private function _getStaticFormat( $object:*, $detailLevel:uint = 3, $depth:uint = 0 ):String
		{
			var numDepth:uint = $depth += 1;
			var strReturn:String = new String;
			
			if ( $depth <= $detailLevel ) {
				
				var xmlDescription:*= describeType( $object );
				for each( var xmlVariable:* in xmlDescription..variable ) {
					
					switch( this._getType( xmlVariable.@type ) ) {
						case TraceLogger.DYNAMIC :
							strReturn += this._getVariableFormat( xmlVariable.@type, xmlVariable.@name, $object[ xmlVariable.@name.toString() ], numDepth, "+") + this._getDynamicFormat( $object[ xmlVariable.@name.toString() ], $detailLevel, numDepth+1 );
							break;
						case TraceLogger.STATIC :
							strReturn += this._getVariableFormat( xmlVariable.@type, xmlVariable.@name, $object[ xmlVariable.@name.toString() ], numDepth, "+") + this._getStaticFormat( $object[ xmlVariable.@name.toString() ], $detailLevel, numDepth+1 );
							break;
						case TraceLogger.PRIMITIVE :
						case TraceLogger.DATA :
							strReturn += this._getVariableFormat( xmlVariable.@type, xmlVariable.@name, $object[ xmlVariable.@name.toString() ], numDepth );
							break;
					}
					
				}
			}
			
			
			return strReturn;
		}
		
		private function _getVariableFormat( $className:String, $variableName:String, $value:*, $depth:uint = 0, $prefix:String = "-"):String
		{
			var strValue:String;
			if ( $value is XML || $value is XMLList ) {
				strValue = $value.toXMLString();
			} else if ( $value == null ) {
				strValue = "null";
			} else {
				strValue = $value.toString();
			}
			return ( this._getTabs( $depth ) + $prefix + this._getClassNameFormat( $className ) + $variableName + " : " + strValue + "\n");
		}
		private function _getTabs( $count:uint ):String
		{
			var strTabs:String = new String();
			for (var i:int = 0 ; i < $count; i++) {
				strTabs += "   ";
			}
			return strTabs
		}
		
		private function _getClassNameFormat( $name:String ):String
		{
			if ( $name.lastIndexOf( "::" ) != -1 ) {
				return "[" + $name.substring( ( $name.lastIndexOf( "::" ) +2 ), $name.length ) + "] ";
			} else {
				return "[" + $name + "] ";
			}
		}
		
		private function getCategoryFormat($category:int):String
		{
			return "[" + "BLAH" + "] ";
		}
		/*
		Check whether argument is an object
	 	*/
		private function _getType( $name:String ):String
		{
			if ( $name == "Array" || $name == "Object" ) {
				return TraceLogger.DYNAMIC;
			} else if ( $name == "XML" || $name == "XMLList" ) {
				return TraceLogger.DATA;
			} else if ( $name == "String" || $name == "Boolean" || $name == "Number" || $name == "int" || $name == "uint" ) {
				return TraceLogger.PRIMITIVE;
			} else if ( $name == "" ) {
				return TraceLogger.NULL;
			} else {
				return TraceLogger.STATIC;
			}
		}
		
		
	}
}