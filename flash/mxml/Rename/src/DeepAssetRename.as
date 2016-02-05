package
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
		
		
		
		private static var TEMP:File;
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
		
		
		public static function process($folder:File, $prefix:String="", $suffix:String="", $deleteHiddenFiles:Boolean=false, $saveOriginals:Boolean=true, $removeUnused:Boolean=false):void
		{
			trace("");
			trace("DeepAssetRename - process : " + arguments );
			files = [];
			if( $saveOriginals ) saveOriginals( $folder );
			doProcess( $folder, $prefix, $suffix, $deleteHiddenFiles );
			deepRename();
			
			
			trace( files );
			trace( files.length );
			trace( "+" );
			
			
			// Check to see what needs to be removed.
			if( $removeUnused ) checkForWhatNeedsToBeRemoved();
			
			// Do renaming.
			
			trace( files );
			trace( files.length );
			trace( "+" );
			
			
			
			doFilesRename();
			
			
			
			
			
			//trace( dictionary );
			trace("DeepAssetRename - process : ENDED" )
			
		}
		
		
		private static function doFilesRename():void
		{
			
			trace("DeepAssetRename - doFilesRename" );
			
			
			for( var i:int = files.length -1; i > -1; i-- )
			{
				
				trace( i );
				
				
				
				
				
				//var newFile:File = new File;
				
				//newFile.resolvePath(  );
				
				
				
				
				
				
				
				
				
			}
			
			
			
			
		}
		
		
		
		
		private static function checkForWhatNeedsToBeRemoved():void
		{
			
			trace("DeepAssetRename - checkForWhatNeedsToBeRemoved" );
			
			
			//for( var i:uint = 0; i < files.length; i++ )
			for( var i:int = files.length -1; i > -1; i-- )
			{
				
				trace( i );
				trace(files[ i ].occurs);
				
				if( files[ i ].occurs == 0 ) 
				{
					
					
					
					if( ( files[ i ].file as File ).extension == "html" ) continue;
					
					
					/*
					if( ( files[ i ].file as File ).extension == "html" )
					
					
					if( files[ i ].isDirectory ) ( files[ i ].file as File ).deleteDirectory( true );
					else ( files[ i ].file as File ).deleteFile(); 
					*/	
					
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
			
			
			
			
		}
		
		private static function doProcess($folder:File, $prefix:String="", $suffix:String="", $deleteHiddenFiles:Boolean=false):void
		{
			
			//trace("");
			trace("DeepAssetRename - doProcess : " + arguments );
			
			//trace("");
			trace("Directory: " + $folder.nativePath);
			
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
					//trace("");
					trace("folder : " + f.name);
					
					//
					//files.unshift( { file:f, isDirectory:f.isDirectory, originalName:f.name, updatedName:$prefix + f.name + $suffix } );
					files.unshift( { file:f, isDirectory:f.isDirectory, originalName:f.name, updatedName:$prefix + f.name, occurs:0 } );
					
					
					//f.resolvePath( files[ 0 ].updated );
					
					
					// Recurse
					doProcess( f, $prefix, $suffix, $deleteHiddenFiles );
					
					continue;
					
					
					
				}
				
				
				// Check if hidden.
				if( f.isHidden ) continue;
				
				
				
				ext = String( f.extension ).toLocaleLowerCase();
				/*if( ext == "css" || ext == "html" || ext == "htm" )
				{
					
					trace("file : " + $folder.nativePath + " : " + ext + "file : " + f.name + ( ( f.isHidden )?" - HIDDEN":"" ));
					
					
					//
					//files.unshift( { file:f, isDirectory:f.isDirectory, originalName:f.name + f.extension, updatedName:$prefix + f.name + $suffix + f.extension } );
					files.unshift( { file:f, isDirectory:f.isDirectory, originalName:f.name, updatedName:$prefix + f.name } );
					
					
					//f.resolvePath( files[ 0 ].updated );
					
					
					continue;
					
					
					
				}
				
				*/
				
				
				trace("file : " + $folder.nativePath + " : " + ext + "file : " + f.name + ( ( f.isHidden )?" - HIDDEN":"" ));
				//if( f.isHidden ) trace();
				
				
				
				files.unshift( { file:f, isDirectory:f.isDirectory, originalName:f.name, updatedName:$prefix + f.name, occurs:0 } );
				
				
				
			
			}
			
			
			//trace("DeepAssetRename - doProcess : ENDED" )
			
		}
		
		
		
		
		private static function deepRename():void
		{
			trace("" )
			trace("DeepAssetRename - deepRename()" )
			
			
			//files
			
			
			for ( var a:uint=0; a < files.length; a++ )
			{
				
				trace("-");
				//trace("a : " + a);
				
				if( files[ a ].isDirectory ) continue;
				
				for ( var b:uint=0; b < files.length; b++ )
				{
					
					//trace("b : " + b);
					
					targetObj = files[ b ];
					renameInFile( files[ a ].file, files[ b ].originalName, files[ b ].updatedName );
					
				}
				
				
				
				
			}
			
			
			
			
			
			
			
		}
		
		
		
		// This function seraches within a file and replaces a string.
		public static function renameInFile(file:File, originalString:String, newString:String):void
		{
			
			
			
			
			// Check directory for Array of files.
			//var arr:Array = file.getDirectoryListing();
			//var l:uint = arr.length;
			//var file:File;
			var ext:String = String( file.extension ).toLocaleLowerCase();
			if( ext == "css" || ext == "html" || ext == "htm" )
			{
				
				trace( "DeepAssetRename - renameInFile : " + "FILE: " + file.name + " | ORIG:" + originalString + " | UPDATE:" + newString );
				
				//trace(ext);
				
				// Open file.
				fs = new FileStream;
				fs.open( file, FileMode.READ ); 
				content = fs.readUTFBytes( fs.bytesAvailable )
				fs.close(); 
				
				// Replace name.
				var s:String = content;
				
				trace("+");
				trace(s.split(originalString).length-1);				
				//trace("+");
				
				
				
				//, occurs:0
				
				
				
				
				
				if( s.split(originalString).length-1 < 1 )
				{
					
					//dictionary[ originalString ] = file;
					
					trace( "KEEP GOING" )
					
				}
				else
				{
					
					
					//trace( dictionary[ originalString ] )
					
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
		
		
		
		/*
		// This function seraches within a file and replaces a string.
		public static function renameInFile(file:File, originalString:String, newString:String):void
		{
			
			
			trace( "DeepAssetRename - renameInFile : " + newString + " : " + file.nativePath );
			
			// Check directory for Array of files.
			var arr:Array = file.getDirectoryListing();
			var l:uint = arr.length;
			var f:File;
			var ext:String;
			
			for( var i:uint = 0; i < l; i++ )
			{
				
				f = ( arr[ i ] as File );
				ext = String( f.extension ).toLocaleLowerCase();
				if( ext == "css" || ext == "html" || ext == "htm" )
				{
					
					trace(ext);
					
					// Open file.
					fs = new FileStream;
					fs.open( f, FileMode.READ ); 
					content = fs.readUTFBytes( fs.bytesAvailable )
					fs.close(); 
					
					// Replace name.
					var s:String = content;
					s = replace( s, String( originalString ) + "px", String( newString ) + "px" );
					//s = replace( s, "width=" + String( originalString ), "width=" + String( newString ) );
					
					// Write content string back into file.
					fs = new FileStream;
					fs.open( f, FileMode.WRITE );
					fs.writeUTFBytes( s );
					fs.close();
					
				}
				
			}
			
		}
		*/
		
		
		
		
		
		// This function could posssibly be optimized in fewer lines.
		public static function replace($raw:String,$tag:String,$content:String):String
		{
			trace("REPLACE");
			var strRaw:String = $raw;
			var objRegExp:RegExp = new RegExp( $tag, "g" );
			//
			strRaw = strRaw.replace(objRegExp, $content)
			//
			return strRaw;
		}
		
		
		
		
		
		
		
		
			
			/*
			
			// Open file.
			fs = new FileStream;
			fs.open( f, FileMode.READ ); 
			content = fs.readUTFBytes( fs.bytesAvailable )
			fs.close(); 
			
			
			
			
			
			
			
			// Replace height and width.
			var s:String = content;
			s = replace( s, String( srcWidth ) + "px", String( destWidth ) + "px" );
			s = replace( s, String( srcHeight ) + "px", String( destHeight ) + "px" );
			s = replace( s, "width=" + String( srcWidth ), "width=" + String( destWidth ) );
			s = replace( s, "height=" + String( srcWidth ), "height=" + String( destHeight ) );
			
			// Special case managing if the content is 2 pixels smaller in order to center within html border.
			s = replace( s, String( srcWidth - 2 ) + "px", String( destWidth - 2 ) + "px" );
			s = replace( s, String( srcHeight - 2 ) + "px", String( destHeight - 2 ) + "px" );
			
			// Replace key.
			s = replace( s, String( srcWidth ) + "x" + String( srcHeight ), id );
			
			// Write content string back into file.
			fs = new FileStream;
			fs.open( f, FileMode.WRITE );
			fs.writeUTFBytes( s );
			fs.close();
			
			*/
		
		
		
		
		/*
		private function copyDirectory():void
		{
		
		trace("copyDirectory");
		
		
		if( sourceFolderSelected && destFolderSelected && srcWidthTxt.text.length > 0 && srcHeightTxt.text.length > 0 )
		{
		
		trace("copyDirectory - Do copying.");
		
		sourceWidth = Number( srcWidthTxt.text );
		sourceHeight = Number( srcHeightTxt.text );
		
		
		for ( var i:String in SO.data.sizes ) 
		{ 
		
		
		
		if( SO.data.sizes[ i ].selected )
		{
		
		// Create new folder.
		var str:String = String( destFolder.nativePath + "/" + i );
		var newFolder:File = new File( str );
		if( !newFolder.exists ) newFolder.createDirectory();
		
		// Copy files.
		sourceFolder.copyTo( newFolder, true );
		
		// run Resizer
		Resizer.run( i, sourceWidth, sourceHeight, SO.data.sizes[ i ].width, SO.data.sizes[ i ].height, newFolder );
		
		
		}
		
		
		
		}
		
		srcWidthTxt.text = "";
		srcHeightTxt.text = "";
		
		}
		
		}
		*/
		
		
	}
}