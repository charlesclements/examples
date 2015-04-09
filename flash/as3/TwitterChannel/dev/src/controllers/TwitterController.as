package controllers

{
	import assets.Configuration;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	import events.TwitterControllerEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;
	
	import models.MentionModel;
	
	import oak.interfaces.IDestroyable;
	
	[Event(name="complete", type="flash.events.Event")]
	public class TwitterController extends EventDispatcher implements IDestroyable
	{
		private const fileName:String = "twitter.file";
		
		private const consumerKey:String = Configuration.TWITTER_CONSUMER_KEY;
		private const consumerSecret:String = Configuration.TWITTER_CONSUMER_SECRET;
		
		private var _destroyed:Boolean;
		
		private var _twitter:Twitter;
		private var _token:TwitterTokenSet;
		
		private var _stage:Stage;
		private var _webView:StageWebView;
		
		private var _mentionedSinceID:String;
		private var _mentions:Vector.<MentionModel>;
		private var _mentionChecker:Timer;
		
		public function TwitterController(stage:Stage)
		{
			_stage = stage;
			
			_init();
		}
		
		private function _init():void
		{
			
			//MonsterDebugger.initialize( this );
			
			_checkForSettings();
			
			var request:TwitterRequest;
			var complete:Function;
			
			if (_token && _token.oauthToken.length)
			{
				_twitter = new Twitter(consumerKey, consumerSecret, _token.oauthToken, _token.oauthTokenSecret);
				request = _twitter.account_verifyCredentials();
				complete = _verifyCompleteHandler;
			} else
			{
				_twitter = new Twitter(consumerKey, consumerSecret);
				request = _twitter.oauth_requestToken();
				complete = _tokenCompleteHandler;
			}
			
			_setHandlersForRequest(request, complete);
		}
		
		private function _setHandlersForRequest(request:TwitterRequest, completeHandler:Function):void
		{
			MonsterDebugger.trace(this,"_setHandlersForRequest");
			request.addEventListener(TwitterRequestEvent.COMPLETE, completeHandler);
			request.addEventListener(IOErrorEvent.IO_ERROR, _errorHandler);
			request.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _errorHandler);
			request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, _errorHandler);
			request.addEventListener(TwitterErrorEvent.SERVER_ERROR, _errorHandler);
		}
		
		private function _verifyCompleteHandler(event:TwitterRequestEvent):void
		{
			
			MonsterDebugger.trace( this, "_verifyCompleteHandler" );
			MonsterDebugger.trace( this, event );
			
			dispatchEvent(new Event(Event.COMPLETE));
			
			// check every ten minutes
			_mentionChecker = new Timer(600000, 0);
			_mentionChecker.addEventListener(TimerEvent.TIMER, _checkMentionsHandler);
			_mentionChecker.start();
			
			_checkMentions();
		}
		
		private function _checkMentionsHandler(event:TimerEvent):void
		{
			_checkMentions();
		}
		
		private function _tokenCompleteHandler(event:TwitterRequestEvent):void
		{
			
			MonsterDebugger.trace( this, "_tokenCompleteHandler" );
			MonsterDebugger.trace( this, event );
			
			var request:URLRequest = new URLRequest(_twitter.getOAuthAuthorizeURL());
			
			_webView = new StageWebView();
			_webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, _locationChangeHandler);
			_webView.viewPort = new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight);
			_webView.stage = _stage;
			_webView.assignFocus();
			_webView.loadURL(request.url);
		}
		
		private function _locationChangeHandler(event:LocationChangeEvent):void
		{
			
			MonsterDebugger.trace( this, "_locationChangeHandler" );
			MonsterDebugger.trace( this, event );
			
			if (event.location.search("oauth_token") >= 0) return;
			
			_webView.loadURL("javascript:document.title=document.documentElement.innerHTML;");
			
			// when running on windows, the webview title trick will be avaiable next frame.
			setTimeout(_extractPin, 16);
		}
		
		private function _extractPin():void
		{
			
			
			MonsterDebugger.trace( this, "_extractPin" );
			
			
			
			
			var pin:String = String(_webView.title.split('process:</span> <kbd aria-labelledby="code-desc"><code>')[1]).split("<")[0];
			
			MonsterDebugger.trace( this, _webView );
			MonsterDebugger.trace( this, _webView.title );
			MonsterDebugger.trace( this, pin.length );
			
			// pin.length is 9 because it is "undefined".
			
			
			
			
			MonsterDebugger.trace( this, pin );
			MonsterDebugger.trace( this, "" );
			
			if (pin.length)
			{
				_webView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE, _locationChangeHandler);
				_webView.dispose();
				_webView = null;
				
				var request:TwitterRequest = _twitter.oauth_accessToken(pin);
				MonsterDebugger.trace( this, request );
				request.addEventListener(TwitterRequestEvent.COMPLETE, _pinRequestCompleteHandler);
			}
			else
			{
				
				
				MonsterDebugger.trace( this, "DO NOTHING." );
				
				
				
			}
		}
		
		private function _pinRequestCompleteHandler(event:Event):void
		{
			
			MonsterDebugger.trace( this, "_pinRequestCompleteHandler" );
			var request:TwitterRequest = event.currentTarget as TwitterRequest;
			_token = _twitter.accessTokenSet;
			_saveSettings();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function _checkForSettings():void
		{
			
			MonsterDebugger.trace( this, "_checkForSettings" );
			var file:File = File.applicationStorageDirectory.resolvePath(fileName);
			var fileStream:FileStream = new FileStream();
			
			if(file.exists)
			{
				fileStream.open(file, FileMode.READ);
				var data:Object = fileStream.readObject() as Object;
				fileStream.close();
				MonsterDebugger.trace( this, data );
				_token = new TwitterTokenSet(consumerKey, consumerSecret, data.oauthToken, data.oauthTokenSecret);
				_mentionedSinceID = data.mentionedSinceID;
			} else
			{
				_token = null
			}
		}
		
		private function _saveSettings():void
		{
			var file:File = File.applicationStorageDirectory.resolvePath(fileName);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeObject({oauthToken: _token.oauthToken, oauthTokenSecret: _token.oauthTokenSecret, mentionedSinceID: _mentionedSinceID});
			fileStream.close();
		}
		
		public function tweet(message:String):void
		{
			MonsterDebugger.trace(this,"Tweet: " + message);
			
			var request:TwitterRequest = _twitter.statuses_update(message);
			_setHandlersForRequest(request, _tweetCompleteHandler);
		}
		
		private function _checkMentions():void
		{
			MonsterDebugger.trace(this,"check mentions");
			
			var request:TwitterRequest = _twitter.statuses_mentionsTimeline(20, _mentionedSinceID);
			_setHandlersForRequest(request, _mentionsCompleteHandler)
		}
		
		private function _mentionsCompleteHandler(event:TwitterRequestEvent):void
		{
			_mentions = new Vector.<MentionModel>;
			
			var request:TwitterRequest = event.currentTarget as TwitterRequest;
			var mentions:Array = JSON.parse(request.response as String) as Array;
			var mention:MentionModel;
			var e:TwitterControllerEvent;
			
			for (var i:int = 0; i < mentions.length; i++) 
			{
				mention = new MentionModel(mentions[i]);
				_mentions.push(mention);
				
				MonsterDebugger.trace(this,"Buddha got mention from: " + mention.screenName);
				
				e = new TwitterControllerEvent(TwitterControllerEvent.GOT_MENTION);
				e.data = mention;
				
				dispatchEvent(e);
			}
			
			if (_mentions.length)
			{
				_mentionedSinceID = MentionModel(_mentions[0]).id;
				_saveSettings();
			}
		}
		
		private function _tweetCompleteHandler(event:TwitterRequestEvent):void
		{
			MonsterDebugger.trace(this,"tweet send")
		}
		
		private function _errorHandler(event:Event):void
		{
			MonsterDebugger.trace(this,"_errorHandler");
			MonsterDebugger.trace(this,event);
			MonsterDebugger.trace(this,event.type);
			
			if (event is TwitterErrorEvent)
			{
				MonsterDebugger.trace(this,TwitterErrorEvent(event).statusCode.toString());
			}
		}
		
		private function _reset():void
		{
			_token = new TwitterTokenSet("", "", "", "");
			_saveSettings();
		}
		
		public function destroy():void
		{
			MonsterDebugger.trace( this, "destroy" );
			if (_destroyed) return;
			
			_stage = null;
			_twitter = null;
			_token = null;
			_mentions = null;
			
			if (_webView)
			{
				_webView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE, _locationChangeHandler);
				_webView.dispose();
				_webView = null;
			}
			
			if (_mentionChecker)
			{
				_mentionChecker.removeEventListener(TimerEvent.TIMER, _checkMentionsHandler);
				_mentionChecker.stop();
				_mentionChecker = null;
			}
			
			_destroyed = true;
		}
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
	}
}