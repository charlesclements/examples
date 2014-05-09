package
{
	import com.junkbyte.console.Cc;
	
	import flash.display.MovieClip;
	
	public class Tester extends MovieClip
	{
		public function Tester()
		{
			super();
			
			
			trace("Yoooooo");
			
			
			Cc.startOnStage(this, "");
			Cc.width = 200;
			Cc.log("Hello world.");
			Cc.log("Do something");
			
			
		}
	}
}