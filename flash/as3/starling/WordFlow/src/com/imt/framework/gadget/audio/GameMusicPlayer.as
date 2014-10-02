package com.imt.framework.gadget.audio
{
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.plugin.storage.SuperArray;
	import com.imt.framework.core.event.SiteEvent;
	
	import flash.events.Event;
	
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaPlayer;
	
	public class GameMusicPlayer extends MediaPlayer
	{
		
		
		
		private var arrMusic:SuperArray
		
		
		
		public function GameMusicPlayer(media:MediaElement=null)
		{
			super(media);
		}
		
		
		public function initilize($array:Array):void
		{
			
			
			
			// Background music player.
			//_musicPlayer = new MediaPlayer();
			//loop = true;
			//_musicPlayer.volume = _sounds[ SiteData.MUSIC ].volume;
			BedrockDispatcher.addEventListener( SiteEvent.PLAY_NEXT_AUDIO_TRACK, onEvent );
			addEventListener( TimeEvent.COMPLETE, onEvent);
			arrMusic = new SuperArray( $array );
			arrMusic.wrapIndex = true;
			autoPlay = true;
			doPlay();
			
		}
		
		
		
		public function next():void
		{
			
			arrMusic.selectNext();
			doPlay();
			
		}
		
		
		public function doPlay():void
		{
			
			trace("doPlay")
			media = arrMusic.getSelected().media;
			volume = arrMusic.getSelected().volume;
			
			
		}

		private function onEvent(event:Event):void
		{
			
			trace(this + " : " + event.type )
			
			switch( event.type )
			{
				
				case TimeEvent.COMPLETE:
					arrMusic.selectNext();
					doPlay();
					break;
				
				case SiteEvent.PLAY_NEXT_AUDIO_TRACK:
					next();
					break;
				
			}
			
		}
		
	}
}