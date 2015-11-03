package utils
{
	import flash.filesystem.File;
	
	
	public class Resizer
	{
		
		
		public function Resizer()
		{
		}
		
		
		public function initialize():void
		{
		}
		
		
		public static function run(id:String, width:Number, height:Number, folder:File):void
		{
			
			
			trace( "run : " + width + " : " + height + " : " + folder.nativePath );
			// Start running recursive function
			
			
			// Check for HMTL, CSS, JS.
			
			
			// HTML - modify <title>
			
			
			// CSS 
			// - Search for numbers equal to each width and height provided. 
			// - Make sure its not part of a bigger number (120 not part of 1200).
			// - Likely to end with a ";".
			
			
		}
		
		
		
		
	}
	
	
}