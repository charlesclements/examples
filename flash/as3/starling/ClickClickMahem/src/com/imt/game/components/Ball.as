package com.imt.game.components
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	import com.greensock.easing.Power4;
	import com.imt.framework.display.AbstractStarlingDisplay;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.display.button.GameButton;
	import com.imt.framework.event.StarlingSiteEvent;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	// extends GameButton 
	public class Ball extends AbstractStarlingDisplay implements IDisplay
	{
		
		
		private var back:Image;
		private var front:GameButton;
		
		
		
		public function Ball($data:Object=null)
		{
			
			super();	
			data = $data;
			//addEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
			
		}
		
		
		public function initialize(data:Object=null):void
		{
			
			
			if( !initialized )
			{
				
				//trace( this + " : initialize" );
				createArtwork();
				initialized = true;
				
			}
			
		}
		
		
		public function refresh():void
		{
			
			//trace( this + " : refresh" );
			front.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			TweenMax.to( this, 0, { x:data.origX, y:data.origY, scaleX:data.origScaleX, scaleY:data.origScaleY } );
			
		}
				
		
		public function clear():void{};
		public function start():void{};
		
		
		public function intro():void
		{
			
			//trace( this + " : intro : index : " + data.index );
			showBack();
			//TweenMax.fromTo( this, 0.8, { autoAlpha:0, immediateRender:true }, { delay:data.index * 0.6, autoAlpha:1, x:data.targX, y:data.targY, scaleX:data.targScaleX, scaleY:data.targScaleY, onComplete:onIntroComplete, ease:Power4.easeOut } );
			
		}
		
		
		public function outro():void
		{
			
			//trace( this + " : outro : index : " + data.index );
			
			TweenMax.to( this, 0.3, { delay:data.index * 0.1, onStart:showFront, autoAlpha:0, x:data.origX, y:data.origY, scaleX:origScaleX, scaleY:origScaleY, onComplete:onOutroComplete, ease:Power4.easeOut } );
			
		}
		
		
		public function cancel():void{};
		public function destroy():void{};
		
		
		public function showFront():void
		{
			
			//trace( this + " : showFront" );
			if( !contains( front ) ) 
			{
				
				removeChildren();
				addChild( front );
				//TweenMax.fromTo( front, 0.7, { colorTransform:{tint:0xFFFFFF, tintAmount:1.0} }, { colorTransform:{tint:0xFF0000, tintAmount:0.0 } } );
				
			}
			
			touchable = true;
			front.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			
		}
		
		
		public function showBack():void
		{
			
			//trace( this + " : showBack" );
			if( !contains( back ) ) 
			{
				
				removeChildren();
				addChild( back );
				
			}
			
		}
		
		
		private function onEvent(event:Event):void
		{
			
			switch( event.type )
			{
				
				case StarlingSiteEvent.TOUCHED:
					event.stopImmediatePropagation();
					addChild( back );
					removeChild( front );
					front.removeEventListener( StarlingSiteEvent.TOUCHED, onEvent );
					dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.TOUCHED, data ) );
					break;
				
				case Event.ENTER_FRAME:
					
					break;
				
				
				case starling.events.Event.ADDED_TO_STAGE:
					//trace(this + " : " + event.type);
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, onEvent);
					initialize();
					break;
				
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		
		
		// Create artwork.
		private function createArtwork():void
		{
			
			back = new Image( data.atlas.getTexture( data.back ) );
			front = new GameButton( { id:data.id }, data.atlas.getTexture( data.front ) as Texture );
			front.addEventListener( StarlingSiteEvent.TOUCHED, onEvent );
			addChild( front );
			
		}
		
		
		
		private function onIntroComplete():void
		{
			
			showFront();
			
		}
		
		
		
		private function onOutroComplete():void
		{
			
			//showFront();
			
			
			
		}
		
		
		
	}
	
}