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
package com.bedrock.framework.engine.model
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IConfig;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.plugin.util.VariableUtil;
	
	import flash.system.Capabilities;
	
	public class Config extends StandardBase implements IConfig
	{
		/*
		Variable Declarations
		*/	
		private var _xmlConfig:XML;
		private var _xmlParamValues:XML;
		
		private var _settingValues:XML;
		private var _pathValues:XML;
		private var _variableValues:XML;
		
		private var _contentValues:XML;
		private var _assetValues:XML;
		private var _containerValues:XML;
		private var _localeValues:XML;
		/*
		Constructor
		*/
		public function Config()
		{
			this._xmlParamValues = new XML( <data/> );
		}
		/*
		Initialize
		*/
		public function initialize( $data:String, $url:String ):void
		{
			this._xmlConfig = new XML($data);
			
			this.parseXML($data);
			
			this.saveSettingValue( BedrockData.URL, $url );
			this.saveSettingValue( BedrockData.MANUFACTURER, Capabilities.manufacturer );
			this.saveSettingValue( BedrockData.SYSTEM_LANGUAGE, Capabilities.language );
			this.saveSettingValue( BedrockData.OS, Capabilities.os );
			this.saveSettingValue( BedrockData.ENVIRONMENT, this.getCurrentEnvironment( $url ) );
			
			this.parseEnvironmentValues( $url );
		}

		
		private function parseXML($data:String):void
		{
			this._settingValues = this._getAsXML( this._xmlConfig.settings..setting );
			this._pathValues = this._getAsXML( this._xmlConfig.settings..path );
			this._variableValues = this._getAsXML( this._xmlConfig.settings..variable );
			
			this._contentValues = new XML( this._xmlConfig.contents );
			this._assetValues = new XML( this._xmlConfig.assets );
			this._containerValues = new XML( this._xmlConfig.containers );
			this._localeValues = new XML( this._xmlConfig.locales );
			
			this.saveSettingValue( BedrockData.CURRENT_LOCALE, this.getSettingValue( BedrockData.DEFAULT_LOCALE ) );
		}
		/*
		Environment Functions
		*/
		private function getCurrentEnvironment( $url:String ):String
		{
			var strURL:String = $url;
			var xmlEnvironments:XMLList = this._xmlConfig.environments..environment;
			var xmlPatterns:XMLList;
			for each ( var xmlEnvironment:XML in xmlEnvironments ) {
				xmlPatterns = xmlEnvironment..pattern;
				for each( var xmlPattern:XML in xmlPatterns ) {
					if ( strURL.indexOf( xmlPattern.@value ) != -1 ) {
						return xmlEnvironment.@id;
					}
				}
			}
			return BedrockData.PRODUCTION;
		}
		
		private function parseEnvironmentValues( $url:String ):void
		{
			var xmlDefaultEnvironment:XML = this._xmlConfig.environments..environment.( @id == BedrockData.DEFAULT )[ 0 ];
			var strEnvironment:String =  this.getSettingValue( BedrockData.ENVIRONMENT );
			var xmlCurrentEnvironment:XML = this._xmlConfig.environments..environment.( @id == strEnvironment )[ 0 ];
			
			this._pathValues = this.mergeXMLList( this._pathValues, xmlDefaultEnvironment..path );
			this._pathValues = this.mergeXMLList( this._pathValues, xmlCurrentEnvironment..path );
			
			this._settingValues = this.mergeXMLList( this._settingValues, xmlDefaultEnvironment..setting );
			this._settingValues = this.mergeXMLList( this._settingValues, xmlCurrentEnvironment..setting );
			
			this._variableValues = this.mergeXMLList( this._variableValues, xmlDefaultEnvironment..variable );
			this._variableValues = this.mergeXMLList( this._variableValues, xmlCurrentEnvironment..variable );
		}
		/*
		Param Functions
		*/
		public function parseParams( $data:* ):void
		{
			if ( $data is String ) {
				this.parseParamString( $data );
			} else {
				this.parseParamObject( $data );
			}
		}
		private function parseParamObject( $data:Object ):void
		{
			for (var d:String in $data){
				this.saveParamValue( d, VariableUtil.sanitize( $data[ d ] ) ); 
			}
		}
		private function parseParamString( $params:String, $variableSeparator:String ="&", $valueSeparator:String =  "=" ):void
		{
			if ($params != null) {
				for each ( var pair:String in $params.split( $variableSeparator ) ) {
					this.saveParamValue( pair.split( $valueSeparator )[ 0 ], pair.split( $valueSeparator )[ 1 ] ); 
				}
			} else {
				this.warning("No params to parse!");
			}
		}
		public function saveParamValue( $id:String, $value:*):void
		{
			var xmlList:XMLList = new XMLList( <param id={ $id } value={ $value } /> );
			this._settingValues = this.mergeXMLList( this._settingValues, xmlList, true );
			this._variableValues = this.mergeXMLList( this._variableValues, xmlList, true );
		}
		/*
		Save Functions
		*/
		public function saveSettingValue($id:String, $value:*, $overrideOnly:Boolean = false ):void
		{
			var xmlResult:XML = this._settingValues.children().( @id == $id )[ 0 ];
			if ( xmlResult != null ) {
				xmlResult.@value = $value;
			} else if ( !$overrideOnly ) {
				this._settingValues.appendChild( <setting id={$id} value={$value} /> );
			}
		}
		public function savePathValue($id:String, $value:*, $overrideOnly:Boolean = false ):void
		{
			var xmlResult:XML = this._pathValues.children().( @id == $id )[ 0 ];
			if ( xmlResult != null ) {
				xmlResult.@value = $value;
			} else if ( !$overrideOnly ) {
				this._pathValues.appendChild( <path id={$id} value={$value} /> );
			}
		}
		public function saveVariableValue($id:String, $value:*, $overrideOnly:Boolean = false ):void
		{
			var xmlResult:XML = this._variableValues.children().( @id == $id )[ 0 ];
			if ( xmlResult != null ) {
				xmlResult.@value = $value;
			} else if ( !$overrideOnly ) {
				this._variableValues.appendChild( <variable id={$id} value={$value} /> );
			}
		}
		/*
		Get Functions
		*/
		public function getSettingValue($id:String):*
		{
			try {
				return VariableUtil.sanitize( this._settingValues.children().( @id == $id )[ 0 ].@value );
			} catch ( $error:Error ) {
				this.warning( "Setting \"" + $id + "\" not found!" );
				return null;
			}
		}
		public function getPathValue($id:String):*
		{
			try {
				return VariableUtil.sanitize( this._pathValues.children().( @id == $id )[ 0 ].@value )
			} catch ( $error:Error ) {
				this.warning( "Path \"" + $id + "\" not found!" );
				return null;
			}
		}
		public function getVariableValue($id:String):*
		{
			try {
				return VariableUtil.sanitize( this._variableValues.children().( @id == $id )[ 0 ].@value );
			} catch ( $error:Error ) {
				this.warning( "Variable \"" + $id + "\" not found!" );
				return null;
			}
		}
		/*
		Has Functions
		*/
		public function hasSettingValue($id:String):Boolean
		{
			var xmlResult:XML = this._settingValues.children().( @id == $id )[ 0 ];
			return ( xmlResult != null );
		}
		public function hasPathValue($id:String):Boolean
		{
			var xmlResult:XML = this._pathValues.children().( @id == $id )[ 0 ];
			return ( xmlResult != null );
		}
		public function hasVariableValue($id:String):Boolean
		{
			var xmlResult:XML = this._variableValues.children().( @id == $id )[ 0 ];
			return ( xmlResult != null );
		}
		
		/*
		Internal Functions
		*/
		private function _getAsXML( $list:XMLList ):XML
		{
			var xmlData:XML = new XML( <data/> );
			xmlData.appendChild( $list );
			return xmlData;
		}
		private function mergeXMLList( $target:XML, $source:XMLList, $overrideOnly:Boolean = false ):XML
		{
			var xmlTarget:XML = $target;
			
			var xmlSource:XML = new XML( <list/> );
			xmlSource.appendChild( $source );
			
			var xmlResult:XML;
			for each( var xmlItem:XML in xmlSource.children() ) {
				xmlResult = xmlTarget.children().( @id == xmlItem.@id )[ 0 ];
				if ( xmlResult != null ) {
					xmlResult.@value = xmlItem.@value;
				} else if ( !$overrideOnly ) {
					xmlTarget.appendChild( xmlItem );
				}
			}
			return xmlTarget;
		}
		/*
		Property Definitions
		*/
		public function get containers():XML
		{
			return this._containerValues;
		}
		public function get locales():XML
		{
			return this._localeValues;
		}
		public function get contents():XML
		{
			return this._contentValues;
		}
		public function get assets():XML
		{
			return this._assetValues;
		}
	}
}

