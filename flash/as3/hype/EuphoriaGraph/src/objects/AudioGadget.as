package com.yr.tracknames.gadgets
{
	
	// Imports
	import com.bedrock.extras.util.StringUtil;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	import com.noteflight.standingwave3.elements.AudioDescriptor;
	import com.noteflight.standingwave3.elements.IAudioSource;
	import com.noteflight.standingwave3.elements.Sample;
	import com.noteflight.standingwave3.generators.SoundGenerator;
	import com.noteflight.standingwave3.output.AudioPlayer;
	import com.noteflight.standingwave3.performance.AudioPerformer;
	import com.noteflight.standingwave3.performance.ListPerformance;
	import com.noteflight.standingwave3.performance.PerformableAudioSource;
	import com.noteflight.standingwave3.sources.LoopSource;
	import com.noteflight.standingwave3.sources.SineSource;
	import com.yr.tracknames.dispatcher.Dispatcher;
	import com.yr.tracknames.event.AppEvent;
	import com.yr.tracknames.model.AppModel;
	
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import fr.kikko.lab.ShineMP3Encoder;
	
	import hype.framework.sound.SoundAnalyzer;
	
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	
	public class AudioGadget extends Sprite
	{
		
		
		// Variables.
		private var _sounds:Array = [];
		private var _loopTimer:TweenMax = new TweenMax( {}, 0, {} );
		private var _loopTime:Number = 10 * 0.996;//0.9985;
		private var _text:String = "";
		private var _textArray:Array = [];
		private var _output:Sound;
		private var _outputChannel:SoundChannel;
		public var soundAnalyzer:SoundAnalyzer;
		private var _recordedBytes:ByteArray;
		private var _mp3Encoder:ShineMP3Encoder;
		public var multiplierCap:uint = 3;
		private var file:FileReference;
		
		// New Audio stuff.
		private var sequence:ListPerformance;
		private var player:AudioPlayer;
		private var source:IAudioSource;
		private var mainLoopingSample:Sample;
		private var initSoundLoaded:Boolean = false;
		private var mainLength:uint;
		
		
		
		// Constructor.
		public function AudioGadget()
		{
			
			super();
			
		}
		
		
		// Initialize.
		public function initialize(data:Object):void
		{
			
			// SoundAnalyzer stuff.
			soundAnalyzer = new SoundAnalyzer();
			soundAnalyzer.start();
			
			
			
			//mainLoopingSample = new Sample( new AudioDescriptor,
			
			
			
			// Listeners.
			Dispatcher.addEventListener( AppEvent.TEXT_TO_DISPLAY_CHANGED, onTextToDisplayChanged );
			
		}
		
		
		private function onTextToDisplayChanged(event:Event):void
		{
			
			//trace("AudioGadget onTextToDisplayChanged");
			change( AppModel.TEXT_TO_DISPLAY );
			
		}
		
		
		private function onTryAgain(event:LoaderEvent):void
		{
			
			//trace("AudioGadget onTryAgain");
			stop();
			play();
			
		}
		
		
		// Play sounds.
		public function play(e:MouseEvent=null):void 
		{
			
			trace("AudioGadget play");
			//_loopTimer = new TweenMax( {}, _loopTime, { onComplete:play } );
			var group:LoaderMax = LoaderMax.getLoader( "audioQueue" );
			
			
			// SW3 audio stuff.
			sequence = new ListPerformance;
			player = new AudioPlayer;
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			//new SineSource(new AudioDescriptor(),
			
			
			
			
			var initDelay:Number = 0;//0.5;
			
			

			var mp3:MP3Loader;
			for( var i:uint = 0; i < _textArray.length; i++ )
			{
				
				mp3 = ( !group.getContent( _textArray[ i ] ) ) ? group.getLoader( "default" ) : group.getLoader( _textArray[ i ] );
				//if( mp3.bytesLoaded > 0 ) mp3.gotoSoundTime( 0, true );
				if( mp3.bytesLoaded > 0 )
				{
					
					// Add sample to sequence here.
					//sequence.addSourceAt( initDelay, mp3.vars.loop );
					
					
					mainLoopingSample.mixIn( mp3.vars.sample );
					
				}
				
			}
			
			
			sequence.addSourceAt( 0, mainLoopingSample );
			
			
			
			// Play sequence here?
			
			
			
			source = new AudioPerformer( sequence, new AudioDescriptor );
			//source = new AudioPerformer( new PerformableAudioSource( 0, mainLoopingSample ), new AudioDescriptor );
			player.play( source );
			
			
			
			
			
		}
		
		
		private function soundError(e:LoaderEvent):void
		{
			
			trace("AudioGadget soundError");
			MonsterDebugger.trace( this, e );
			
		}
		
		
		private function soundLoaded(e:LoaderEvent):void
		{
			
			//MonsterDebugger.trace( this, "soundLoaded" );
			//MonsterDebugger.trace( this, mp3, "AudioGadget", "soundLoaded" );
			
			
			trace("");
			trace("soundLoaded");
			
			
			// Get MP3Loader as var.
			var mp3:MP3Loader = e.currentTarget as MP3Loader;
			
			
			
			
			//var sample:Sample = new Sample(
			
			
			
			var s:Sound = mp3.content as Sound;
			//var l:Number = s.length * 44.1;
			
			if( !initSoundLoaded )
			{
				
				
				mainLength =  s.length * 44.1;
				mainLoopingSample = new Sample( new AudioDescriptor(44100, 2), mainLength);
				mainLoopingSample.extractSound( s, 0, mainLength );
				
				
				
				initSoundLoaded = true;
				
			}
			
			
			
			
			
			
			
			
			
			
			
			// Apply ByteArray stuff.
			mp3.vars.bytes = new ByteArray;
			mp3.vars.left = new Number;
			mp3.vars.right = new Number;
			
			
			
			
			/*
			
			var mySound:Sound;    // the source sound
			var length:Number = mySound.length * 44.1;
			
			var mySample:Sample = new Sample( new AudioDescriptor(44100, 2), length);
			mySample.extractSound(mySound, 0, length); // now all of the Sound's data is in this Sample
			
			var myLoop:LoopSource = new LoopSource(new AudioDescriptor(44100, 2), mySample);
			myLoop.firstFrame = 123;
			myLoop.startFrame = 123;
			myLoop.endFrame = 12345;
			
			
			
			*/
			
			
			
			
			//trace(l);
			/*
			var sample:Sample = new Sample( new AudioDescriptor(44100, 2), length);
			sample.extractSound( s, 0, l );
			*/
			
			
			
			
			// do magic here.
			
			
			
			
			var sample:Sample = new Sample( new AudioDescriptor, mainLength );
			sample.normalize();
			mp3.vars.sample = sample;
			
			
			//var loop:LoopSource = new LoopSource( new AudioDescriptor, new SoundGenerator( mp3.content as Sound ) );
			var loop:LoopSource = new LoopSource( new AudioDescriptor, new SoundGenerator( s ) );
			loop.firstFrame = 0;
			loop.startFrame = 0;
			loop.endFrame = mainLength;
			//loop.endFrame = 10000;
			
			mp3.vars.loop = loop;
			
			
			
			
			/*
			// Time position to play it.
			var t:Number = _loopTimer.totalDuration() * _loopTimer.totalProgress();
			mp3.gotoSoundTime( _loopTimer.totalDuration() * _loopTimer.totalProgress(), true );
			mp3.removeEventListener( LoaderEvent.COMPLETE, soundLoaded );
			*/
			
			
			
			
			
		}
		
		
		// Stop sounds.
		public function stop(e:MouseEvent=null):void
		{
			
			//trace("AudioGadget stop");
			_loopTimer.pause();
			TweenMax.killTweensOf( _loopTimer );
			var group:LoaderMax = LoaderMax.getLoader( "audioQueue" );
			var l:MP3Loader;
			for( var i:uint = 0; i < group.getChildren().length; i++ )
			{
				
				l = group.getChildAt( i );
				if( l.bytesLoaded > 0 ) l.pauseSound();
				
			}
			
		}
		
		
		// Returns a new Array with combined multiple same alphabet characters.
		private function formatTextArray(a:Array):Array
		{
			
			//trace("AudioGadget formatTextArray : " + a );
			
			// Function variables.
			var b:Array = [];
			var joined:String = a.join();
			var l:uint = a.length;
			var letterSingle:String = "";
			var letterMulti:String = "";
			var alphabet:Array = ArrayUtil.duplicate( AppModel.ALPHABET );
			var length:uint = alphabet.length;
			
			// Runs thru all the alphabet letters.
			for( var i:uint = 0; i < length; i++ )
			{
				
				letterMulti = "";
				letterSingle = alphabet[ i ];
					
				// How many instances of the letter in the passed Array.
				var count:uint = StringUtil.countOf( joined, letterSingle );
				
				// If the letter exists even once.
				if( count > 0 ) 
				{
					
					for( var j:uint = 0; j < count; j++ )
					{
						
						//if( count < multiplierCap + 1 ) letterMulti += letterSingle;
						
						letterMulti += letterSingle;
						
						
						if( letterMulti.length >= 3 )
						{
							
							letterMulti = letterMulti.substring( 0, 3 );
							break;
							
						}
						
					}
					
					b.push( letterMulti );
					
				}
				
			}
			
			return b;
			
		}
		
		
		// The text changed.
		public function change(text:String):void 
		{
			
			
			// Condition here to double up the letters that are duplicated and triplicated.
			_textArray = formatTextArray( text.toUpperCase().split( "", text.length ) );
			
			// May want a condition / variable that sets if we always want default to play.
			_textArray.push( "default" );
			
			// Function variables
			var group:LoaderMax = LoaderMax.getLoader( "audioQueue" );
			var mp3:MP3Loader;
			var i:uint = 0;
			
			// Pause everyone not part of the text list.
			for( i = 0; i < _sounds.length; i++ )
			{
				
				mp3 = _sounds[ i ] as MP3Loader;
				if( !ArrayUtil.containsItem( _textArray, mp3.name ) ) mp3.pauseSound();
				
			}
			
			// Clear sounds, they've already been paused.
			_sounds = [];
			
			// Play sounds from text Array.
			for( i = 0; i < _textArray.length; i++ )
			{
				
				// ArrayUtil here to avoid duplicates?
				mp3 = ( !group.getContent( _textArray[ i ] ) ) ? group.getLoader( "default" ) : group.getLoader( _textArray[ i ] );
				doSoundPlaying( mp3 ); 
				
			}
			
			// Keep default going here?
			mp3 = group.getLoader( "default" ) as MP3Loader;
			doSoundPlaying( mp3 ); 
			
		}

		
		// Plays/loads a sound if it is not already existing and playing.
		private function doSoundPlaying(mp3:MP3Loader):void
		{
			
			// Check for duplicates.
			if( !ArrayUtil.containsItem( _sounds, mp3 ) ) _sounds.push( mp3 );
			else return;
			
			// Only load if file is not loaded.
			if( mp3.bytesLoaded == 0 )
			{
				
				mp3.addEventListener( LoaderEvent.COMPLETE, soundLoaded );
				mp3.pause();
				mp3.load();
				
			}
			else
			{
				
				// Time here
				var t:Number = _loopTimer.totalDuration() * _loopTimer.totalProgress();
				mp3.gotoSoundTime( _loopTimer.totalDuration() * _loopTimer.totalProgress(), true );
				
			}
			
		}
		
		
		public function bounceFinalTrack():void
		{
			
			trace("AudioGadget - bounceFinalTrack" );
			
			// Stop all the sounds playing.
			stop();
			
			TweenMax.delayedCall( 1, bounceFinalTrackDelayed );
			
		}
		
		
		public function bounceFinalTrackDelayed():void
		{
			
			trace("AudioGadget - bounceFinalTrackDelayed" );
		
			_recordedBytes = new ByteArray;
			
			// Create new sound to mix everything to.
			_output = new Sound;
			_output.addEventListener( SampleDataEvent.SAMPLE_DATA , mixAudio );
			_output.addEventListener(Event.COMPLETE, audioEvents );
			_outputChannel = _output.play( 0 );
			
			TweenMax.delayedCall( 10, stopNewSound );
			
		}
		
		
		
		
		
		private function stopNewSound():void
		{
			
			trace("stopNewSound");
			
			_outputChannel.stop();
			_recordedBytes.position = 0;
			
			
			
			trace(_recordedBytes.length);
			
			
			var loopedBytes:ByteArray = new ByteArray;
			
			
			
			
			
			
			
			for( var i:uint = 0; i < 4; i++ )
			{
				
				while( _recordedBytes.bytesAvailable )
				{
					
					loopedBytes.writeFloat( _recordedBytes.readFloat() );
					
				}
				
				_recordedBytes.position = 0;
				
				
				
				
				// Cut beginning.
				for( var j:uint = 0; j < 500000; j++ ) _recordedBytes.readFloat();
				
				
				
				//_recordedBytes.position = _recordedBytes.length * 0.01;
				
			}
			
			
			
			
			
			
			
			
			
			
			
			
			// Encode to WAV 
			var w:WaveEncoder = new WaveEncoder;
			
			// Test encoding to MP3.
			//encodeToMP3( w.encode( _recordedBytes ) );
			encodeToMP3( w.encode( loopedBytes ) );
			
			// Save as WAV.
			//new FileReference().save( w.encode( _recordedBytes ), "PopClik-TrackNames.wav")
			
		}
		
		
		private function audioEvents( e:Event ):void
		{
			
			//trace( this + " : " + e.type );
			
		}

		
		private function mixAudio( e:SampleDataEvent ):void
		{
			
			trace("mixAudio");
			
			var mp3:MP3Loader;
			var bytes:ByteArray;
			var sound:Sound;
			var left:Number;
			var right:Number;
			var newLeft:Number = 0;
			var newRight:Number = 0;
			var i:uint;
			
			// Run thru all the sounds in the _sounds Array and extract to ByteArray.
			var l:uint = _sounds.length;
			for( i = 0; i < l; i++ )
			{
				
				mp3 = _sounds[ i ] as MP3Loader;
				sound = mp3.content as Sound;
				bytes = mp3.vars.bytes as ByteArray;
				bytes.position = 0;
				
				// Extract.
				sound.extract( bytes, 8192 );
				bytes.position = 0;
				
			}
			
			// run through all the bytes/floats
			var b:int = 0;
			while( b < 8192 )
			{
				
				for( i = 0; i < l; i++ )
				{
					
					mp3 = _sounds[ i ] as MP3Loader;
					sound = mp3.content as Sound;
					bytes = mp3.vars.bytes as ByteArray;
					left = mp3.vars.left as Number;
					right = mp3.vars.right as Number;
					
					left = bytes.readFloat();  // gets "left" signal
					right = bytes.readFloat();  // gets "left" signal
					
					newLeft += left;
					newRight += right;
					
				}

				newLeft = newLeft * 0.4;//( 1 / ( l * 1.2 ) );
				newRight = newRight * 0.4;//( 1 / ( l * 1.2 ) );
				//trace("newLeft "+newLeft);
				
				// Write to sample.
				e.data.writeFloat( newLeft );
				e.data.writeFloat( newRight );
				
				// write numbers to the "recording" byteArray
				_recordedBytes.writeFloat( newLeft );
				_recordedBytes.writeFloat( newRight );
				
				// Increment.
				b++;
				
			}
			
		}
		
		
		private function encodeToMP3(wavData:ByteArray):void {
			
			_mp3Encoder = new ShineMP3Encoder(wavData);
			_mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
			_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
			_mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
			_mp3Encoder.start();
		}

		/*
		private function encodeToWAV(wavData:ByteArray):void {
			
			_mp3Encoder = new ShineMP3Encoder(wavData);
			_mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
			_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
			_mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
			_mp3Encoder.start();
		}
		*/
		
		private function mp3EncodeProgress(event : ProgressEvent) : void {
			
			trace(event.bytesLoaded, event.bytesTotal);
		}
		
		private function mp3EncodeError(event : ErrorEvent) : void {
			
			trace("Error : ", event.text);
		}
		
		private function mp3EncodeComplete(event : Event) : void 
		{
			
			trace("Done !", _mp3Encoder.mp3Data.length);
			
			// Save to desktop.
			
			// WRITE ID3 TAGS
			var sba:ByteArray = _mp3Encoder.mp3Data;
			sba.position =  sba.length - 128
			sba.writeMultiByte("TAG", "iso-8859-1");
			sba.writeMultiByte("PopClik - Tracknames      "+String.fromCharCode(0), "iso-8859-1");	// Title
			sba.writeMultiByte("PopClik                 "+String.fromCharCode(0), "iso-8859-1");	// Artist			
			sba.writeMultiByte("TrackNames Vol 1  "+String.fromCharCode(0), "iso-8859-1");	// Album		
			sba.writeMultiByte("2014" + String.fromCharCode(0), "iso-8859-1");							// Year
			sba.writeMultiByte("www.popclik.com/         " + String.fromCharCode(0), "iso-8859-1");// comments
			sba.writeByte(57);																		
			
			// Save the file.
			file = new FileReference();
			file.addEventListener( Event.COMPLETE, onEncodeComplete );
			file.addEventListener( Event.CANCEL, onEncodeCancel );
			file.save(sba, "PopClik-TrackNames.mp3");
			
		}
		
		
		private function onEncodeComplete(event : Event) : void 
		{
			
			trace("AudioGadget onEncodeComplete");
			Dispatcher.dispatchEvent( new AppEvent( AppEvent.TRACK_COMPLETE ) );
			
		}

		
		private function onEncodeCancel(event : Event) : void 
		{
			
			trace("AudioGadget onEncodeCancel");
			Dispatcher.dispatchEvent( new AppEvent( AppEvent.TRACK_CANCEL ) );
			
		}
		
	}
	
}

























