package hype.framework.core
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	import com.imt.framework.display.button.AbstractButton;
	import com.imt.framework.event.StarlingSiteEvent;
	import com.imt.model.Storage;
	import com.imt.objects.Armor;
	import com.imt.objects.IParticle;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ObjectPoolLayerStarling extends Sprite
	{
		
		
		private var _pool:ObjectPool;
		private var _content:*;
		private var _container:Sprite;
		
		
		public function ObjectPoolLayerStarling(content:*, max:uint, container:Sprite)
		{
			
			super();
			
			_container = container;
			_pool = new ObjectPool( content, max );
			
			
			_pool.onCreateObject = function(clip:IParticle) 
			{
				
				trace(this + " : pool.onCreateObject");
				
			}
			
			
			_pool.onRequestObject = function(clip:IParticle) 
			{
				
				trace("");
				trace(this + " : pool.onRequestObject");
				
				//( clip as Sprite )
				
				( clip as Sprite ).x = Math.random() * Storage.WIDTH;
				( clip as Sprite ).y = Math.random() * Storage.HEIGHT;
				( clip as Sprite ).scaleX = ( clip as Sprite ).scaleY = 0.6 + ( Math.floor( Math.random() * 3 ) * 0.6);
				( clip as AbstractButton ).enable();
				( clip as Sprite ).addEventListener( StarlingSiteEvent.TOUCHED, _onEvent );
				_container.addChild( ( clip as Sprite ) );
				clip.startBehaviour();
				
			}

			
		}
		
		
		private function _onEvent(event:Event):void
		{
			
			trace( this + " _onEvent : " + event.type );
			
			// Reuseable var.
			var i:uint;// "for loops".
			var clip:Armor;
			var length:uint// Used in "for loops".
			
			switch( event.type )
			{
				
				case StarlingSiteEvent.TIMER_COMPLETE:
					trace( this + " : StarlingSiteEvent.TIMER_COMPLETE" );
					_gameComplete();
					break;
				
				case StarlingSiteEvent.PAUSE:
					trace( this + " : StarlingSiteEvent.PAUSE" );
					_displayTimeline.pause();
					break;
				
				case StarlingSiteEvent.RESUME:
					trace( this + " : StarlingSiteEvent.RESUME" );
					_displayTimeline.resume();
					break;
				
				case StarlingSiteEvent.TOUCHED:
					_numActiveParticles--;
					clip = event.currentTarget as Armor;
					clip.disable();
					_pool.release( clip );
					clipContainer.addChildAt( clip, 0 );
					if( _numActiveParticles <= 0 ) _gameComplete();
					break;
				
				case starling.events.Event.ADDED_TO_STAGE:
					removeEventListener( starling.events.Event.ADDED_TO_STAGE, _onEvent);
					initialize();
					break;
				
				default:
					trace(this + " : Unhandled event.");
					
			}
			
		}
		
		
		
		// Removes particles in play.
		public function requestAll():void
		{
			
			
			_pool.releaseAll();
			
			
			
		}
			
		
		// Removes particles in play.
		private function _clearParticles():void
		{
			
			trace(this + " : _clearParticles()");
			
			var clip:IParticle;
			//var l:uint = clipContainer.numChildren;
			
			
			
			_pool.releaseAll();
			var l:uint = _pool.inactiveSet.length;
			
			// active
			
			//trace(l);
			
			for( var i:uint = 0; i < l; i++ )
			{
				
				//clip = _pool.inactiveSet.pull() as Armor;
				clip = _pool.inactiveSet.pull() as IParticle;
				_pool.tempSet.insert( clip );
				
				// Run tweening here.
				TweenMax.to( ( clip as Sprite ), 1, { scaleX:0.4, scaleY:0.4, x:Storage.WIDTH / 2, y:Storage.HEIGHT / 2, onComplete:clip.removeMe, delay:0.02 * i, ease:Quad.easeIn } );
				
			}
			
			// Place back into inactiveSet.
			for( i = 0; i < l; i++ )
			{
				
				_pool.inactiveSet.insert( _pool.tempSet.pull() );
				
			}
			
			
		}
		
		
		
		
		
	}
	
}