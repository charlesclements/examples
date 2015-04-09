package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	
	import de.danielyan.twitterAppOnly.TwitterSocket;
	import de.danielyan.twitterAppOnly.TwitterSocketEvent;
	
	import events.TwitterEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import oak.easing.TweenManager;
	
	import views.TwitterView;
	
	public class TwitterAppOnly extends Sprite
	{
		
		private var _view:TwitterView;
		private var _twitter:TwitterSocket;
		private var _count:uint = 30;
		private var _request:String;
		private var _screenname:String = "miamichildrens";
		
		
		public function TwitterAppOnly()
		{
			
			super();
			
			MonsterDebugger.initialize( this );
			MonsterDebugger.trace( this, "TwitterAppOnly" );
			
			
			//_view = new TwitterView;
			_view.addEventListener( TwitterEvent.TIMING_COMPLETE, _onEvent );
			_view.initialize({});
			
			
			
			
			// This is the requst to be reused including the _count of tweets.
			_request = "/1.1/statuses/user_timeline.json?count="+ _count +"&screen_name="+_screenname;
			
			// Read more about Application-Only authentication here:
			// https://dev.twitter.com/docs/auth/oauth#v1-1
			// and here:
			// https://dev.twitter.com/docs/auth/application-only-auth
			_twitter = new TwitterSocket( "9syskTUk9B5aouKoPsw", "LsN2chhjV6eJi0bdl3YUkJpmOqgQxQOXFwNwBXQlRw" );
			
			// twitter socket uses two events: 
			// * The Ready event, when an app Token has been received
			_twitter.addEventListener(TwitterSocket.EVENT_TWITTER_READY, _onEvent);
			// * The Twitter Data event, when the twitter Request has finished
			_twitter.addEventListener(TwitterSocket.EVENT_TWITTER_RESPONSE, _onTwitterData);
			
		}
		
		
		private function _onEvent(e:Event):void
		{
			
			switch(e.type)
			{
				
				case TwitterEvent.TIMING_COMPLETE:
					_twitter.request( _request );
					break
				
				case TwitterSocket.EVENT_TWITTER_READY:
					MonsterDebugger.trace( this, "_onTwitterReady" );
					// place your twiter requests here
					_twitter.request( _request );
					break;
				
			}
			
		}
		
		
		private function _onTwitterReady(event:Event):void
		{
			
			
			
		}
		
		
		private function _onTwitterData(event:TwitterSocketEvent):void
		{
			
			MonsterDebugger.trace( this, "_onTwitterData" );
			MonsterDebugger.trace( this, event.response as Array );
			_view.update( event.response as Array );
			TweenMax.to( {}, 5, {  onComplete:_twitter.request, onCompleteParams:[ _request ] } );
			
		}
		
		
		
		
		/*
		private function createTweets($arr:Array):void
		{
			
			trace("createTweets");
			
			var arr:Array = [];
			
			for( var i:uint = 0; i < $arr.length; i++ )
			{
				
				arr.push( { content:( $arr[i].screen_name + " - " + $arr[i].text ), screen_name:$arr[i].screen_name } );
				
			}
			
			// Store tweets.
			_clips.clear();
			_clips = new SuperArray( arr );
			_clips.wrapIndex = true;
			_clips.setSelected( -1 );
			
			// Is the pool full (all objects in activeSet)?
			var spawn:Boolean = ( _pool.isFull ) ? false : true;
			
			// Add condition here to see if a new ObjectPool really needs to be created.
			
			// Destroy all objects that currently exist in pool.
			destroyCurrentObjects();
			_pool = new ObjectPool( [ RandomizerTextfield ], _total );
			_pool.onRequestObject = onRequestObject;
			_pool.request();
			
			// Recheck in timer.
			doTimer();
			
		}
		*/
		
	}
		
}