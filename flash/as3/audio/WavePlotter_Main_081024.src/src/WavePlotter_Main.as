package {

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.events.SampleDataEvent;
import flash.display.Stage;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.utils.ByteArray;
import flash.utils.Timer;

import fl.controls.Button;

import efnx.sound.Waveform;
import efnx.events.WaveformEvent;
import efnx.gfx.Raster;
import efnx.general.Component;

/**
 *	Application entry point for Waveform_Main.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *
 *	@author Schell Scivally
 *	@since 16.10.2008
 */
public class WavePlotter_Main extends Sprite {
	
	[Embed(source='../lib/bin/Components.swf', mimeType="application/octet-stream")]
	private static const Assets:Class;
	
	private var mp3:Sound = new Sound();
	private var channel:SoundChannel;
	private var looper:Timer = new Timer(0,0);
	private var plotter:Waveform = new Waveform();
	private var method:String = "rms";
	private var waveform:Bitmap = new Bitmap();
	private var playhead:Bitmap = new Bitmap();
	private var selection:Bitmap = new Bitmap();
	private var selectPoint:Point = new Point();
	private var dx:int = 0;
	private var loadComplete:Boolean = false;
	
	var directions:TextField = new TextField();
	var leftTxt:TextField = new TextField();
	var leftSample:TextField = new TextField();
	var rightTxt:TextField = new TextField();
	var rightSample:TextField = new TextField();
	
	/**
	 *	@constructor
	 */
	public function WavePlotter_Main()
	{
		super();
		stage.align = "TL";
		stage.scaleMode = "noScale";
		stage.frameRate = 100;
		
		//	load our button assets generated from the Flash CS3 IDE
		var assets:ByteArray = new Assets() as ByteArray;
		Component.addEventListener("complete", start, false, 0, true);
		Component.load(assets);
	}
	/**
	 *	Starts our initialize stub
	 */
	private function start(event:Event):void
	{
		stage.addEventListener( Event.ENTER_FRAME, initialize );
	}

	/**
	 *	Initialize stub.
	 */
	private function initialize(event:Event):void
	{
		if(stage.stageWidth == 0 && stage.stageHeight == 0) return;
		stage.removeEventListener( Event.ENTER_FRAME, initialize );
		trace( "Waveform_Main::initialize()" );
		
		waveform.bitmapData = new BitmapData(stage.stageWidth, stage.stageHeight/2, true, 0x00FFFFFF);
		waveform.y = stage.stageHeight/2 - waveform.height/2;
		addChild(selection);
		addChild(waveform);
		selection.y = waveform.y;
		
		directions.autoSize = "left";
		directions.text = "Use the 'Analyze' buttons to switch analyzation types.";
		directions.text += "\nClick and drag the waveform to make a selection.";
		directions.text += "\nOnce selected, click 'Zoom In' to zoom in and loop your selection.";
		directions.text += "\nWhen finished, click 'Show Full' to return to the entire waveform.";
		addChild(directions);
		leftTxt.autoSize = "left";
		leftTxt.text = "Left sample bound for analyzation (from): ";
		leftTxt.y = directions.height;
		addChild(leftTxt);
		leftSample.width = 50;
		leftSample.height = 15;
		leftSample.x = leftTxt.width;
		leftSample.y = leftTxt.y;
		leftSample.border = true;
		leftSample.borderColor = 0x000000;
		addChild(leftSample);
		rightTxt.autoSize = "left";
		rightTxt.text = "Right sample bound for analyzation (to): ";
		rightTxt.x = leftSample.x + leftSample.width + 4;
		rightTxt.y = leftTxt.y;
		addChild(rightTxt);
		rightSample.width = 50;
		rightSample.height = 15;
		rightSample.x = rightTxt.x + rightTxt.width;
		rightSample.y = leftSample.y;
		rightSample.border = true;
		rightSample.borderColor = 0x000000;
		addChild(rightSample);
			
		var rms:Button = Component.New("Button");
			rms.label = "Analyze->RMS";
			rms.y = leftTxt.y + leftTxt.height + 5;
			addChild(rms)
			rms.addEventListener("mouseDown", analyzeRMS, false, 0, true);
			
		var max:Button = Component.New("Button");
			max.label = "Analyze->MAX";
			max.y = rms.y;
			max.x = rms.width + 2;
			addChild(max);
			max.addEventListener("mouseDown", analyzeMAX, false, 0, true);
		var zoomIn:Button = Component.New("Button");
			zoomIn.label = "Zoom In";
			zoomIn.y = max.y;
			zoomIn.x = max.x + max.width + 2;
			addChild(zoomIn);
			zoomIn.addEventListener("mouseDown", zoomLoop, false, 0, true);
		var zoomOut:Button = Component.New("Button");
			zoomOut.label = "Show Full";
			zoomOut.y = max.y;
			zoomOut.x = zoomIn.x + zoomIn.width + 2;
			addChild(zoomOut);
			zoomOut.addEventListener("mouseDown", zoomFull, false, 0, true);
			
		var backing:Bitmap = new Bitmap();
			backing.bitmapData = new BitmapData(rightSample.x+rightSample.width + 2, zoomOut.y + zoomOut.height + 2, true, 0xCCFFFFFF);
			addChildAt(backing, 0);
			
		
		mp3.addEventListener("progress", onProgress, false, 0, true);
		mp3.addEventListener("complete", onComplete, false, 0, true);
		mp3.load(new URLRequest('assets/mp3/8. Wizard.mp3'));
	}
	/**
	*	Called as the mp3 is loading.
	*/
	public function onProgress(event:ProgressEvent):void
	{
		trace("Waveform_Main::onProgress()", Number(event.bytesLoaded/event.bytesTotal*100).toPrecision(3) + "% loaded.");
		var w:int = event.bytesLoaded/event.bytesTotal * waveform.bitmapData.width;
		var h:int = waveform.bitmapData.height;
		Raster.line(waveform.bitmapData, 0, h/2, w, h/2, 0xFF5BC1CC);
		Raster.line(waveform.bitmapData, 0, h/2+1, w, h/2+1, 0xFFC25BCC);
	}
	/**
	*	Called on the completion of the mp3's loading.
	*	This function initiates the sound's "sampleData" event and starts analyzation.
	*/
	public function onComplete(event:Event):void
	{
		loadComplete = true;
		trace("Waveform_Main::onComplete()", "Load complete.");
		
		plotter.sound = mp3;
		plotter.leftSample = 0;
		plotter.rightSample = mp3.length*44.1;
		plotter.numWindows = waveform.bitmapData.width;
		plotter.addEventListener("progress", onWindowAnalyze, false, 0, true);
		plotter.addEventListener("complete", onAnalyzeComplete, false, 0, true);
		plotter.createWaveform("rms");
		
		mp3.removeEventListener("progress", onProgress);
		mp3.removeEventListener("complete", onComplete);
		channel = mp3.play(plotter.leftSample/44.1);
		looper.delay = (plotter.rightSample - plotter.leftSample)/44.1;
		looper.addEventListener("timer", loop, false, 0, true);
		
		leftSample.text = "0";
		rightSample.text = Number(mp3.length*44.1).toString();
		
		playhead.bitmapData = new BitmapData(1, waveform.height, false, 0x333333);
		playhead.y = waveform.y;
		addChild(playhead);
		stage.addEventListener("enterFrame", movePlayHead, false, 0, true);
		stage.addEventListener("mouseDown", startSelection, false, 0, true);
	}
	/**
	 *	Starts making the selection.
	 */
	public function startSelection(event:MouseEvent):void
	{
		if(!(event.target is Stage)) return;
		trace("WavePlotter_Main::startSelection()");
		selection.bitmapData = new BitmapData(waveform.width, waveform.height, true, 0x00FFFFFF);
		stage.addEventListener("mouseMove", makeSelection, false, 0, true);
		stage.addEventListener("mouseUp", stopSelection, false, 0, true);
		selectPoint = new Point(event.localX, event.localY);
	}
	/**
	 *	Expands the selection and updates the left and right sample values.
	 */
	public function makeSelection(event:MouseEvent):void
	{
		selection.bitmapData = new BitmapData(waveform.width, waveform.height, true, 0x00FFFFFF);
		var w:int = event.localX - selectPoint.x;
		var h:int = selection.height;
		var _x:int = w < 0 ? selectPoint.x + w : selectPoint.x;
		//	boundaries
		_x < 0 ? 0 : _x;
		w = w < 0 ? w * -1 : w;
		
		var rect:Rectangle = new Rectangle(_x, 0, w, h);
		selection.bitmapData.fillRect(rect, 0x7F99CC33);
		
		var l:uint = plotter.leftSample + plotter.windowSize*_x;
		var r:uint = l + plotter.windowSize*w;
		leftSample.text = l.toString();
		rightSample.text = r.toString();
	}
	/**
	 *	Stops the selection process.
	 */
	public function stopSelection(event:MouseEvent):void
	{
		stage.removeEventListener("mouseMove", makeSelection);
		stage.removeEventListener("mouseUp", stopSelection);
	}
	/**
	 *	Advances the playhead.
	 */
	public function movePlayHead(event:Event):void
	{
		var loopSamplePosition:uint = channel.position*44.1 - plotter.leftSample;
		var samplesInLoop:uint = plotter.rightSample - plotter.leftSample;
		playhead.x = waveform.width * loopSamplePosition/samplesInLoop;
	}
	/**
	 *	Conducts the audio loop.
	 */
	public function loop(event:Event):void
	{
		trace("WavePlotter_Main::loop()");
		channel.stop();
		channel = mp3.play(plotter.leftSample/44.1);
		looper.delay = (plotter.rightSample - plotter.leftSample)/44.1;
	}
	/**
	 *	Analyzes the song using the max algorithm.
	 */
	public function analyzeMAX(event:Event):void
	{
		if(!loadComplete) return;
		method = "max";
		leftSample.text = plotter.leftSample.toString();
		rightSample.text = plotter.rightSample.toString();
		reset();
	}
	/**
	 *	Analyzes the song using the rms algorithm.
	 */
	public function analyzeRMS(event:Event):void
	{
		if(!loadComplete) return;
		method = "rms";
		leftSample.text = plotter.leftSample.toString();
		rightSample.text = plotter.rightSample.toString();
		reset();
	}
	/**
	 *	Zooms in on the selected area and loops that part of the song.
	 */
	public function zoomLoop(event:Event):void
	{
		if(!loadComplete) return;
		reset(true);
	}
	/**
	 *	Zooms the song all the way out and loops the entire song.
	 */
	public function zoomFull(event:Event):void
	{
		leftSample.text = "0";
		rightSample.text = (mp3.length*44.1).toString();
		channel.stop();
		var position:Number = channel.position;
		channel = mp3.play(position);
		looper.stop();
		looper.delay = (mp3.length - position);
		looper.start();
		reset();
	}
	
	/**
	 * 	Resets the values of the plotter, clears the bitmapData and loads the
	 *	samples to be played into the buffer from the mp3.
	 */
	public function reset(startLoop:Boolean = false):void
	{
		var w:int = waveform.width;
		var h:int = waveform.height;
		plotter.cancel();
		plotter.numWindows = w;
		dx = 0;
		waveform.bitmapData = new BitmapData(w, h, true, 0x00FFFFFF);
		selection.bitmapData = new BitmapData(waveform.width, waveform.height, true, 0x00FFFFFF);
		Raster.line(waveform.bitmapData, 0, h/2, w, h/2, 0xFF5BC1CC);
		Raster.line(waveform.bitmapData, 0, h/2+1, w, h/2+1, 0xFFC25BCC);
		plotter.leftSample = uint(leftSample.text);
		plotter.rightSample = uint(rightSample.text);
		plotter.createWaveform(method);
		
		if(!startLoop) return;
		
		channel.stop();
		channel = mp3.play(plotter.leftSample/44.1);
		looper.stop();
		looper.delay = (plotter.rightSample - plotter.leftSample)/44.1;
		looper.start();
	}
	/**
	 *	Draws the analyzed data sent from plotter.
	 */
	public function onWindowAnalyze(event:WaveformEvent):void
	{
		var h:int = waveform.bitmapData.height;
		var a:int = event.windowsAnalyzed;
		var l:Number = event.leftChunk.length;
		var r:Number = event.rightChunk.length;
		
		for (var i:int = 0; i < l; i++)
		{
			var lv:Number = event.leftChunk[i];
			Raster.line(waveform.bitmapData, dx+i, h/2-h/2*Math.abs(lv), dx+i, h/2, 0xFF5BC1CC);
		}
		for (var j:int = 0; j < l; j++)
		{
			var rv:Number = event.rightChunk[j];
			Raster.line(waveform.bitmapData, dx+j, h/2+h/2*Math.abs(rv), dx+j, h/2, 0xFFC25BCC);
		}
		dx += i;
	}
	/**
	 *	Called when analyzation is complete.
	 */
	public function onAnalyzeComplete(event:Event):void
	{
		trace("Waveform_Main::onAnalyzeComplete()");
	}
	
}

}
