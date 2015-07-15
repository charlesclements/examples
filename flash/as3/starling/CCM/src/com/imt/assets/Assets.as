package com.imt.assets
{
	
	
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.storage.SuperArray;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.event.StarlingSiteEvent;
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class Assets extends EventDispatcher
	{
	
		
		private static var _loader:LoaderMax;
		//private static var ASSETS:Dictionary = new Dictionary;
		private static var ASSETS:HashMap = new HashMap;
		private static var LOADERS:Dictionary = new Dictionary;
		private static var _showTraces:Boolean = false;
		public static var GAME_PLAY:IDisplay;
		public static var LEVELS:SuperArray;
		public static var ASSETS_PATH:String = "";
		/*public static var WIDTH:uint = 0;
		public static var HEIGHT:uint = 0;*/
		private static var _sounds:Dictionary = new Dictionary();
		
		/*
		[ Embed( source="media/font/bitmap/fontScoreLabel.fnt", mimeType="application/octet-stream" ) ]
		public static const fontScoreXML:Class;
		*/
		
		
		public function Assets(target:IEventDispatcher=null)
		{
			
			super(target);
			
		}
		
		
		public static function createLoader($loaderAlias:String):void
		{
			
			if( _showTraces ) trace( "Assets : createLoader : " + $loaderAlias);
			Assets.LOADERS[ $loaderAlias ] = new LoaderMax( { name:$loaderAlias } );
			
		}
		
		
		public static function disposeLoader($loaderAlias:String):void
		{
			
			trace("Assets : disposeLoader : " + $loaderAlias);
			( Assets.LOADERS[ $loaderAlias ] as LoaderMax ).dispose( true );
			Assets.LOADERS[ $loaderAlias ] = null;
			
		}
		
		
		public static function getLoader($loaderAlias:String):LoaderMax
		{
			
			if( Assets.LOADERS[ $loaderAlias ] == undefined ) throw( "The Loader " + $loaderAlias + " doesn't exist." );
			return Assets.LOADERS[ $loaderAlias ] as LoaderMax;
			
		}
		
		
		public static function appendTexture($loaderAlias:String, $loaderToLoad:LoaderCore, $key:String):void
		{
			
			if( _showTraces ) trace("Assets : appendTexture : " + $loaderAlias + " : " + $key);
			Assets.getLoader( $loaderAlias ).append( $loaderToLoad ); 
			Assets.ASSETS.saveValue( $key, $loaderToLoad );
			
		}
		
		
		public static function appendSfx($loaderAlias:String, $loaderToLoad:LoaderCore, $key:String):void
		{
			
			if( _showTraces ) trace("Assets : appendTexture : " + $loaderAlias + " : " + $key);
			Assets.getLoader( $loaderAlias ).append( $loaderToLoad ); 
			Assets.ASSETS.saveValue( $key, $loaderToLoad );
			
		}
		
		
		public static function appendXML($loaderAlias:String, $loaderToLoad:LoaderCore, $key:String):void
		{
			
			if( _showTraces ) trace("Assets : appendXML : " + $loaderAlias + " : " + $key);
			Assets.getLoader( $loaderAlias ).append( $loaderToLoad );
			Assets.ASSETS.saveValue( $key, $loaderToLoad );
			
		}

		
		public function removeLoaders():void
		{
		}
		
		
		public static function load($loaderAlias:String):void
		{
			
			if( Assets.LOADERS[ $loaderAlias ] == undefined ) throw( "The Loader " + $loaderAlias + " doesn't exist. Create a new Loader using the Assets.createLoader( 'LoaderName' ); method." );
			
			
			var l:LoaderMax = Assets.LOADERS[ $loaderAlias ] as LoaderMax;
			l.addEventListener( LoaderEvent.COMPLETE, _onLoaderComplete );
			l.load();
			
		}
		
		
		private static function _onLoaderComplete(event:LoaderEvent):void
		{
			
			if( _showTraces ) trace(Assets + " : _onLoaderComplete " + event.type);
			StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.ASSETS_LOADED, { name:event.currentTarget.vars.name } ) );
			
		}		
		
		
		public static function getTexture($key:String):Texture
		{
			
			trace(Assets + " : getTexture " + $key);
			trace(Assets.ASSETS.getValue( $key ));
			
			
			
			
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The Texture " + $key + " was never created!" );
			//return Texture.fromBitmap( ( ASSETS[ $key ] as ImageLoader ).rawContent )
			return Texture.fromBitmap( ( Assets.ASSETS.getValue( $key ) as ImageLoader ).rawContent )
			
		}
		
		
		public static function getXML($key:String):XML
		{
			
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The XML " + $key + " was never created!" );
			return ( ( Assets.ASSETS.getValue( $key ) as XMLLoader ).content ) as XML;
			
		}

		
		public static function getBitmap($key:String):Bitmap
		{
			
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The Bitmap " + $key + " was never created!" );
			return ( ( Assets.ASSETS.getValue( $key ) as ImageLoader ).rawContent ) as Bitmap;
			
		}
		
	
		//Doing it through Sounds.fla instead
		// Update: needing to do this through here, the Assets class.
		public static function getSfx($key:String):MP3Loader
		{
			
			trace("Assets : getSfx " + $key);
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The Sound " + $key + " was never created!" );
			return ( ( Assets.ASSETS.getValue( $key ) ) as MP3Loader);
		
		}
		
		
		public static function createTextureAtlas($key:String, $texture:Texture, $xml:XML):TextureAtlas
		{
			
			if( _showTraces ) trace( "Assets : createTextureAtlas ");
			Assets.ASSETS.saveValue( $key, new TextureAtlas( $texture, $xml ) );
			return ( ( Assets.ASSETS.getValue( $key ) ) as TextureAtlas);
			
		}
		
		
		public static function getTextureAtlas($key:String):TextureAtlas
		{
			
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The Texture " + $key + " was never created!" );
			return Assets.ASSETS.getValue( $key );
			
		}
		
		
		public static function destroyAssetsFrom($key:String):void
		{
			
			//if( _showTraces ) trace( "Assets : destroyAssetsFrom ");
			trace( "Assets : destroyAssetsFrom ");
			//if( Assets.ASSETS[ $key ] == undefined ) throw( "The Texture " + $key + " was never created!" );
			if( Assets.ASSETS.getValue( $key ) == undefined ) throw( "The Texture " + $key + " was never created!" );

			
			
			
			
			
			
			
			
			
			
			// Loop thru Dictionary and dispose of assets.
			
			
			
			
			
			
			
			
			
			
		}
		
		
		
		public static function showTraces($state:Boolean):void
		{
			
			trace( "Assets : showTraces : " + $state);
			_showTraces = $state;
			
		}
		
		
	}
	
}