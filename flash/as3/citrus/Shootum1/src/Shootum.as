package
{
	
	import citrus.core.starling.StarlingCitrusEngine;
	[SWF(width="1024", height="748", framerate=60, backgroundColor="#0xCCCCCC"]
	public class Shootum extends StarlingCitrusEngine 
	{
			
			public function Shootum() 
			{
			}
			
			override public function initialize():void {
				setUpStarling(true);
			}
			
			override public function handleStarlingReady():void {
				state = new StarlingDemoGameState();
			}
			
	}
}