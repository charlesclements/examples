package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import hype.framework.sound.SoundAnalyzer;
	
	//import objects.AudioGadget;
	import objects.Visuals;
	
	public class EuphoriaGraff extends Sprite
	{
		
		//private var _audioGadget:AudioGadget;
		private var _visuals:Visuals;
		private var _clip:Sprite;
		
		
		public function EuphoriaGraff()
		{
			
			
			_clip = new Sprite;
			addChild( _clip );
			
			
			// Create audio gadget.
			//_audioGadget = new AudioGadget;
			//_audioGadget.addEventListener( "READY", onReady );
			//_audioGadget.initialize( {} );
			
			// Visual stuff.
			_visuals = new Visuals();
			_clip.addChild( _visuals );
			_visuals.intitialize( { soundAnalyzer:new SoundAnalyzer, x:0, y:326, w:1200, h:535 } );
			
			
			
			
			
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