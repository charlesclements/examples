package
{
	import com.yr.tracknames.gadgets.AudioGadget;
	import com.yr.tracknames.gadgets.Visuals;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import objects.Visuals;
	
	public class EuphoriaGraff extends Sprite
	{
		public function EuphoriaGraff()
		{
			
			
			
			
			
			// Create audio gadget.
			_audioGadget = new AudioGadget;
			_audioGadget.addEventListener( "READY", onReady );
			_audioGadget.initialize( {} );
			
			// Visual stuff.
			_visuals = new Visuals();
			_clip.addChild( _visuals );
			_visuals.intitialize( { soundAnalyzer:_audioGadget.soundAnalyzer, x:0, y:326, w:1200, h:535 } );
			
			
			
			
			
			var c:Visuals = new Visuals;
			c.intitialize( { x:0, y:0, w:500, h:500 } );
			addChild( c );
			
			
		}
		
		
		
		
		
		private function onReady(e:Event):void
		{
			
			
			trace("EuphoriaGraff - onReady");
			
			
			
			
		}
		
		
		
	}
}