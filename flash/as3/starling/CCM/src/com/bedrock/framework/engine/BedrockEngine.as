package com.bedrock.framework.engine
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.core.controller.IFrontController;
	import com.bedrock.framework.engine.api.*;
	import com.bedrock.framework.engine.controller.TransitionController;
	import com.bedrock.framework.engine.data.BedrockData;

	public class BedrockEngine extends StandardBase
	{
		/*
		Variable Definitions
	 	*/
		public static var available:Boolean = false;
		
		public static var data:BedrockData;
		bedrock static var transitionController:TransitionController;
		//bedrock static var sequenceController:SequenceController;
		bedrock static var resourceController:IResourceController;
		public static var frontController:IFrontController;
		public static var loadController:ILoadController;
		
		public static var assetManager:IAssetManager;
		public static var containerManager:IContainerManager;
		public static var contentManager:IContentManager;
		public static var contextMenuManager:IContextMenuManager;
		public static var dataBundleManager:IDataBundleManager;
		public static var deeplinkingManager:IDeeplinkingManager;
		public static var fontManager:IFontManager;
		public static var libraryManager:ILibraryManager;
		public static var localeManager:ILocaleManager;
		bedrock static var preloadManager:IPreloadManager;		
		public static var stylesheetManager:IStylesheetManager;
		public static var trackingManager:ITrackingManager;
		
		public static var resourceDelegate:IResourceDelegate;
		
		public static var config:IConfig;
		public static var history:IHistory;
	}
}
