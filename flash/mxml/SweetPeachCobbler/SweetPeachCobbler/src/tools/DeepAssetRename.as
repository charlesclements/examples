package tools
{
	
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;

	//import flash.net.FileReference;
	
	//import utils.Resizer;
	
	
	public class DeepAssetRename extends EventDispatcher
	{
		
		
		public static var appName:String = "";
		private static var TEMP:File;
		private static var savedDirectory:File = File.desktopDirectory;//File.documentsDirectory;
		private static var currentDirectory:File;
		private static var fs:FileStream;
		private static var content:String;
		private static var files:Array;
		//private static var dictionary:Dictionary;
		private static var targetObj:Object;
		
		
		public function DeepAssetRename(target:IEventDispatcher=null)
		{
			super(target);
			
			
			
		}
		
		
		public static function init():void
		{
			
			trace("DeepAssetRename init");
			
		}
		
		public static function process($folder:File, $prefix:String="", $deleteHiddenFiles:Boolean=false, $saveOriginals:Boolean=true, $removeUnused:Boolean=false):void
		{
			trace("");
			trace("DeepAssetRename - process : " + arguments );
			currentDirectory = $folder;
			files = [];
			if( $saveOriginals ) saveOriginals( $folder );
			
			trace("KEEP MOVING");
			
			if( $prefix != "" ) $prefix = polishNewName( $prefix );
			
			
			doProcess( $folder, $prefix, $deleteHiddenFiles );
			deepRename();
			
			// Check to see what needs to be removed.
			if( $removeUnused ) checkForWhatNeedsToBeRemoved();
			
			// Do renaming.
			if( $prefix != "" )
			{
				
				doFilesRename();
				cleanup();
				
			}
			
			//if( $saveOriginals ) moveOriginals();
			
			//trace( dictionary );
			trace("DeepAssetRename - process : ENDED" )
			
		}
		
		
		private static function doFilesRename():void
		{
			
			//trace("DeepAssetRename - doFilesRename" );
			for( var i:int = files.length -1; i > -1; i-- )
			{
				
				renameFile( files[ i ] );
				
			}
			
		}
		
		
		//Recursivley copies directory.
		private static function cleanup():void
		{
			
			//trace( "DeepAssetRename - cleanup" );
			
			for( var i:int = files.length -1; i > -1; i-- )
			{
				
				var f:File = files[ i ].file;
				
				if( f.isDirectory )
					f.deleteDirectory( true );
				else if( f.exists )
					f.deleteFile();
				
			}
			
		}
		
		
		//Recursivley copies directory.
		private static function renameFile(obj:Object):void
		{
			
			//trace( "DeepAssetRename - renameFile" );
			var orig:File = obj.file;
			var f:File = obj.parentDirectory;
			orig.copyTo(f.resolvePath( obj.updatedName ), true);
			
		}
		

		private static function checkForWhatNeedsToBeRemoved():void
		{
			
			//trace("DeepAssetRename - checkForWhatNeedsToBeRemoved" );
			
			for( var i:int = files.length -1; i > -1; i-- )
			{
				
				if( files[ i ].occurs == 0 ) 
				{
					
					if( ( files[ i ].file as File ).extension == "html" ) continue;
					if( !files[ i ].isDirectory )
					{
						
						( files[ i ].file as File ).deleteFile(); 
						files.splice(i, 1);
						
					}
					
				}
				
			}
			
		}
		
		
		private static function saveOriginals($folder:File):void
		{
			
			trace("DeepAssetRename - saveOriginals : " + arguments );
			
			// Save in TEMP?
			//var f:File = File.desktopDirectory;
			var f:File = savedDirectory;
			//var a:String = ( appName.length > 0 ) ? f.nativePath + appName : "";
			
			f = f.resolvePath( "ORIGINAL-" + String( new Date ) );
			
			trace(f.nativePath);
			
			// copyInto(directoryToCopy:File, locationCopyingTo:File, copyEmptyFolders:Boolean=true):void
			//copyInto( $folder, f, true );
			copyInto( $folder, f, true );
			
			//savedDirectory = f;
			//trace("DeepAssetRename - saveOriginals - savedDirectory : " + savedDirectory.nativePath );
			
		}
		
		
		
		public static function setSaveDirectory($folder:File):void
		{
			
			trace("setSaveDirectory : " + $folder.nativePath);
			
			trace($folder.nativePath);
			
			savedDirectory = new File( );
			savedDirectory = savedDirectory.resolvePath( $folder.nativePath + "/" + appName );
			trace(savedDirectory.nativePath);
			
		}
		
		
		public static function getSaveDirectory():File
		{
			
			trace("getSaveDirectory : " + savedDirectory);
			return savedDirectory;
			
		}
		
		
		
		private static function moveOriginals():void
		{
			
			//trace("DeepAssetRename - moveOriginals" );
			var f:File = currentDirectory;
			f = f.resolvePath( savedDirectory.name );
			savedDirectory.copyTo( f, true );
			
		}
		
		
		
		//Recursivley copies directory.
		private static function copyInto(directoryToCopy:File, locationCopyingTo:File, copyEmptyFolders:Boolean=true):void
		{
			
			var directory:Array = directoryToCopy.getDirectoryListing();
			
			for each (var f:File in directory)
			{
				if (f.isDirectory)
				{
					
					// Copies a folder whether it is empty or not.
					if( copyEmptyFolders ) f.copyTo(locationCopyingTo.resolvePath(f.name), true);
					
					// Recurse thru folder.
					copyInto(f, locationCopyingTo.resolvePath(f.name));
					
				}
				else
					f.copyTo(locationCopyingTo.resolvePath(f.name), true);
				
			}
			
		}
		
		
		private static function doProcess($folder:File, $prefix:String="", $deleteHiddenFiles:Boolean=false):void
		{
			
			//trace("DeepAssetRename - doProcess : " + arguments );
			
			//trace("Directory: " + $folder.nativePath);
			
			// Check directory for Array of files.
			var arr:Array = $folder.getDirectoryListing();
			var l:uint = arr.length;
			var f:File;
			var ext:String;
			
			for( var i:uint = 0; i < l; i++ )
			{
				
				f = ( arr[ i ] as File );
				
				if( f.isDirectory )
				{
					
					trace("IS_DIRECTORY");
						
					if( $deleteHiddenFiles && f.isHidden ) 
					{
						
						f.deleteDirectory( true );
						continue;
						
					}
					else if( f.isHidden ) continue;
					
					
					
					
					// Need to make sure that the name being replaced is the full doc name including extension.
					
					
					
					
					files.unshift( { file:f, isDirectory:f.isDirectory, parentDirectory:$folder, originalName:f.name, updatedName:$prefix + f.name, occurs:0 } );
					//files.unshift( { file:f, isDirectory:f.isDirectory, parentDirectory:$folder, originalName:f.name + "." + f.extension, updatedName:$prefix + f.name + "." + f.extension, occurs:0 } );
					
					// Recurse
					doProcess( f, $prefix, $deleteHiddenFiles );
					
					continue;
					
				}
				
				// Check if hidden.
				if( $deleteHiddenFiles && f.isHidden ) 
				{
					
					f.deleteFile();
					continue;
					
				}
				else if( f.isHidden ) continue;
				
				trace("IS_FILE");
				
				
				ext = String( f.extension ).toLocaleLowerCase();
				
				//trace("file : " + $folder.nativePath + " : " + ext + "file : " + f.name + ( ( f.isHidden )?" - HIDDEN":"" ));
				
				
				
				trace(f.name);
				
				
				//files.unshift( { file:f, isDirectory:f.isDirectory, parentDirectory:$folder, originalName:f.name, updatedName:$prefix + f.name, occurs:0 } );
				files.unshift( { file:f, isDirectory:f.isDirectory, parentDirectory:$folder, originalName:f.name, updatedName:$prefix + f.name, occurs:0 } );
			
				
				
				
				
				
				
				
			}
			
		}
		
		
		private static function deepRename():void
		{
			
			//trace("" )
			//trace("DeepAssetRename - deepRename()" )
			
			for ( var a:uint=0; a < files.length; a++ )
			{
				
				//trace("-");
				
				if( files[ a ].isDirectory ) continue;
				
				for ( var b:uint=0; b < files.length; b++ )
				{
					
					targetObj = files[ b ];
					//renameWithinFile( files[ a ].file, files[ b ].originalName, files[ b ].updatedName );
					renameWithinFile( files[ a ].file, String( '"'+files[ b ].originalName+'"' ), String( '"'+files[ b ].updatedName+'"' ) );
					renameWithinFile( files[ a ].file, String( '"./'+files[ b ].originalName+'"' ), String( '"./'+files[ b ].updatedName+'"' ) );
					renameWithinFile( files[ a ].file, String( '"./'+files[ b ].originalName+'?' ), String( '"./'+files[ b ].updatedName+'?' ) );
					renameWithinFile( files[ a ].file, String( '('+files[ b ].originalName+')' ), String( files[ b ].updatedName ) );
					
				}
				
			}
			
		}
		
		
		// This function searches within a file and replaces a string.
		public static function polishNewName(newString:String):String
		{
			
			trace("DeepAssetRename - polishNewName");
			return replace( newString, " ", "_" );
			
			
		}
		
		// This function searches within a file and replaces a string.
		public static function renameWithinFile(file:File, originalString:String, newString:String):void
		{
			//trace("DeepAssetRename - renameWithinFile - " + originalString + " : " + newString);
			
			var ext:String = String( file.extension ).toLocaleLowerCase();
			if( ext == "css" || ext == "html" || ext == "htm" || ext == "json" || ext == "js" )
			{
				
				//trace( "DeepAssetRename - renameInFile : " + "FILE: " + file.name + " | ORIG:" + originalString + " | UPDATE:" + newString );
				
				// Open file.
				fs = new FileStream;
				fs.open( file, FileMode.READ ); 
				content = fs.readUTFBytes( fs.bytesAvailable )
				fs.close(); 
				
				// Replace name.
				var s:String = content;
				
				if( s.split(originalString).length-1 < 1 )
				{
					
					//dictionary[ originalString ] = file;
					//trace( "KEEP GOING" )
					
				}
				else
				{
					
					targetObj.occurs += 1;
					
					s = replace( s, originalString, newString );

					// Write content string back into file.
					fs = new FileStream;
					fs.open( file, FileMode.WRITE );
					fs.writeUTFBytes( s );
					fs.close();
					
				}
				
			}
			
		}
		
		
		// This function could posssibly be optimized in fewer lines.
		public static function replace($raw:String,$tag:String,$content:String):String
		{
			//trace("REPLACE");
			var strRaw:String = $raw;
			var objRegExp:RegExp = new RegExp( $tag, "g" );
			//
			strRaw = strRaw.replace(objRegExp, $content)
			//
			return strRaw;
		}
		
		
	}
	
	
}