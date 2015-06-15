package com.bedrock.framework.engine.controller
{
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.api.ILoadController;
	import com.bedrock.framework.engine.builder.BedrockBuilder;
	import com.bedrock.framework.engine.data.BedrockAssetData;
	import com.bedrock.framework.engine.data.BedrockAssetGroupData;
	import com.bedrock.framework.engine.data.BedrockContentData;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.engine.event.BedrockEvent;
	import com.bedrock.framework.engine.view.BedrockContentDisplay;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;

	public class LoadController extends DispatcherBase implements ILoadController
	{
		/*
		Variable Declarations
		*/
		private var _loader:LoaderMax;
		private var _checkPolicyFile:Boolean;
		private var _applicationDomain:ApplicationDomain;
		private var _securityDomain:SecurityDomain;
		private var _builder:BedrockBuilder;
		private var _empty:Boolean;
		/*
		Constructor
		*/	
		public function LoadController():void
		{
		}
		
		public function initialize( $builder:*, $applicationDomain:ApplicationDomain ):void
		{
			this._builder = $builder;
			this._applicationDomain = $applicationDomain;
			
			this._loader = new LoaderMax;
			this._loader.addEventListener( LoaderEvent.COMPLETE, this._onLoadComplete );
			this._loader.addEventListener( LoaderEvent.PROGRESS, this._onLoadProgress );
			this._loader.addEventListener( LoaderEvent.ERROR, this._onLoadError );
			this._loader.skipFailed = true;
			
			this._empty = true;
		}
		public function load():void
		{
			this._loader.load();
		}
		public function pause():void
		{
			this._loader.pause();
		}
		public function resume():void
		{
			this._loader.resume();
		}
		
		public function appendLoader( $loader:* ):void
		{
			if ( $loader is LoaderItem ) {
				this._empty = false;
				this._loader.append( $loader );
			}
		}
		
		public function appendContent( $content:BedrockContentData ):void
		{
			if ( !this.hasLoader( $content.id ) || ( this.hasLoader( $content.id ) && this.getLoader( $content.id ).status >= LoaderStatus.FAILED ) ) {
				
				if ( BedrockEngine.assetManager.hasGroup( $content.assetGroup ) ) {
					this.appendAssetGroup( BedrockEngine.assetManager.getGroup( $content.assetGroup ) );
				}
				
				LoaderMax.contentDisplayClass = BedrockContentDisplay;
				this.appendLoader( this._getContentLoader( $content ) );
				LoaderMax.contentDisplayClass = ContentDisplay;
			} else {
				switch ( this.getLoader( $content.id ).status ) {
					case LoaderStatus.LOADING :
						this.status( "Content \"" + $content.id + "\" loading." );
						break;
					case LoaderStatus.COMPLETED :
						this.status( "Content \"" + $content.id + "\" already loaded." );
						break;
				}
			}
		}
		
		
		private function _getContentLoader( $content:BedrockContentData ):LoaderItem
		{
			var loaderVars:Object = new Object;
			loaderVars.name =  $content.id;
			loaderVars.context = this._getLoaderContext();
			
			if ( BedrockEngine.containerManager.hasContainer( $content.container ) ) {
				loaderVars.container = BedrockEngine.containerManager.getContainer( $content.container );
			} else if ( $content.container != BedrockData.NONE ) {
				this.warning( "Container \"" + $content.container + "\" not found for content \"" + $content.id + "\"!" );
			}
			return new SWFLoader( $content.url, loaderVars );
		}
		
		
 	 	
		public function disposeContent( $id:String ):void
		{
			if ( this.hasLoader( $id ) ) {
				var content:BedrockContentData = BedrockEngine.contentManager.getContent( $id );
				
				this.getLoader( content.id ).dispose();
				if ( content.autoDisposeAssets ) {
					if ( BedrockEngine.assetManager.hasGroup( content.assetGroup ) ) {
						for each ( var assetData:BedrockAssetData in BedrockEngine.assetManager.getGroup( content.assetGroup ) ) {
							BedrockEngine.loadController.getLoader( assetData.id ).dispose();
						}
					}
				}
			} else {
				this.warning( "Loader \"" + $id + "\" not found!" );
			}
		}
		
		public function hasLoader( $nameOrURL:String ):Boolean
		{
			return ( this.getLoader( $nameOrURL ) != null );
		}
		
		public function appendAssetGroup( $assetGroup:BedrockAssetGroupData ):void
		{
			for each( var assetObj:BedrockAssetData in $assetGroup.assets ) {
				this.appendAsset( assetObj );
			}
		}
		public function appendAsset( $asset:BedrockAssetData ):void
		{
			if ( !this.hasLoader( $asset.id ) || ( this.hasLoader( $asset.id ) && this.getLoader( $asset.id ).status >= LoaderStatus.FAILED ) ) {
				this.appendLoader( this._getAssetLoader( $asset ) );
			} else {
				switch ( this.getLoader( $asset.id ).status ) {
					case LoaderStatus.LOADING :
						this.status( "Asset \"" + $asset.id + "\" loading." );
						break;
					case LoaderStatus.COMPLETED :
						this.status( "Asset \"" + $asset.id + "\" already loaded." );
						break;
				}
				
			}
		}
		private function _getAssetLoader( $asset:BedrockAssetData ):LoaderItem
		{
			var loaderVars:Object = new Object;
			loaderVars.name =  $asset.id;
			
			var loader:LoaderItem;
			switch( $asset.type ) {
				case BedrockAssetData.SWF :
					if ( BedrockEngine.containerManager.hasContainer( $asset.container ) ) {
						loaderVars.container = BedrockEngine.containerManager.getContainer( $asset.container );
					} else if ( $asset.container != BedrockData.NONE ) {
						this.warning( "Container \"" + $asset.container + "\" not found for asset \"" + $asset.id + "\"!" );
					}
					loaderVars.context = this._getLoaderContext();
					loader = new SWFLoader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.XML :
					loader = new XMLLoader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.STYLESHEET :
					loader = new CSSLoader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.IMAGE :
					loader = new ImageLoader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.VIDEO :
					loader = new VideoLoader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.AUDIO :
					loader = new MP3Loader( $asset.url, loaderVars );
					break;
				case BedrockAssetData.DATA :
					loader = new DataLoader( $asset.url, loaderVars );
					break;
			}
			return loader;
		}
		/*
		Getters
		*/
		public function getLoader( $nameOrURL:String ):*
		{
			return this._loader.getLoader( $nameOrURL );
		}
		public function getLoaderContent( $nameOrURL:String ):*
		{
			return this._loader.getContent( $nameOrURL );
		}
		public function getRawLoaderContent( $nameOrURL:String ):*
		{
			return this._loader.getContent( $nameOrURL ).rawContent;
		}
		private function _getLoaderContext():LoaderContext
		{
			return new LoaderContext( this._checkPolicyFile, this._applicationDomain );
		}
		
		public function getAssetGroupContents( $id:String ):HashMap
		{
			var assetsHash:HashMap = new HashMap;
			if ( BedrockEngine.assetManager.hasGroup( $id ) ) {
				for each( var assetObj:Object in BedrockEngine.assetManager.getGroup( $id ).assets ) {
					assetsHash.saveValue( assetObj.id, this.getLoaderContent( assetObj.id ) );
				}
			}
			return assetsHash;
		}
		/*
		Event Handlers
		*/
		private function _onLoadProgress( $event:LoaderEvent ):void
		{
			this.dispatchEvent( new BedrockEvent( BedrockEvent.LOAD_PROGRESS, this, { progress:this._loader.progress } ) );
		}
		private function _onLoadComplete( $event:LoaderEvent ):void
		{
			this._empty = true;
			this.dispatchEvent( new BedrockEvent( BedrockEvent.LOAD_COMPLETE, this ) );
		}
		private function _onLoadError( $event:LoaderEvent ):void
		{
			this.dispatchEvent( new BedrockEvent( BedrockEvent.LOAD_ERROR, this ) );
		}
		/*
		Property Definitions
		*/
		public function set checkPolicyFile( $status:Boolean ):void
		{
			this._checkPolicyFile = $status;	
		}
		public function get checkPolicyFile():Boolean
		{
			return this._checkPolicyFile;	
		}
		
		public function set maxConnections( $count:uint ):void
		{
			this._loader.maxConnections = $count;			
		}
		public function get maxConnections():uint
		{
			return this._loader.maxConnections;	
		}
		
		public function set applicationDomain( $applicationDomain:ApplicationDomain ):void
		{
			this._applicationDomain =$applicationDomain;			
		}
		public function get applicationDomain():ApplicationDomain
		{
			return this._applicationDomain;	
		}
		
		public function get empty():Boolean
		{
			return this._empty;	
		}
		
	}

}