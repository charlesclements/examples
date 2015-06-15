package com.bedrock.framework.engine.delegate
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.api.IResourceDelegate;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.greensock.loading.CSSLoader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;

	public class DefaultResourceDelegate extends StandardBase implements IResourceDelegate
	{
		/*
		Variable Declarations
		*/
		private var _dataBundleLoader:XMLLoader;
		private var _fontsLoader:SWFLoader;
		private var _libraryLoader:SWFLoader;
		private var _stylesheetLoader:CSSLoader;
		/*
		Constructor
	 	*/
		public function DefaultResourceDelegate()
		{
			this._dataBundleLoader = new XMLLoader( null, { name:BedrockData.DATA_BUNDLE } );
			this._fontsLoader = new SWFLoader( null, { name:BedrockData.FONTS } );
			this._libraryLoader = new SWFLoader( null, { name:BedrockData.LIBRARY } );
			this._stylesheetLoader = new CSSLoader( null, { name:BedrockData.STYLESHEET } );
		}
		
		public function prepareFontsLoader( $localized:Boolean, $locale:String = null ):*
		{
			var path:String = BedrockEngine.config.getPathValue( BedrockData.FONTS_PATH );
			path += BedrockEngine.config.getSettingValue( BedrockData.FONTS_FILENAME );
			
			if ( $localized ) {
				path += BedrockEngine.localeManager.delimiter + $locale + ".swf";
			} else {
				path += ".swf";
			}
			this._fontsLoader.url = path;
			return this._fontsLoader;
		}
		
		public function prepareStylesheetLoader( $localized:Boolean, $locale:String = null ):*
		{
			var path:String = BedrockEngine.config.getPathValue( BedrockData.STYLESHEET_PATH );
			path += BedrockEngine.config.getSettingValue( BedrockData.STYLESHEET_FILENAME );
			
			if ( $localized ) {
				path += BedrockEngine.localeManager.delimiter + $locale + ".css";
			} else {
				path += ".css";
			}
			this._stylesheetLoader.url = path;
			return this._stylesheetLoader;
		}
		
		public function prepareDataBundleLoader( $localized:Boolean, $locale:String = null ):*
		{
			var path:String = BedrockEngine.config.getPathValue( BedrockData.DATA_BUNDLE_PATH );
			path += BedrockEngine.config.getSettingValue( BedrockData.DATA_BUNDLE_FILENAME );
			
			if ( $localized ) {
				path += BedrockEngine.localeManager.delimiter + $locale + ".xml";
			} else {
				path += ".xml";
			}
			this._dataBundleLoader.url = path;
			return this._dataBundleLoader;
		}
		
		public function prepareLibraryLoader( $localized:Boolean, $locale:String = null ):*
		{
			var path:String = BedrockEngine.config.getPathValue( BedrockData.LIBRARY_ASSETS_PATH );
			path += BedrockEngine.config.getSettingValue( BedrockData.LIBRARY_FILENAME );
			
			if ( $localized ) {
				path += BedrockEngine.localeManager.delimiter + $locale + ".swf";
			} else {
				path +=  ".swf";
			}
			this._libraryLoader.url = path;
			return this._libraryLoader;
		}
		/*
		Event Handlers
	 	*/
	 	
	 	/*
		Accessors
	 	*/
	 	public function get dataBundleLoader():*
	 	{
	 		return this._dataBundleLoader;
	 	}
	 	public function get fontsLoader():*
	 	{
	 		return this._fontsLoader;
	 	}
	 	public function get libraryLoader():*
	 	{
	 		return this._libraryLoader;
	 	}
	 	public function get stylesheetLoader():*
	 	{
	 		return this._stylesheetLoader;
	 	}
	}
}