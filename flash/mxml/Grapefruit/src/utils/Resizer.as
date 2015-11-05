package utils
{

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	
	
	public class Resizer
	{
		
		
		private static var fs:FileStream;
		private static var content:String;
		
		
		public function Resizer()
		{
		}
		
		
		public function initialize():void
		{
		}
		
		
		
		public static function run(id:String, srcWidth:Number, srcHeight:Number, destWidth:Number, destHeight:Number, folder:File):void
		{
			
			
			trace( "Resizer - run : " + destWidth + " : " + destHeight + " : " + folder.nativePath );
			
			
			
			// Start running recursive function
			
			
			// Check directory for Array of files.
			var arr:Array = folder.getDirectoryListing();
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
					
				}
				
				
			}
			
			
			
			// Check for HMTL, CSS, JS.
			
			
			// HTML - modify <title>
			
			
			// CSS 
			// - Search for numbers equal to each width and height provided. 
			// - Make sure its not part of a bigger number (120 not part of 1200).
			// - Likely to end with a ";".
			
			
		}
		
		
		public static function replace($raw:String,$tag:String,$content:String):String
		{
			var strRaw:String = $raw;
			var objRegExp:RegExp = new RegExp( $tag, "g" );
			//
			strRaw = strRaw.replace(objRegExp, $content)
			//
			return strRaw;
		}
		
	}
	
	
}