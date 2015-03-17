package net.charlesclements.gadgets.display
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.CameraRoll;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	
	public class LoadLocalBitmap extends Sprite
	{
		
		
		private var _w:uint;
		private var _h:uint;
		private var _cameraRoll:CameraRoll;
		private var _file:File;
		private var _loader:Loader;
		private var _b:Bitmap;
		private var _holder:Sprite;
		
		
		
		public function LoadLocalBitmap(w:uint=100, h:uint=100)
		{
			
			trace("LoadLocalBitmap");
			super();
			
			_w = w;
			_h = h;
			
			graphics.beginFill( 0xfff );;
			graphics.drawRect( 0, 0, _w, _h );
			graphics.endFill();
			
			
			
			
		}
		
		
		
		public function load():void
		{
			
			trace("LoadLocalBitmap - load()");
			
			
			_cameraRoll = new CameraRoll;
			
			if( CameraRoll.supportsBrowseForImage )
			{
				/*
				trace( "LoadLocalBitmap - supportsBrowseForImage - true");
				_cameraRoll.addEventListener(MediaEvent.SELECT, _onSelected );
				_cameraRoll.addEventListener(Event.CANCEL, _onCancel );
				_cameraRoll.addEventListener(ErrorEvent.ERROR, _onError );
				*/
				_cameraRoll.browseForImage();
				
			}
			else 
			{
				
				trace( "LoadLocalBitmap - _doPhoto() - No Image support. Use regular browse." );
				
				// Fire up File stuff here.
				_file = new File;
				_file.addEventListener( Event.SELECT, _onFileEvent );
				_file.browseForOpen( "Select an image", [ new FileFilter("Images", "*.jpg;*.gif;*.png") ] );
				
			}
			
			
			
		}
		
		
		private function _onLoaderEvent(e:Event):void
		{
			
			//trace("LoadLocalBitmap - _onLoaderEvent() : " + e.type);
			
			switch( e.type )
			{
				
				case Event.OPEN:
					trace( "LoadLocalBitmap - _onLoaderEvent() : Event.OPEN" );
					
					break;
				
				case Event.CANCEL:
					trace( "LoadLocalBitmap - _onLoaderEvent() : Event.CANCEL" );
					
					break;
				
				case Event.COMPLETE:
					trace( "LoadLocalBitmap - _onLoaderEvent() : Event.COMPLETE" );
					
					// REmove listeners.
					_loader.contentLoaderInfo.removeEventListener( Event.OPEN, _onLoaderEvent );
					_loader.contentLoaderInfo.removeEventListener( ErrorEvent.ERROR, _onLoaderEvent );
					_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _onLoaderEvent );
					_loader.contentLoaderInfo.removeEventListener( Event.CANCEL, _onLoaderEvent );
					
					// Do something with the Bitmap.
					trace( e.currentTarget );
					trace( ( e.currentTarget as LoaderInfo ).content );
					
					var b:Bitmap = ( e.currentTarget as LoaderInfo ).content as Bitmap;
					

					addChild( b );
					
					
					
					
					
					
					break;
				
				case ErrorEvent.ERROR:
					trace( "LoadLocalBitmap - _onLoaderEvent() : ErrorEvent.ERROR" );
					
					break;
				
				default:
					trace( "LoadLocalBitmap - _onLoaderEvent() : Event not handled" );
					
			}
			
		}

		private function _onFileEvent(e:Event):void
		{
			
			//trace("LoadLocalBitmap - _onFileEvent() : " + e.type);
			
			switch( e.type )
			{
			
			case Event.SELECT:
			trace( "LoadLocalBitmap - _onFileEvent() : Event.OPEN" );
			_file.removeEventListener( Event.SELECT, _onFileEvent );
			_file.addEventListener( Event.COMPLETE, _onFileEvent );
			_file.load();
			break;
			
			case Event.CANCEL:
			trace( "LoadLocalBitmap - _onFileEvent() : Event.CANCEL" );
			
			break;
			
			case Event.COMPLETE:
			trace( "LoadLocalBitmap - _onFileEvent() : Event.COMPLETE" );
			_loader = new Loader;
			_loader.contentLoaderInfo.addEventListener( Event.OPEN, _onLoaderEvent );
			_loader.contentLoaderInfo.addEventListener( ErrorEvent.ERROR, _onLoaderEvent );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _onLoaderEvent );
			_loader.contentLoaderInfo.addEventListener( Event.CANCEL, _onLoaderEvent );
			// Load bytes from the File.
			_loader.loadBytes( ( e.currentTarget as File ).data as ByteArray )
			break;
			
			case ErrorEvent.ERROR:
			trace( "LoadLocalBitmap - _onFileEvent() : ErrorEvent.ERROR" );
			
			break;
			
			default:
			trace( "LoadLocalBitmap - _onFileEvent() : Event not handled" );
			
			}
			
		}
		
	}
}