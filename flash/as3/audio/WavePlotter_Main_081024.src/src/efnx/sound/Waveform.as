//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2008 efnx.com
// 
////////////////////////////////////////////////////////////////////////////////

package efnx.sound {

import flash.display.Bitmap;
import flash.media.Sound;
import flash.utils.getTimer;
import flash.utils.ByteArray;
import flash.events.Event;

import efnx.events.WaveformEvent;

/**
 *	A progress event is dispatched whenever a chunk of windows has been analyzed [usually each frame].
 *	@eventType efnx.events.WaveformEvent 
 */
[Event(name="progress", type="efnx.events.WaveformEvent")]

/**
 *	A complete event is dispatched when Waveform has completed analyzing all windows.
 *	@eventType efnx.events.WaveformEvent
 */
[Event(name="complete", type="efnx.events.WaveformEvent")]

/**
 *	Waveform takes a loaded sound object [mp3] from which it constructs a 
 *	plottable waveform. The waveform can be analyzed using two methods: Max, 
 *	which calculates the absolute max value for each window or RMS, which calculates 
 *	the root mean square of all values in each window. RMS is typically about 4 milliseconds
 *	faster per window than Max.
 *	
 *	
 *	Further more Waveform attepts to be as smart as possible, by analyzing the
 *	maximum number of windows to calculate per frame. In order to do this correctly, you must tell
 *	Waveform what your target framerate is with <code>frameRate</code> or Waveform wil
 *	assume it to be 16, which is a good comprimise between speed and functionality [as when
 *	flash is chugging on values, you don't get much mouse/keyboard input, but with a higher frame rate
 *	less windows are calculated per frame, taking longer to analyze the sound].
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 10.0
 *
 *	@author Schell Scivally
 *	@since  20.10.2008
 */

public class Waveform extends Bitmap {
	
	//--------------------------------------
	// CLASS CONSTANTS
	//--------------------------------------
	/**
	 *	Flash's sampling frequency.
	 */
	public static const SAMPLERATE:uint = 44100;
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	/**
	*	Creates a new instance of Waveform.
	 *	@constructor
	 */
	public function Waveform()
	{
		super();
		frameRate = 16;
	}
	
	//--------------------------------------
	//  PRIVATE VARIABLES
	//--------------------------------------
	private var _sound:Sound;
	private var _buffer:ByteArray;
	private var _left:Vector.<Number>;
	private var _right:Vector.<Number>;
	private var _windowSize:uint;
	
	private var _windowsAnalyzed:uint = 0;
	private var _windowsTotal:uint = 0;
	private var _position:Number = 0;
	private var _t:uint = 0;
	private var _leftSample:uint = 0;
	private var _rightSample:uint = 0;
	private var _milliPerFrame:Number = 42;
	private var _windowsPerFrame:uint = 1;
	//--------------------------------------
	//  GETTER/SETTERS
	//--------------------------------------
	/**
	 *	Set this to the sound you want to analyze.
	 */
	public function set sound(s:Sound):void
	{
		_sound = s;
	}
	public function get sound():Sound
	{
		return _sound;
	}
	/**
	 *	Returns the current block of plottable data from the left channel.
	 *	The size of the returned vector is the number of windows analyzed.
	 *	Typically this data would be accessed on an "as analyzed" basis through
	 *	@see efnx.sound.WaveformEvent#leftChunk, which is a vector containing
	 *	the windows analyzed most recently [last frame].
	 *	
	 *	@return A Vector of type <code>Number</code> representing each analyzed window.
	 */
	public function get leftChannel():Vector.<Number>
	{
		return _left;
	}
	/**
 	 *  Returns the current block of plottable data from the right channel.
	 *	The size of the returned vector is the number of windows analyzed.
	 *	Typically this data would be accessed on an "as analyzed" basis through
	 *	@see efnx.sound.WaveformEvent#rightChunk, which is a vector containing
	 *	the windows analyzed most recently [last frame].
	 *	
	 *	@return A Vector of type <code>Number</code> representing each analyzed window.
	 */
	public function get rightChannel():Vector.<Number>
	{
		return _right;
	}
	/**
	 *	The leftmost sample index analyzation should start at. For example to analyze a sound
	 *	starting from the middle of the sound we would write something like this:
	 *	<code>
	 *	var s:Sound = new SoundInLibrary();
	 *	var w:Waveform = new Waveform();
	 *	w.leftSample = s.length*44.1/2;
	 *	w.analyze("max");
	 *	</code>
	 *	
	 */
	public function set leftSample(val:uint):void
	{
		val = val < 0 ? 0 : val;
		val = val > _sound.length*44.1 ? _sound.length*44.1 : val;
		_leftSample = val;
		if(_rightSample <= _leftSample) _rightSample = _sound.length*44.1;
	}
	public function get leftSample():uint
	{
		return _leftSample;
	}
	/**
	 *	The rightmost sample index analyzation should start at. For example to analyze the 
	 *	middle third of the sound we would write something like this:
	 *	<code>
	 *	var s:Sound = new SoundInLibrary();
	 *	var w:Waveform = new Waveform();
	 *	w.leftSample = s.length*44.1/3;
	 *	w.rightSample = s.length*44.1/3*2;
	 *	w.analyze("rms");
	 *	</code>
	 *	
	 *	@default    Last sample in @see #sound.
	 */
	public function set rightSample(val:uint):void
	{
		val = val < _leftSample ? _leftSample : val;
		val = val > _sound.length*44.1 ? _sound.length*44.1 : val;
		_rightSample = val;
	}
	public function get rightSample():uint
	{
		return _rightSample;
	}
	/**
	 *	The target frameRate of analyzation. Setting this to your target frame rate allows
	 *	the analyzation to be optimized. If not set, default is 16 [which is a pretty good
	 *	balance between speed and functionality]. If set to 0 or less, will default to 1.
	 */
	public function set frameRate(val:Number):void
	{
		val = val <= 0 ? 1 : val;
		_milliPerFrame = Math.ceil(1/val*1000);
	}
	public function get frameRate():Number
	{
		return Math.round(1/(_milliPerFrame/1000));
	}
	/**
	 *	The number of windows to use in the analyzation. 
	 */
	public function set numWindows(val:uint):void
	{
		_windowsTotal = val;
	}
	public function get numWindows():uint
	{
		return _windowsTotal;
	}
	/**
	 *	The size of each window in samples.
	 */
	public function get windowSize():uint
	{
		return Math.max((_rightSample - _leftSample)/_windowsTotal, 1);
	}
	//--------------------------------------
	//  PUBLIC METHODS
	//--------------------------------------
	/**
	 *	Constructs two vectors of analyzed waveforms using the method supplied in "method". 
	 *	The vectors will consist of plottable points [0 to 1] representing the left and 
	 *	right channels. Every value in each vector represents all sound data in a given window. 
	 *	
	 *	@param method Determines the method of analyzation. Valid methods are <code>max</code>
	 *	and <code>rms</code>.
	 */
	public function createWaveform(method:String = "rms"):void
	{
		if(_rightSample <= _leftSample) _rightSample = _sound.length*44.1;
		_windowSize = windowSize;
		_position = _leftSample;
		_left 	= new Vector.<Number>();
		_right	= new Vector.<Number>();
		_windowsAnalyzed = 0;
		_windowsPerFrame = 1;
		optimize(method);
	}
	/**
	 *	Stops all analyzation.
	 */
	public function cancel():void
	{
		removeEventListener("enterFrame", rms);
		removeEventListener("enterFrame", max);
	}
	//--------------------------------------
	//  EVENT HANDLERS
	//--------------------------------------
	
	//--------------------------------------
	//  PRIVATE & PROTECTED INSTANCE METHODS
	//--------------------------------------
	/**
	 * @private
	 */
	private function optimize(method:String = "max"):void
	{
		var nt:uint
		switch(method)
		{
			case "max":
				_t = getTimer();
				max();
				max();
				max();
				max();
				nt = getTimer()-_t;
				_windowsPerFrame = Math.max(int(_milliPerFrame/(nt/4)), 1);
				addEventListener("enterFrame", max, false, 0, true);
				break;
			case "rms":
				_t = getTimer();
				rms();
				rms();
				rms();
				rms();
				nt = getTimer()-_t;
				_windowsPerFrame = Math.max(int(_milliPerFrame/(nt/4)), 1);
				addEventListener("enterFrame", rms, false, 0, true);
				break;
			default:
		}
	}
	/**
	 * @private
	 */
	private function max(event:Event = null):void
	{
		var wevent:WaveformEvent = new WaveformEvent("progress");
			wevent.leftChunk = new Vector.<Number>();
			wevent.rightChunk = new Vector.<Number>();
		
		for (var i:int = 0; i < _windowsPerFrame; i++)
		{
			_buffer = new ByteArray();
			_buffer.position = 0;
			_sound.extract(_buffer, _windowSize, _position);
			_buffer.position = 0;
	
			while(_buffer.bytesAvailable)
			{
				var l:Number = _buffer.readFloat();
				var r:Number = _buffer.readFloat();
				var ml:Number = 0;
				var mr:Number = 0;
				var a_ml:Number = abs(ml);
				var a_mr:Number = abs(mr);
				ml= a_ml > abs(l) ? ml : l;
				mr= a_mr > abs(r) ? mr : r;
		
				if(a_ml >= .999 && a_mr >= .999) 
				{
					break;
				}
			}
			_left.push(ml);
			_right.push(mr);
		
			_windowsAnalyzed++;
			_position += _windowSize;
		
			wevent.leftChunk.push(ml);
			wevent.rightChunk.push(mr);
		}
		
		wevent.windowsAnalyzed = _windowsAnalyzed;
		wevent.windowsTotal = _windowsTotal;
		dispatchEvent(wevent);
		
		if(_windowsAnalyzed >= _windowsTotal)
		{
			removeEventListener("enterFrame", max);
			var nt:uint = getTimer()-_t;
			trace("Waveform::max()", "executed in", nt, "milliseconds. Average", nt/_windowsTotal, "milliseconds per window.");
			dispatchEvent(new WaveformEvent("complete"));
		}
	}
	/**
	 *	@private
	 */
	private function rms(event:Event = null):void
	{
		var wevent:WaveformEvent = new WaveformEvent("progress");
			wevent.leftChunk = new Vector.<Number>();
			wevent.rightChunk = new Vector.<Number>();
		
		for (var i:int = 0; i < _windowsPerFrame; i++)
		{
			_buffer = new ByteArray();
			_buffer.position = 0;
			_sound.extract(_buffer, _windowSize, _position);
			_buffer.position = 0;
	
			var avl:Number = 0;
			var avr:Number = 0;
			while(_buffer.bytesAvailable)
			{
				var l:Number = _buffer.readFloat();
				var r:Number = _buffer.readFloat();
				avl += l*l;
				avr += r*r;
			}
			
			avl /= _windowSize;
			avr /= _windowSize;
			avl = Math.sqrt(avl);
			avr = Math.sqrt(avr);
			_left.push(avl);
			_right.push(avr);
		
			_windowsAnalyzed++;
			_position += _windowSize;
		
			wevent.leftChunk.push(avl);
			wevent.rightChunk.push(avr);
		}
		
		wevent.windowsAnalyzed = _windowsAnalyzed;
		wevent.windowsTotal = _windowsTotal;
		dispatchEvent(wevent);
		
		if(_windowsAnalyzed >= _windowsTotal)
		{
			removeEventListener("enterFrame", rms);
			var nt:uint = getTimer()-_t;
			trace("Waveform::rms()", "executed in", nt, "milliseconds. Average", nt/_windowsTotal, "milliseconds per window.");
			dispatchEvent(new WaveformEvent("complete"));
		}
	}
	//--------------------------------------
	//  PRIVATE & PROTECTED HELPER METHODS
	//--------------------------------------
	/**
	 *	@private
	 */
	private function abs(val:Number):Number
	{
		return val > 0 ? val : val * -1;
	}
}

}

