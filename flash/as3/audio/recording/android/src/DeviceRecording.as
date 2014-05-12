package
{
	import com.greensock.TweenMax;
	import com.junkbyte.console.Cc;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import fr.kikko.lab.ShineMP3Encoder;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	public class DeviceRecording extends Sprite
	{
		
		
		public var timeTxt:TextField;
		public var startRecord:MovieClip;
		public var stopRecord:MovieClip;
		public var playSound:MovieClip;
		public var stopSound:MovieClip;
		public var inputLevels:MovieClip;
		public var outputLevels:MovieClip;
		// volume in the final WAV file will be downsampled to 50%
		private var volume:Number = 1;//0.5;
		// we create the WAV encoder to be used by MicRecorder
		private var wavEncoder:WaveEncoder;
		// we create the MicRecorder object which does the job
		private var recorder:MicRecorder;
		private var fileReference:FileReference;
		private var player:WavSound;
		private var playerTimerObj:TweenMax;
		//private var timer:TimeGadget;
		
		
		
		
		
		public function DeviceRecording()
		{
			super();
			
			
			Cc.log("DeviceRecording");
			
			
			
			
			startRecord.addEventListener( MouseEvent.CLICK, buttonHandler );
			stopRecord.addEventListener( MouseEvent.CLICK, buttonHandler );
			playSound.addEventListener( MouseEvent.CLICK, buttonHandler );
			stopSound.addEventListener( MouseEvent.CLICK, buttonHandler );
			
			
			
			
			//mp3Encoder = new ShineMP3Encoder(
			
			
			
			
			wavEncoder = new WaveEncoder( volume );
			//recorder = new MicRecorder( ShineMP3Encoder );
			recorder = new MicRecorder( wavEncoder );
			
			inputLevels.scaleY = 1;
			
			Cc.startOnStage(this, "");
			Cc.config.tracing = true; // also send traces to flash's normal trace()
			Cc.width = 200;
			
			recorder.addEventListener(RecordingEvent.RECORDING, onRecording);
			recorder.addEventListener(Event.COMPLETE, onRecordComplete);
			
			//timer = new TimeGadget;

			//playerTimerObj = new TweenMax( {}, 0.2, { onComplete:showPlayerTime, repeat:-1} );
			
			
			
			
			
			
		}
		
		
		private function onRecording(event:RecordingEvent):void
		{
			
			//trace ( "onRecording : " + event.time );
			//Cc.log( "onRecording : " + event.time );
			//timeTxt.text = String( event.time );
			
			
			//Cc.log( "microphone.activityLevel : " + recorder.microphone.activityLevel * 0.01 );
			
			inputLevels.scaleY = recorder.microphone.activityLevel * 0.01;
			
			
			
			
		}
		
		
		private function onRecordComplete(event:Event):void
		{
			
			//trace ( "onRecordComplete" );
			Cc.log( "onRecordComplete" );
			
			
			
			/*
			
			fileReference = new FileReference();
			fileReference.save ( recorder.output, "recording.wav" );
			//timeTxt.text = "onRecordComplete";
			*/
			
			
			
			
			var shine:ShineMP3Encoder = new ShineMP3Encoder( recorder.output as ByteArray );
			
			shine.start();
			
			shine.saveAs("ltg/recording1.mp3")
			
			
			//TweenMax.to( inputLevels, 1, { scaleY:0 } );
			inputLevels.scaleY = 1;
			
			
			
		}
		
		private function showPlayerTime(event:Event):void
		{
			
			//Cc.log( "onRecordComplete" );
			//trace ( "onRecordComplete" );
			//fileReference = new FileReference();
			//fileReference.save ( recorder.output, "recording.wav" );
			//timeTxt.text = String( player.
			
			
			
			
			
		}
		
		
		
		
		
		private function buttonHandler(e:MouseEvent):void
		{
			
			
			
			
			switch( e.currentTarget )
			{
				
				
				case startRecord:
					//trace( ( e.currentTarget as MovieClip ).name );
					Cc.log( ( e.currentTarget as MovieClip ).name );
					// starts recording
					recorder.record();
					break;
				
				
				
				case stopRecord:
					//trace( ( e.currentTarget as MovieClip ).name );
					Cc.log( ( e.currentTarget as MovieClip ).name );
					// stop recording
					recorder.stop();
					break;
				
				
				
				case playSound:
					//trace( ( e.currentTarget as MovieClip ).name );
					Cc.log( ( e.currentTarget as MovieClip ).name );
					player = new WavSound(recorder.output);
					player.play();
					break;
				
				
				
				case stopSound:
					//trace( ( e.currentTarget as MovieClip ).name );
					Cc.log( ( e.currentTarget as MovieClip ).name );
					
					
					break;
				
				
				
				
				
				
			}
			
			
			
		}
		
		
		
		
		
	}
}