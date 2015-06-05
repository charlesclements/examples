package com.imt.framework.gadget.text
{
	
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.engine.data.GameData;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class TemporaryText extends AbstractStarlingDisplay implements IDisplay
	{
		
		
		private var text:Image;
		private var texture:Texture;
		private var tween:TweenMax;
		private var timeline:TimelineMax;
		
		
		public function TemporaryText($texture:Texture)
		{
			
			super();
			texture = $texture;
			addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			
			if( !initialized )
			{
				
				//trace(this + " : initialize()");
				visible = false;
				text = new Image( texture );
				x = ( GameData.STAGE_WIDTH / 2 ) - ( text.width / 2 );
				y = 110;
				addChild( text );
				timeline = new TimelineMax();
				timeline.append( new TweenMax( this, 0, { autoAlpha:0 } ) );
				timeline.append( new TweenMax( this, 0.4, { autoAlpha:1 } ) );
				timeline.append( new TweenMax( this, 0.4, { delay:2, autoAlpha:0 } ) );
				timeline.pause( 0 );
				initialized = true;
				
			}
			
		}
		
		
		public function refresh():void
		{
			
			//trace(this + " : refresh()");
			alpha = 0;
			visible = false;
			if( !initialized ) initialize();
			timeline.pause( 0 );
			//trace(this + " : refresh() END");
			
		}
		
		
		public function clear():void{};
		
		
		public function start():void
		{
			
			trace(this + " : start()");
			timeline.play( 0 );
			
		}
		
		
		public function intro():void
		{
			
			trace(this + " : intro()");
			TweenMax.fromTo( this, 0.4, { autoAlpha:0 }, { autoAlpha:1 } );
			
		}
		
		
		public function outro():void
		{
			
			trace(this + " : outro()");
			TweenMax.to( this, 0.4, { autoAlpha:0 } );
			
		}
		
		
		public function cancel():void{};
		public function destroy():void{};
		
		
		// Handle all the events.
		private function onEvent(event:Event):void
		{
			
			switch( event.type )
			{
				
				
				case starling.events.Event.ADDED_TO_STAGE:
					//trace(this + " : " + event.type);
					addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
					initialize();
					break;
				
				
			}
			
		}
		
		
	}
	
	
}