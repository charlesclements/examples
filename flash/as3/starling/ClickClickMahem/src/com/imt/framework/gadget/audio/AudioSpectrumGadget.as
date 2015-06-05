package com.imt.framework.gadget.audio
{
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.plugin.view.SpriteView;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.core.event.SiteEvent;
	import com.imt.framework.engine.data.GameData;
	
	import flash.events.Event;
	
	import org.osmf.elements.AudioElement;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.URLResource;
	
	public class AudioSpectrumGadget extends SpriteView implements IDisplay
	{
		
		
		
		private var _audio:AudioElement;
		private var _audioPlayer:MediaPlayer;
		
		
		
		
		public function AudioSpectrumGadget()
		{
			super();
		}
		
		
		// 
		public function initialize():IDisplay
		{
			
			// Audio
			_audio = new AudioElement();
			_audioPlayer = new MediaPlayer();
			//_audioPlayer.addEventListener( MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, onEvent );
			_audioPlayer.addEventListener( TimeEvent.COMPLETE, onEvent );
			//_audioPlayer.volume = Number( GameData.VIDEO_XML..site.music.@vol );
			_audioPlayer.media = _audio; 
			//_musicPlayer.loop = true;
			
			return this;
			
		}
		
		
		// Refresh class properties.
		public function refresh():IDisplay
		{
			
			trace(this + " : refresh()" );
			
			//BedrockDispatcher.addEventListener( SiteEvent.SELECTION, onEvent );
			
			// BG music
			_audio.resource = new URLResource( GameData.GAME_XML..game.( @id == GameData.CODE ).audio.@url );
			
			
			
			
			//trace( GameData.VIDEO_XML..game.( @id == GameData.CODE ).audio.@url );
			
			
			
			return this;
			
		}
		
		
		// Refresh class properties.
		public function clear():IDisplay
		{
			trace(this + " : clear()" );
			
			//BedrockDispatcher.removeEventListener( SiteEvent.SELECTION, onEvent );
			return this;
			
		}
		
		
		
		
		private function onEvent(e:Event):void
		{
			//trace(this + " : " + e.type )
			
			switch( e.type )
			{
				
				case MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE:
					
					trace(this + " : " + e.type );
					
					
					
					//_container.changePanel( _audioSpectrum.refresh() );
					break;
				
				
				case TimeEvent.COMPLETE:
					
					trace(this + " : " + e.type );
					
					BedrockDispatcher.dispatchEvent( new SiteEvent( SiteEvent.SHOW_PRIZE, this, {} ) );
					
					//_container.changePanel( _audioSpectrum.refresh() );
					break;
				
				
			}
			
			
			/*
			var page:String;
			
			switch( e.currentTarget )
			{
			
			case mcPavilion:
			page = SiteData.PAVILION
			break;
			
			case mcPlayersClub:
			page = SiteData.PLAYERS_CLUB;
			break;
			
			case mcFreshHarvest:
			page = SiteData.FRESH_HARVEST;
			break;
			
			}
			
			BedrockDispatcher.dispatchEvent( new SiteEvent( SiteEvent.CHANGE, this, { page:page } ));
			*/
		}
		
		
		
		
	}
	
}