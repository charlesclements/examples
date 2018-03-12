package utils
{
	
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	
	public class DeepAssetRename extends EventDispatcher
	{
		
		
		
		private static var fs:FileStream;
		private static var content:String;
		
		
		public function DeepAssetRename(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public static function process($folder:File, $prefix:String="", $suffix:String=""):void
		{
			
			trace("DeepAssetRename - process");
			
			
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
					
					trace("folder : " + f.name);
					
					// Recurse
					DeepAssetRename.process( $folder, $prefix, $suffix );
					
					
					
					
					
				}
				
				
				
				ext = String( f.extension ).toLocaleLowerCase();
				if( ext == "css" || ext == "html" || ext == "htm" )
				{
					
					trace(ext + "folder : " + f.name);
					
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
					
					
					
					
				}
				
			
			
			
		}
		
		
		
		
		
		
	}
}