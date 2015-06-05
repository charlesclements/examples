package com.imt.framework.gadget.ios.gamecenter
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.fatbird.framework.core.event.SiteEvent;
	import com.fatbird.utils.NumberFormater;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.core.event.SiteEvent;
	import com.imt.framework.event.StarlingSiteEvent;
	import com.milkmangames.nativeextensions.ios.GCAchievementData;
	import com.milkmangames.nativeextensions.ios.GCAchievementProgress;
	import com.milkmangames.nativeextensions.ios.GCLeaderboardData;
	import com.milkmangames.nativeextensions.ios.GCPlayerData;
	import com.milkmangames.nativeextensions.ios.GCPlayerScope;
	import com.milkmangames.nativeextensions.ios.GCScoreData;
	import com.milkmangames.nativeextensions.ios.GCTimeScope;
	import com.milkmangames.nativeextensions.ios.GameCenter;
	import com.milkmangames.nativeextensions.ios.events.GameCenterErrorEvent;
	import com.milkmangames.nativeextensions.ios.events.GameCenterEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	/** GameCenterGadget App */
	public class GameCenterGadget extends Sprite
	{
		
		//
		// Definitions
		//
		
		/** Leaderboard ID
		 * 
		 * This needs to exactly match a leaderboard you created in iTunes Connect!
		 * */
		private static var leaderboardPath:String="";
		private static var LEADERBOARD_ID:String="";
		
		/** Achievement ID 
		 * 
		 * Must exactly match an achievement you created in iTunes Connect!
		 * 
		 * */
		//private static const ACHIEVEMENT_ID:String="LeaderStage1";
		private static const ACHIEVEMENT_ID:String="LeaderStage1";
	
		//
		// Instance Variables
		//
		
		/** Status */
		private var txtStatus:TextField;
		
		/** Buttons */
		private var buttonContainer:Sprite;
		
		/** Score */
		private var score:int;
		private var time:String;
		
		/** Score TextField */
		private var txtScore:TextField;
		
		/** Shared Object */
		private var sharedObject:SharedObject;
		
		// Used to check against 
		private var isAIR:Boolean;
		
		//
		// Public Methods
		//
		
		/** Create New GameCenterGadget */
		public function GameCenterGadget() 
		{		
			
			trace( "GameCenterGadget" );
			
		}
	
		
		/** Init */
		public function initialize(data:Object=null):void
		{
			
			// Created before everything so the components can be used.
			createUI();
			//loadScore();// This gets called later when the Stages refresh method gets called.
			// Events
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NEW_TIME, onStarlingEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.NEW_BEST_TIME, onStarlingEvent );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.CLEAR_SCORE, onStarlingEvent);
			StarlingDispatcher.addEventListener( StarlingSiteEvent.UPDATE_STAGE, onStarlingEvent);
			StarlingDispatcher.addEventListener( StarlingSiteEvent.SHOW_GAMECENTER_UI, onStarlingEvent);
			// Check if this is AIR.
			try{ isAIR = data.isAIR || false }
			catch( e:Error ){ trace( e ) }
			// Get path to leaderboard.
			try{ leaderboardPath = data.leaderboardPath || "" }
			catch( e:Error ){ trace( e ) }
			// Do gamecenter stuff if available
			if( isAIR == false ){ return }
			else callGameCenterStuff();
			
		}
		
		
		private function callGameCenterStuff():void
		{
			
			trace("callGameCenterStuff");
			
			if (!GameCenter.isSupported())
			{
				log("GameCenter is not supported on this platform.");
				//removeChild(buttonContainer);
				return;
			}
			
			log("initializing GameCenter...");	
			
			
			/*
			//
			try{ GameCenter.create(stage) }
			catch( e:Error )
			{
				
				trace(e)
				trace("Make sure that Flash is correctly linking to the ANE file.")
				
			}
			*/
			
			GameCenter.create(stage)
				
			
			if (!GameCenter.gameCenter.isGameCenterAvailable())
			{
				log("GameCenter is not available.");
				removeChild(buttonContainer);
				return;
			}
			else
			{
				
				log("GameCenter AVAILABLE!!");
				
			}
			
			log("GameCenter Initialized.");
			
			log("Checking os level support...");
			// GameCenter doesn't work on iOS versions < 4.1, so always check this first!
			if (!GameCenter.gameCenter.isGameCenterAvailable())
			{
				log("this ios version doesn't have gameCenter.");
				removeChild(buttonContainer);
				return;
			} 
			
			log("Game Center is ready.");
			
			// ios5.0+ can show achievement notifications in the native UI.  
			if (GameCenter.gameCenter.areBannersAvailable())
			{
				GameCenter.gameCenter.showAchievementBanners(true);
			}
			// this is the complete suite of supported events.  you may not need to listen to all of them for your app,
			// however you should always listen for at least the 'failed' error events to avoid your app throwing errors.
			GameCenter.gameCenter.addEventListener(GameCenterEvent.AUTH_SUCCEEDED,onAuthSucceeded);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.AUTH_FAILED,onAuthFailed);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENTS_VIEW_OPENED,onViewOpened);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENTS_VIEW_CLOSED,onViewClosed);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_OPENED,onViewOpened);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_CLOSED,onViewClosed);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_REPORT_SUCCEEDED,onAchievementReported);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_RESET_SUCCEEDED,onAchievementReset);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.SCORE_REPORT_SUCCEEDED,onScoreReported);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.SCORE_REPORT_FAILED,onScoreFailed);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_REPORT_FAILED,onAchievementFailed);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_RESET_FAILED,onResetFailed);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.FRIEND_REQUEST_VIEW_OPENED,onViewOpened);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.FRIEND_REQUEST_VIEW_CLOSED,onViewClosed);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.CHALLENGE_VIEW_OPENED,onViewOpened);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.CHALLENGE_VIEW_CLOSED,onViewClosed);		
			GameCenter.gameCenter.addEventListener(GameCenterEvent.FRIEND_REQUEST_VIEW_CLOSED,onViewClosed);
			
			GameCenter.gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_DATA_LOADED,onLeaderboardData);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_DATA_LOADED,onAchievementData);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.PLAYER_DATA_LOADED,onPlayerData);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.SCORES_LOADED,onScoresLoaded);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_PROGRESS_LOADED,onAchievementProgress);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.FRIENDS_LOADED,onFriendsLoaded);
			
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_DATA_FAILED,onDataError);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_PROGRESS_FAILED,onDataError);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.LEADERBOARD_DATA_FAILED,onDataError);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.FRIENDS_FAILED,onDataError);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.SCORES_FAILED,onDataError);
			GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.PLAYER_DATA_FAILED, onDataError);
			
			GameCenter.gameCenter.addEventListener(GameCenterEvent.CHALLENGE_RECEIVED, onChallengeEvent);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.CHALLENGE_SELECTED, onChallengeEvent);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.LOCAL_CHALLENGE_COMPLETED, onChallengeEvent);
			GameCenter.gameCenter.addEventListener(GameCenterEvent.REMOTE_CHALLENGE_COMPLETED, onChallengeEvent);
			
			
			authenticateUser();
			
			//createUI()
			
			
		}
		
		
		
		
		
		
		
		private function onStarlingEvent(event:StarlingSiteEvent):void
		{
			
			trace("");
			trace("GameCenterGadget : onStarlingEvent: " + event.type);
			log( event.type ); 
			switch( event.type )
			{
				
				case StarlingSiteEvent.UPDATE_STAGE:
					var name:String = "";
					try
					{
						
						LEADERBOARD_ID = name = event.data.name;
						//LEADERBOARD_ID = leaderboardPath + "." + event.data.name;
						
						log( LEADERBOARD_ID ); 
						
						
					}
					catch(e:Error){ throw( "Make sure that you pass in a name in the data object in the refresh() method of each Stage." ) };
					loadScore();
					break;
				
				case StarlingSiteEvent.CLEAR_SCORE:
					sharedObject.clear();
					break;
				
				case StarlingSiteEvent.NEW_TIME:
					trace(event.data.time);
					trace("-");
					this.score = event.data.time;
					trace("-");
					//this.time = com.fatbird.utils.NumberFormater.formatTime( event.data.time );
					this.time = com.fatbird.utils.NumberFormater.formatTime( this.score, ":", false, true, true, true );
					
					trace("-");
					saveScore();
					trace("-");
					loadScore();
					trace("-");
					break;
				
				case StarlingSiteEvent.NEW_BEST_TIME:
					
					
					// Would you like to submit your score to GameCenter?
					
					//if( isAIR ) 
					
					
					
					
					
					break;
				
				case StarlingSiteEvent.SHOW_GAMECENTER_UI:
					
					showAuthUI();
					
					break;
				
			}
			
		}
		
		
		
		
		/** Authenticate Local User */
		public function authenticateUser():void
		{
			log("try auth user." + String( GameCenter.gameCenter.isGameCenterAvailable() ) );
			log( String( GameCenter.gameCenter.isGameCenterAvailable() ) );
			
			
			
			GameCenter.gameCenter.authenticateLocalUser();
			log("waiting for auth...");
		}
		
		
		/** For iOS 6+, authenticate the user, but don't show the login dialog until later */
		public function authenticateUserDeferred():void
		{
			log("Deferred auth...");
			GameCenter.gameCenter.authenticateLocalUser(true);
			log("Waiting for show ui...");
		}
		
		
		/** For iOS 6+, show a deferred login UI after a call to authenticateLocalUser(true) */
		public function showDeferredAuthUI():void
		{
			log("Showing auth ui...");
			var result:Boolean=GameCenter.gameCenter.showDeferredAuthUI();
			if (!result)
			{
				log("Deferred auth ui not available!");
				return;
			}
			log("waiting for auth...");
		}
		
		/** Increase local score */
		public function increaseScore():void
		{
			this.score++;
			this.txtScore.text="Score: "+this.score;
			log("Score is now: "+this.score);
			saveScore();
		}
		
		/** Report score */
		public function reportScore():void
		{
			// we make sure you're logged in before bothering to report the score.
			// later iOS versions may take care of waiting/resubmitting for you, but earlier ones won't.
			if (!checkAuthentication()) return;
			GameCenter.gameCenter.reportScoreForCategory(this.score,LEADERBOARD_ID);
		}
		
		/** Report Achievement */
		public function reportAchievement():void
		{
			if (!checkAuthentication()) return;
			
			// the '1.0' is a float (Number) value from 0.0-100.0 the percent completion of the achievement.
			GameCenter.gameCenter.reportAchievement(ACHIEVEMENT_ID,100.0);
		}
		
		/** Show Leaderboards */
		public function showLeaderboard():void
		{
			if (!checkAuthentication()) return;
			GameCenter.gameCenter.showLeaderboardForCategory(LEADERBOARD_ID,GCTimeScope.TODAY);
		}
		
		/** Show Achievements */
		public function showAchievements():void
		{
			if (!checkAuthentication()) return;
			
			log("showing achievements...");
			GameCenter.gameCenter.showAchievements();
			log("showed achievements");		
		}
	
		/* Show Challenges */
		public function showChallenges():void
		{
			if(!checkAuthentication()) return;
	
			if(!GameCenter.gameCenter.areChallengesAvailable())
			{
				log("Challenges requires ios6.");
				return;
			}
	
			log("showing challenge view...");
			GameCenter.gameCenter.showChallenger();
			log("did show challenge view.");
		}
		
		/** Invite Friends */
		public function inviteFriends():void
		{
			if (!checkAuthentication()) return;
			
			log("inviting friends...");
			var friendList:Vector.<String>=new <String>["bob@aol.com","jane@doe.net"];
			GameCenter.gameCenter.inviteFriends(friendList);
			log("did invite friends.");
		}
		
		/** Reset Achievements */
		public function resetAchievements():void
		{
			if (!checkAuthentication()) return;
			
			GameCenter.gameCenter.resetAchievements();
		}
		
		/** Load Leaderboard Data */
		public function loadLeaderboardData():void
		{
			log("loading leaderboard data...");
			GameCenter.gameCenter.loadLeaderboardData();
		}
		
		/** Load My Player Data */
		public function loadMyPlayerData():void
		{
			if (!checkAuthentication()) return;
			var myId:String=GameCenter.gameCenter.getPlayerID();
			log("Loading player data for self...("+myId+")...");
			var playerIds:Vector.<String>=new Vector.<String>();
			playerIds.push(myId);
			GameCenter.gameCenter.loadPlayerData(playerIds);
		}
		
		/** Load Score Data */
		public function loadScoreData():void
		{
			log("loading scores for category "+LEADERBOARD_ID+"...");
			GameCenter.gameCenter.loadScoresForCategory(LEADERBOARD_ID,GCPlayerScope.GLOBAL,GCTimeScope.ALL_TIME,1,100);
		}
		
		/** Load Achievement Progress */
		public function loadAchievementProgress():void
		{
			log("Loading my achievement progress...");
			GameCenter.gameCenter.loadAchievementProgress();
		}
		
		/** Load my friends */
		public function loadFriends():void
		{
			log("Loading my friends...");
			GameCenter.gameCenter.loadFriends();
		}
		
		/** Load Achievement Data */
		public function loadAchievementData():void
		{
			log("Loading achievement data...");
			GameCenter.gameCenter.loadAchievementData();
		}
	
		//
		// Events
		//
		
		private var inCount:int=0;
		private var outCount:int=0;
		
		/** Login succeeded */
		private function onAuthSucceeded(e:GameCenterEvent):void
		{
			log("Auth succeeded!");
			showFullUI();
			inCount++;
			var inOut:String="["+inCount+"/"+outCount+"] ";
			log(inOut+"auth player:"+GameCenter.gameCenter.getPlayerAlias()+"="+GameCenter.gameCenter.getPlayerID()+",underage?"+GameCenter.gameCenter.isPlayerUnderage());
			
			
			log( GameCenter.gameCenter.getPlayerID() );
			
			//var v:Vector.<String> = new Vector.<String>();
			//v[ 0 ] = GameCenter.gameCenter.getPlayerID();
			
			log( GameCenter.gameCenter.getPlayerID() );
			
			//GameCenter.gameCenter.loadPlayerData( v )
			
			log( GameCenter.gameCenter.getPlayerAlias());
			//log( GameCenter.gameCenter.);
			
			
			//new Vector
			
			
			
			
			
		}
		
		/** Login Failed */
		private function onAuthFailed(e:GameCenterErrorEvent):void
		{
			outCount++;
			var inOut:String="["+inCount+"/"+outCount+"] ";
			log(inOut+"Auth failed:"+e.message);
			showAuthUI();
		}
		
		/** View Opened */
		private function onViewOpened(e:GameCenterEvent):void
		{
			log("gamecenter view opened.");
		}
		
		/** View Closed */
		private function onViewClosed(e:GameCenterEvent):void
		{
			log("gamecenter view closed.");
		}
		
		/** Achievement Reported */
		private function onAchievementReported(e:GameCenterEvent):void
		{
			log("achievement report success:"+e.achievementID);
		}
		
		/** Achievement Failed */
		private function onAchievementFailed(e:GameCenterErrorEvent):void
		{
			log("achievement report failed:msg="+e.message+",cd="+e.errorID+",ach="+e.achievementID);
		}
		
		/** Score Reported */
		private function onScoreReported(e:GameCenterEvent):void
		{
			log("score report success:"+e.score+"/"+e.category);
		}
		
		/** Score Failed */
		private function onScoreFailed(e:GameCenterErrorEvent):void
		{
			log("score report failed:msg="+e.message+",cd="+e.errorID+",scr="+e.score+",cat="+e.category);
		}
		
		/** Achievements Reset */
		private function onAchievementReset(e:GameCenterEvent):void
		{
			log("achievements reset.");
			this.score=0;
			saveScore();
			this.txtScore.text="Score: "+score;
		}
		
		/** Achievement Reset Failed */
		private function onResetFailed(e:GameCenterErrorEvent):void
		{
			log("failed to reset:"+e.message);
		}
	
		/** Data Load Error */
		private function onDataError(e:GameCenterErrorEvent):void
		{
			log(e.type+":"+e.message+"/"+e.errorID);
		}
		
		/** Achievement Progress Loaded */
		private function onAchievementProgress(e:GameCenterEvent):void
		{
			var count:int=e.achievementProgresses.length;
			var firstData:GCAchievementProgress;
			if (count>0)
			{
				firstData=e.achievementProgresses[0];
			}
			log("ap datas: "+count+",0="+firstData);		
		}
		
		/** Achievements Data Loaded */
		private function onAchievementData(e:GameCenterEvent):void
		{
			var count:int=e.achievementDatas.length;
			var firstData:GCAchievementData;
			if (count>0)
			{
				firstData=e.achievementDatas[0];
			}
			log("ach datas: "+count+",0="+firstData);			
		}
		
		/** On Friends Loaded */
		private function onFriendsLoaded(e:GameCenterEvent):void
		{
			log("friends loaded...");
			log("Friends: ["+e.friendIds.length+"]"+e.friendIds.join(","));
		}
			
		/** Leaderboard Data Loaded */
		private function onLeaderboardData(e:GameCenterEvent):void
		{
			log("lboards:"+e.leaderboardDatas);
			var count:int=e.leaderboardDatas.length;
			var firstData:GCLeaderboardData;
			if (count>0)
			{
				firstData=e.leaderboardDatas[0];
			}
			log("lb datas: "+count+",0="+firstData);
		}
		
		/** Player Data Loaded */
		private function onPlayerData(e:GameCenterEvent):void
		{
			var count:int=e.playerDatas.length;
			var firstData:GCPlayerData;
			if (count>0)
			{
				firstData=e.playerDatas[0];
			}
			log("player datas: "+count+",0="+firstData);
		}
		
		/** Scores Loaded */
		private function onScoresLoaded(e:GameCenterEvent):void
		{
			var count:int=e.scoreDatas.length;
			var firstData:GCScoreData;
			if (count>0)
			{
				firstData=e.scoreDatas[0];
			}
			log("score datas: "+count+",0="+firstData);
		}
		
		/** Challenge Event Update */
		private function onChallengeEvent(e:GameCenterEvent):void
		{
			log(e.type+": from "+e.challengeInfo.issuerId+"->"+e.challengeInfo.receiverId
				+" on "+e.challengeInfo.issueDate+", '"+e.challengeInfo.message
				+"', complete: "+e.challengeInfo.completionDate
				+" ["+e.challengeInfo.scoreValue+"/"+e.challengeInfo.achievementId+"]");
		}
		
		//
		// Impelementation
		//
		
	
		/** Log */
		private function log(msg:String):void
		{
			trace("[GameCenterGadget] "+msg);
			//txtStatus.text=msg;
			
			
			txtStatus.appendText( "\n" + String( msg ) );
			//txtStatus.appendText( String( msg ) );
			
		}
		
		
		/** Load Score */
		private function loadScore():void
		{
			
			trace("loadScore");
			//sharedObject=SharedObject.getLocal("airgc");
			//var s:String = "com.imt.neo.games.match-and-fly." + LEADERBOARD_ID;
			var s:String = leaderboardPath + "." + LEADERBOARD_ID;
			//var s:String = LEADERBOARD_ID;
			trace(s);
			log("loadScore : " + s);
			sharedObject=SharedObject.getLocal( s );
			//this.score=sharedObject.data["score"]||0;
			this.score=sharedObject.data[ LEADERBOARD_ID + "." + "score" ] || 0;
			this.time = String( sharedObject.data[ LEADERBOARD_ID + "." + "time" ] ) || com.fatbird.utils.NumberFormater.formatTime( 0 );;
			
			
			
			StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.SCORE_LOADED, { score:score, time:time } ) );
			
		}
		
		
		/** Save Score */
		private function saveScore():void
		{

			trace("-");
			
			
			
			
			log("saveScore : " + this.score);
			
			try
			{
				var s:int = sharedObject.data[ LEADERBOARD_ID + "." + "score" ] || 9999999;
				if( score < s )
				{
					
					
					
					trace ("NEW HIGH SCORE");
					log("New high score");
					sharedObject.data[ LEADERBOARD_ID + "." + "score" ] = score;
					sharedObject.data[ LEADERBOARD_ID + "." + "time" ] = time;
					sharedObject.flush();
					
					//com.imt.framework.core.dispatcher.StarlingDispatcher
					StarlingDispatcher.dispatchEvent( new StarlingSiteEvent( StarlingSiteEvent.NEW_BEST_TIME ) );
			
			
			/*
			
					
					
					//log("saveScore : " + this.score);
					
					// Ask about GameCenter here?
				
					//if( isAIR ) GameCenter.gameCenter.loadScoresForCategory( LEADERBOARD_ID );
					
						
						
						
					
					
					
					
					
					*/
					
				}
			}
			catch(e:Error)
			{
				
				trace ("NO GAME CENTER");
				
				
				
			}
			
			
			
			
			
			
		}
		
		/** Check Authentication */
		private function checkAuthentication():Boolean
		{
			if (!GameCenter.gameCenter.isUserAuthenticated())
			{
				log("not logged in!");
				return false;
			}
			return true;
		}
		
		/** Create UI */
		public function createUI():void
		{
			
			trace(this + " : createUI");
			
			//log( "createUI" );
			//log( "-" );
			//trace("-");
			
			
			txtStatus=new TextField();
			txtStatus.defaultTextFormat=new flash.text.TextFormat("Arial",15);
			txtStatus.x = 500;//stage.stageWidth;
			txtStatus.width = 330;//stage.stageWidth;
			txtStatus.multiline=true;
			txtStatus.border = true;
			txtStatus.autoSize = TextFieldAutoSize.LEFT;
			txtStatus.background = true;
			txtStatus.wordWrap=true;
			txtStatus.text="Ready";
			addChild(txtStatus);
			//trace("-");
			
			txtScore=new TextField();
			txtScore.defaultTextFormat=new flash.text.TextFormat("Arial",30);
			txtScore.width=stage.stageWidth;
			txtScore.height=30;
			txtScore.multiline=false;
			txtScore.text="Score: "+score;
			txtScore.y=stage.stageHeight-txtScore.height;
			addChild(txtScore);
			
			//trace("-");
			showAuthUI();
			
		}
		
		/** Show an 'authorize user' button only (not logged in) */
		public function showAuthUI():void
		{
			
			trace(this + " : showAuthUI()");
			
			if (buttonContainer)
			{
				removeChild(buttonContainer);
				buttonContainer=null;
			}
			
			buttonContainer=new Sprite();
			buttonContainer.y=txtStatus.height;
			addChild(buttonContainer);
			var uiRect:Rectangle=new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			var layout:ButtonLayout=new ButtonLayout(uiRect,14);
			layout.addButton(new SimpleButton(new Command("Authenticate User", authenticateUser)));
			layout.addButton(new SimpleButton(new Command("Auth User Deferred", authenticateUserDeferred)));
			layout.addButton(new SimpleButton(new Command("Show Deferred Auth UI", showDeferredAuthUI)));
			layout.attach(buttonContainer);
			layout.layout();
			
			
			
		}
		
		/** Show full UI Options (is logged in) */
		public function showFullUI():void
		{
			if (buttonContainer)
			{
				removeChild(buttonContainer);
				buttonContainer=null;
			}
			
			buttonContainer=new Sprite();
			buttonContainer.y=txtStatus.height;
			addChild(buttonContainer);
			
			var uiRect:Rectangle=new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			var layout:ButtonLayout=new ButtonLayout(uiRect,14);
			layout.addButton(new SimpleButton(new Command("Increase score",increaseScore)));
			layout.addButton(new SimpleButton(new Command("Report Score", reportScore)));
			layout.addButton(new SimpleButton(new Command("Report Achievement",reportAchievement)));
			layout.addButton(new SimpleButton(new Command("Show Leaderboard",showLeaderboard)));
			layout.addButton(new SimpleButton(new Command("Show Achievements",showAchievements)));
			layout.addButton(new SimpleButton(new Command("Reset Achievements",resetAchievements)));
			layout.addButton(new SimpleButton(new Command("Show Challenges",showChallenges)));
			layout.addButton(new SimpleButton(new Command("Invite Friends",inviteFriends)));
			layout.addButton(new SimpleButton(new Command("Load Friends",loadFriends)));
			layout.addButton(new SimpleButton(new Command("Load LB Data",loadLeaderboardData)));
			layout.addButton(new SimpleButton(new Command("Load Scores",loadScoreData)));
			layout.addButton(new SimpleButton(new Command("Load Progress",loadAchievementProgress)));
			layout.addButton(new SimpleButton(new Command("Load PlayerData",loadMyPlayerData)));
			layout.addButton(new SimpleButton(new Command("Load ACH Data",loadAchievementData)));
	
			layout.attach(buttonContainer);
			layout.layout();	
		}
		
		
	}
}

//
// Code Below is generic code for building UI
//


import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/** Simple Button */
class SimpleButton extends Sprite
{
	//
	// Instance Variables
	//
	
	/** Command */
	private var cmd:Command;
	
	/** Width */
	private var _width:Number;
	
	/** Label */
	private var txtLabel:TextField;
	
	//
	// Public Methods
	//
	
	/** Create New SimpleButton */
	public function SimpleButton(cmd:Command)
	{
		super();
		this.cmd=cmd;
		
		mouseChildren=false;
		mouseEnabled=buttonMode=useHandCursor=true;
		
		txtLabel=new TextField();
		txtLabel.defaultTextFormat=new TextFormat("Arial",24,0xFFFFFF);
		txtLabel.mouseEnabled=txtLabel.mouseEnabled=txtLabel.selectable=false;
		txtLabel.text=cmd.getLabel();
		txtLabel.autoSize=TextFieldAutoSize.LEFT;
		
		redraw();
		
		addEventListener(MouseEvent.CLICK,onSelect);
	}
	
	/** Set Width */
	override public function set width(val:Number):void
	{
		this._width=val;
		redraw();
	}

	
	/** Dispose */
	public function dispose():void
	{
		removeEventListener(MouseEvent.CLICK,onSelect);
	}
	
	//
	// Events
	//
	
	/** On Press */
	private function onSelect(e:MouseEvent):void
	{
		this.cmd.execute();
	}
	
	//
	// Implementation
	//
	
	/** Redraw */
	private function redraw():void
	{		
		txtLabel.text=cmd.getLabel();
		_width = 300;//_width||txtLabel.width*1.1;
		
		graphics.clear();
		graphics.beginFill(0x444444);
		graphics.lineStyle(2,0);
		graphics.drawRoundRect(0,0,_width,txtLabel.height*1.1,txtLabel.height*.4);
		graphics.endFill();
		
		txtLabel.x= _width/2-(txtLabel.width/2);
		txtLabel.y=txtLabel.height*.05;
		addChild(txtLabel);
	}
}

/** Button Layout */
class ButtonLayout
{
	private var buttons:Array;
	private var rect:Rectangle;
	private var padding:Number;
	private var parent:DisplayObjectContainer;
	
	public function ButtonLayout(rect:Rectangle,padding:Number)
	{
		this.rect=rect;
		this.padding=padding;
		this.buttons=new Array();
	}
	
	public function addButton(btn:SimpleButton):uint
	{
		return buttons.push(btn);
	}
	
	public function attach(parent:DisplayObjectContainer):void
	{
		this.parent=parent;
		for each(var btn:SimpleButton in this.buttons)
		{
			parent.addChild(btn);
		}
	}
	
	public function layout():void
	{
		var btnX:Number=rect.x+padding;
		var btnY:Number=rect.y;
		for each( var btn:SimpleButton in this.buttons)
		{
			btn.width=rect.width-(padding*2);
			btnY+=this.padding;
			btn.x=btnX;
			btn.y=btnY;
			btnY+=btn.height;
		}
	}
}


/** Inline Command */
class Command
{
	/** Callback Method */
	private var fnCallback:Function;
	
	/** Label */
	private var label:String;
	
	//
	// Public Methods
	//
	
	/** Create New Command */
	public function Command(label:String,fnCallback:Function)
	{
		this.fnCallback=fnCallback;
		this.label=label;
	}
	
	//
	// Command Implementation
	//
	
	/** Get Label */
	public function getLabel():String
	{
		return label;
	}
	
	/** Execute */
	public function execute():void
	{
		fnCallback();
	}
}





