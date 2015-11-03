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
			
			for( var i:uint = 0; i < l; i++ )
			{
				
				f = ( arr[ i ] as File );
				
				if( String( f.extension ).toLocaleLowerCase() == "css" )
				{
					
					//trace( f.extension );
					
					// Open file.
					fs = new FileStream;
					fs.open( f, FileMode.READ ); 
					content = fs.readUTFBytes( fs.bytesAvailable )
					fs.close(); 
					
					
					// Need to run REGEX
					// Find Height and Width numbers in file.
					// No numbers on either side.
					// More than likely followed by "px".
					
					var pattern:RegExp = new RegExp( String( srcWidth ) + "px/g" );
					trace(pattern);
						
					var s:String = content.replace( String( srcWidth ) + "px/g", String( destWidth ) + "px" );
					//var s:String = content.replace( pattern, String( destWidth ) + "px" );
						
						
						
					//trace(s);
					
					
					
					
					
					
					// Write content string back into file.
					fs = new FileStream;
					fs.open( f, FileMode.WRITE );
					fs.writeUTFBytes( s );
					fs.close();
					
					
					
					
					//trace(content);
					
					
					
				}
				
				
				
				
				
				
				
				
				
			}
			
			
			
			// Check for HMTL, CSS, JS.
			
			
			// HTML - modify <title>
			
			
			// CSS 
			// - Search for numbers equal to each width and height provided. 
			// - Make sure its not part of a bigger number (120 not part of 1200).
			// - Likely to end with a ";".
			
			
		}
		
		
		
		
	}
	
	
}