package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.api.ILocaleManager;
	import com.bedrock.framework.engine.bedrock;
	import com.bedrock.framework.plugin.util.XMLUtil2;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	
	public class LocaleManager extends StandardBase implements ILocaleManager
	{
		/*
		Variable Declarations
		*/
		private var _delimiter:String;
		private var _defaultLocale:String;
		private var _currentLocale:String;
		private var _data:Array;
		private var _localizedFiles:String;
		/*
		Constructor
		*/
		public function LocaleManager()
		{
			this._data = new Array;
			this._localizedFiles = "";
		}
		public function initialize( $data:XML, $localizedFiles:String, $defaultLocale:String = null, $currentLocale:String = null, $delimiter:String = "_" ):void
		{
			this.parse( $data );
			this._localizedFiles = $localizedFiles;
			this._defaultLocale = $defaultLocale;
			this._currentLocale = $currentLocale || this._defaultLocale;
			this._delimiter = $delimiter;
		}
		private function parse( $data:XML ):void
		{
			this._data = new Array;
			for each( var xmlItem:XML in $data.children() ) {
				this._data.push( XMLUtil2.getAttributesAsObject( xmlItem ) );
			}
		}
		public function load($locale:String = null ):void
		{
			if ( !this.isLocaleAvailable($locale) ) {
				this.warning( "Locale not available - " + $locale );
			} else {
				this.status( "Loading Locale - " + $locale );
				this._currentLocale = $locale;
				BedrockEngine.bedrock::fileManager.load( this._currentLocale );
			}
		}
		
		public function isLocaleAvailable($locale:String):Boolean
		{
			return ArrayUtil.containsItem( this._data, $locale );
		}
		public function isFileLocalized( $file:String ):Boolean
		{
			return ( this._localizedFiles.indexOf( $file ) != -1 );
		}
		/*
		Property Definitions
		*/
		public function set delimiter( $delimiter:String ):void
		{
			this._delimiter = $delimiter;
		}
		public function get delimiter():String
		{
			return this._delimiter;
		}
		public function get data():Array
		{
			return this._data;
		}
		public function set currentLocale( $value:String ):void
		{
			this._currentLocale = $value;
		}
		public function get currentLocale():String
		{
			return this._currentLocale;
		}
		public function get defaultLocale():String
		{
			return this._defaultLocale;
		}
	}
}