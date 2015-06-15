package com.bedrock.framework.engine.api
{
	public interface IResourceDelegate
	{
		function prepareFontsLoader( $localized:Boolean, $locale:String = null ):*;
		function prepareStylesheetLoader( $localized:Boolean, $locale:String = null ):*;
		function prepareDataBundleLoader( $localized:Boolean, $locale:String = null ):*;
		function prepareLibraryLoader( $localized:Boolean, $locale:String = null ):*;
		
		function get dataBundleLoader():*;
		function get fontsLoader():*;
		function get libraryLoader():*;
		function get stylesheetLoader():*;
	}
}