package com.bedrock.framework.engine.controller
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.api.IResourceController;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.engine.event.BedrockEvent;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	
	import flash.system.LoaderContext;

	public class ResourceController extends StandardBase implements IResourceController
	{
		/*
		Variable Declarations
		*/
		
		/*
		Constructor
	 	*/
		public function ResourceController()
		{
			
		}
		
		public function queue( $autoLoad:Boolean = true ):void
		{
			var currentLocale:String = BedrockEngine.localeManager.currentLocale;
			
			this._queueDataBundle( BedrockEngine.config.getSettingValue( BedrockData.DATA_BUNDLE_ENABLED ), BedrockEngine.localeManager.isFileLocalized( BedrockData.DATA_BUNDLE ), currentLocale );
			this._queueStylesheet( BedrockEngine.config.getSettingValue( BedrockData.STYLESHEET_ENABLED ), BedrockEngine.localeManager.isFileLocalized( BedrockData.STYLESHEET ), currentLocale );
			this._queueFonts( BedrockEngine.config.getSettingValue( BedrockData.FONTS_ENABLED ), BedrockEngine.localeManager.isFileLocalized( BedrockData.FONTS ), currentLocale );
			this._queueLibrary( BedrockEngine.config.getSettingValue( BedrockData.LIBRARY_ENABLED ), BedrockEngine.localeManager.isFileLocalized( BedrockData.LIBRARY ), currentLocale );
			
			if ( $autoLoad ) BedrockEngine.loadController.load();
		}
		
		private function _queueFonts( $enabled:Boolean, $localized:Boolean, $locale:String = null ):void
		{
			if ( $enabled ) {
				var loader:LoaderItem = BedrockEngine.resourceDelegate.prepareFontsLoader( $localized, $locale );
				loader.vars.context = this._getLoaderContext();
				if ( loader != null ) {
					loader.addEventListener( LoaderEvent.COMPLETE, this._onFontsComplete, false, 10000 );
					BedrockEngine.loadController.appendLoader( loader );
				} else {
					this.warning( "Fonts loader does not extend LoaderItem!" );
				}
			}
		}
		private function _queueStylesheet( $enabled:Boolean, $localized:Boolean, $locale:String = null ):void
		{
			if ( $enabled ) {
				var loader:LoaderItem = BedrockEngine.resourceDelegate.prepareStylesheetLoader( $localized, $locale );
				if ( loader != null ) {
					loader.addEventListener( LoaderEvent.COMPLETE, this._onStylesheetComplete, false, 10000 );
					BedrockEngine.loadController.appendLoader( loader );
				} else {
					this.warning( "Stylesheet loader does not extend LoaderItem!" );
				}
			}
		}
		private function _queueDataBundle( $enabled:Boolean, $localized:Boolean, $locale:String = null ):void
		{
			if ( $enabled ) {
				var loader:LoaderItem = BedrockEngine.resourceDelegate.prepareDataBundleLoader( $localized, $locale );
				if ( loader != null ) {
					loader.addEventListener( LoaderEvent.COMPLETE, this._onDataBundleComplete, false, 10000 );
					BedrockEngine.loadController.appendLoader( loader );
				} else {
					this.warning( "DataBundle loader does not extend LoaderItem!" );
				}
			}
		}
		private function _queueLibrary( $enabled:Boolean, $localized:Boolean, $locale:String = null ):void
		{
			if ( $enabled ) {
				var loader:LoaderItem = BedrockEngine.resourceDelegate.prepareLibraryLoader( $localized, $locale );
				loader.vars.context = this._getLoaderContext();
				if ( loader != null ) {
					loader.addEventListener( LoaderEvent.COMPLETE, this._onLibraryComplete, false, 10000 );
					BedrockEngine.loadController.appendLoader( loader );
				} else {
					this.warning( "Library loader does not extend LoaderItem!" );
				}
			}
		}
		
		private function _getLoaderContext():LoaderContext
		{
			return new LoaderContext( BedrockEngine.loadController.checkPolicyFile, BedrockEngine.loadController.applicationDomain );
		}
		/*
		Event Handlers
	 	*/
		private function _onDataBundleComplete( $event:LoaderEvent ):void
		{
			BedrockEngine.dataBundleManager.parse( BedrockEngine.loadController.getLoaderContent( BedrockData.DATA_BUNDLE ) );
		}
		private function _onStylesheetComplete( $event:LoaderEvent ):void
		{
			BedrockEngine.stylesheetManager.parse( BedrockEngine.loadController.getLoaderContent( BedrockData.STYLESHEET ) );
		}
		private function _onLibraryComplete( $event:LoaderEvent ):void
		{
			BedrockEngine.loadController.getLoaderContent( BedrockData.LIBRARY ).rawContent.initialize();
		}
		private function _onFontsComplete( $event:LoaderEvent ):void
		{
			BedrockEngine.loadController.getLoaderContent( BedrockData.FONTS ).rawContent.initialize();
		}
	}
}