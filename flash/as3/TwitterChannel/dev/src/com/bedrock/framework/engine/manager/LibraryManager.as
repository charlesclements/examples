package com.bedrock.framework.engine.manager
{
	/*
	Imports
	*/
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.ILibraryManager;
	import com.bedrock.framework.engine.view.IPreloader;
	import com.bedrock.framework.plugin.storage.HashMap;
	
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import com.bedrock.framework.plugin.util.ArrayUtil;

	/*
	Class Declaration
	*/
	public class LibraryManager extends StandardBase implements ILibraryManager
	{
		/*
		* Variable Declarations
		*/
		public static var VIEWS:String = "views";
		public static var PRELOADERS:String = "preloaders";
		public static var BITMAPS:String = "bitmaps";
		public static var SOUNDS:String = "sounds";
		
		private var _collections:HashMap;
		private var _applicationDomain:ApplicationDomain;
		/*
		Initialize the class
		*/
		public function LibraryManager()
		{
			this._collections = new HashMap;
			this._collections.saveValue(LibraryManager.VIEWS, new Array);
			this._collections.saveValue(LibraryManager.PRELOADERS, new Array );
			this._collections.saveValue(LibraryManager.BITMAPS, new Array );
			this._collections.saveValue(LibraryManager.SOUNDS, new Array );
		}
		public function initialize( $applicationDomain:ApplicationDomain ):void
		{
			this._applicationDomain = $applicationDomain;
		}
		/*
		Add/ Return new preloader instance
		*/
		public function registerPreloader( $id:String, $linkage:String ):void
		{
			this._registerAsset( LibraryManager.PRELOADERS, $id, $linkage );
		}
		public function getPreloader( $id:String ):IPreloader
		{
			var ClassReference:Class = this._getAsset( LibraryManager.PRELOADERS, $id );
			return new ClassReference;
		}
		public function hasPreloader($id:String):Boolean
		{
			return ArrayUtil.containsItem( this._getCollection( LibraryManager.PRELOADERS ), $id, "id" );
		}
		/*
		Add/ Return new view instance
		*/
		public function registerView($id:String, $linkage:String ):void
		{
			this._registerAsset( LibraryManager.VIEWS, $id, $linkage );
		}
		public function getView($id:String):*
		{
			var ClassReference:Class = this._getAsset( LibraryManager.VIEWS, $id );
			return new ClassReference;
		}
		public function hasView( $id:String ):Boolean
		{
			return ArrayUtil.containsItem( this._getCollection(LibraryManager.VIEWS), $id, "id" );
		}
		public function getViews( $includeIDs:Boolean = false ):Array
		{
			return this._getInstanceCollection(LibraryManager.VIEWS, this.getView, $includeIDs );
		}
		/*
		Add/ Return new bitmap instance
		*/
		public function registerBitmap( $id:String, $linkage:String ):void
		{
			this._registerAsset( LibraryManager.BITMAPS, $id, $linkage );
		}
		public function getBitmap( $id:String ):BitmapData
		{
			var ClassReference:Class = this._getAsset(LibraryManager.BITMAPS, $id);
			return new ClassReference(0, 0);
		}
		public function hasBitmap( $id:String ):Boolean
		{
			return ArrayUtil.containsItem( this._getCollection(LibraryManager.BITMAPS), $id, "id" );
		}
		public function getBitmaps( $includeIDs:Boolean = false ):Array
		{
			return this._getInstanceCollection(LibraryManager.BITMAPS, this.getBitmap, $includeIDs );
		}
		/*
		Add/ Return new sound instance
		*/
		public function registerSound( $id:String, $linkage:String ):void
		{
			this._registerAsset( LibraryManager.SOUNDS, $id, $linkage );
		}
		public function getSound( $id:String ):Sound
		{
			var ClassReference:Class = this._getAsset( LibraryManager.SOUNDS, $id );
			return new ClassReference;
		}
		public function hasSound( $id:String ):Boolean
		{
			return ArrayUtil.containsItem(this._getCollection(LibraryManager.SOUNDS), $id, "id" );
		}
		public function getSounds( $includeIDs:Boolean = false ):Array
		{
			return this._getInstanceCollection( LibraryManager.SOUNDS, this.getSound, $includeIDs );
		}
		/*
		Manage Classes
		*/
		private function _registerAsset($type:String, $id:String, $linkage:String ):void
		{
			this._getCollection( $type ).push( { id:$id, linkage:$linkage } );
		}
		private function _getAsset( $type:String, $id:String ):Class
		{
			var objData:Object = ArrayUtil.findItem( this._getCollection( $type ), $id, "id" );
			return this._applicationDomain.getDefinition( objData.linkage ) as Class;
		}
		private function _getCollection( $type:String ):Array
		{
			return this._collections.getValue( $type );
		}
		private function _getInstanceCollection($type:String, $creator:Function, $includeIDs:Boolean = false ):Array
		{
			var arrReturn:Array = new Array;
			var arrCollection:Array = this._getCollection($type);
			var numLength:int = arrCollection.length;
			var objData:Object;
			for (var i:int = 0 ; i < numLength; i++) {
				objData= arrCollection[ i ];
				if ( $includeIDs ) {
					arrReturn.push( { id:objData.id, value:$creator( objData.id ) } );
				} else {
					arrReturn.push( $creator( objData.id ) );
				}
			}
			return arrReturn;
		}
		
	}

}