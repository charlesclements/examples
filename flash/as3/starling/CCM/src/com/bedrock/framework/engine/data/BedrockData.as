package com.bedrock.framework.engine.data
{
	import com.bedrock.framework.engine.BedrockEngine;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	dynamic public class BedrockData extends Proxy
	{
		/*
		Player Values
		*/
		public static const MANUFACTURER:String = "manufacturer";
		public static const URL:String = "url";
		public static const OS:String = "os";
		/*
		Constant Environments
		*/
		public static const DEFAULT:String = "default";
		public static const LOCAL:String = "local";
		public static const DEVELOPMENT:String = "development";
		public static const LOCALHOST:String = "localhost";
		public static const STAGING:String = "staging";
		public static const PRODUCTION:String = "production";
		/*
		Constant Settings
		*/
		public static const INITIAL_PRELOADER_TIME:String = "initialPreloaderTime";
		public static const DEFAULT_PRELOADER_TIME:String = "defaultPreloaderTime";
		public static const AUTO_PREPARE_INITIAL_LOAD:String = "autoPrepareInitialLoad";
		public static const AUTO_PREPARE_INITIAL_TRANSITION:String = "autoPrepareInitialTransition";
		
		public static const STAGE_ALIGNMENT:String = "stageAlignment";
		public static const STAGE_SCALE_MODE:String = "stageScaleMode";
		
		public static const DEEPLINKING_ENABLED:String = "deeplinkingEnabled";
		public static const DEEPLINK_CONTENT:String = "deeplinkContent";
		
		public static const STYLESHEET_ENABLED:String = "stylesheetEnabled";
		public static const DATA_BUNDLE_ENABLED:String = "dataBundleEnabled";
		public static const TRACKING_ENABLED:String = "trackingEnabled";
		public static const LOCALES_ENABLED:String = "localesEnabled";
		public static const FONTS_ENABLED:String = "fontsEnabled";
		public static const LIBRARY_ENABLED:String = "libraryEnabled";
		public static const SHOW_BLOCKER_DURING_TRANSITIONS:String = "showBlockerDuringTransitions";
		public static const CONFIG_URL:String = "configURL";
		
		public static const BLOCKER:String = "blocker";
		public static const BLOCKER_ALPHA:String = "blockerAlpha";
		public static const BLOCKER_COLOR:String = "blockerColor";
		/*
		Locale Settings
		*/
		public static const LOCALE_LIST:String = "localeList";
		public static const LOCALIZED_FILES:String = "localizedFiles";
		public static const LOCALE_DELIMITER:String = "localeDelimiter";
		public static const DEFAULT_LOCALE:String = "defaultLocale";
		public static const CURRENT_LOCALE:String = "currentLocale";
		public static const SYSTEM_LANGUAGE:String = "systemLanguage";
		public static const ENVIRONMENT:String = "environment";
		public static const FORCE_ENVIRONMENT:String = "forceEnvironment";
		
		public static const SHELL:String = "shell";
		public static const FONTS:String = "fonts";
		public static const STYLESHEET:String = "stylesheet";
		public static const DATA_BUNDLE:String = "dataBundle";
		public static const LIBRARY:String = "library";
		
		public static const DEFAULT_TRANSITION_STYLE:String = "defaultTransitionStyle";
		/*
		Logger Settings
		*/
		public static const ERRORS_ENABLED:String = "errorsEnabled";
		public static const LOG_DETAIL_DEPTH:String = "logDetailDepth";
		public static const TRACE_LOG_LEVEL:String = "traceLogLevel";
		public static const EVENT_LOG_LEVEL:String = "eventLogLevel";
		public static const REMOTE_LOG_LEVEL:String = "remoteLogLevel";
		public static const MONSTER_LOG_LEVEL:String = "monsterLogLevel";
		public static const REMOTE_LOG_URL:String = "remoteLogURL";
		
		public static const INITIAL_PRELOADER:String= "initialPreloader";
		public static const DEFAULT_PRELOADER:String= "defaultPreloader";
		/*
		Constant File Names
		*/
		public static const CONFIG_FILENAME:String = "bedrock_config";
		
		public static const STYLESHEET_FILENAME:String = "stylesheetFilename";
		public static const FONTS_FILENAME:String = "fontsFilename";
		public static const DATA_BUNDLE_FILENAME:String = "dataBundleFilename";
		public static const LIBRARY_FILENAME:String = "libraryFilename";
		/*
		Constant Paths
		*/
		public static const DATA_BUNDLE_PATH:String = "dataBundlePath";
		public static const FONTS_PATH:String = "fontsPath";
		public static const LIBRARY_ASSETS_PATH:String = "libraryPath";
		public static const AUDIO_PATH:String = "audioPath";
		public static const STYLESHEET_PATH:String = "stylesheetPath";
		public static const XML_PATH:String = "xmlPath";
		public static const IMAGE_PATH:String = "imagePath";
		public static const VIDEO_PATH:String = "videoPath";
		public static const SWF_PATH:String = "swfPath";
		/*
		Constant Containers
		*/
		public static const NONE:String = "none";
		public static const ROOT:String = "root";
		public static const SITE:String = "site";
		public static const OVERLAY:String = "overlay";
		public static const PRELOADER:String = "preloader";
		/*
		Context Menus
		*/
		public static const SHOW_PAGES_IN_CONTEXT_MENU:String = "showPagesInContextMenu";
		public static const SHOW_ABOUT_IN_CONTEXT_MENU:String = "showAboutInContextMenu";
		
		public static const INDEXED:String = "indexed";
		public static const PRIORITY:String = "priority";
		public static const INITIAL_TRANSITION:String = "initialTransition";
		public static const INITIAL_LOAD:String = "initialLoad";
		public static const AUTO_DISPOSE:String = "autoDispose";
		public static const AUTO_DISPOSE_ASSETS:String = "autoDisposeAssets";
		
		/*
		Variable Declarations
		*/
		private static var __instance:BedrockData;
		/*
		Constructor
		*/
		public function BedrockData( $singletonEnforcer:SingletonEnforcer )
		{
		}
		public static function getInstance():BedrockData
		{
			if ( BedrockData.__instance == null ) {
				BedrockData.__instance = new BedrockData( new SingletonEnforcer );
			}
			return BedrockData.__instance;
		}
		
		
		flash_proxy override function callProperty( $name:*, ...$arguments:Array ):*
		{
			return null;
		}


		flash_proxy override function getProperty( $name:* ):*
		{
			var name:String = $name.toString();
			if ( BedrockEngine.config.hasSettingValue( name ) ) return BedrockEngine.config.getSettingValue( name );
			if ( BedrockEngine.config.hasPathValue( name ) ) return BedrockEngine.config.getPathValue( name );
			if ( BedrockEngine.config.hasVariableValue( name ) ) return BedrockEngine.config.hasVariableValue( name );
			return null;
		}


		flash_proxy override function setProperty( $name:*, $value:* ):void
		{
			var name:String = $name.toString();
			if ( BedrockEngine.config.hasSettingValue( name ) ) BedrockEngine.config.saveSettingValue( name, $value );
			if ( BedrockEngine.config.hasPathValue( name ) ) BedrockEngine.config.savePathValue( name, $value );
			if ( BedrockEngine.config.hasVariableValue( name ) || ( !BedrockEngine.config.hasSettingValue( name ) && !BedrockEngine.config.hasPathValue( name ) ) ) {
				BedrockEngine.config.saveVariableValue( name, $value );
			}
		}


		flash_proxy override function deleteProperty( $name:* ):Boolean
		{
			return false;
		}
	}
	
}
/*
This private class is only accessible by the public class.
The public class will use this as a 'key' to control instantiation.   
*/
class SingletonEnforcer {}