//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2008 efnx.com
// 
////////////////////////////////////////////////////////////////////////////////

package efnx.events {

import flash.events.Event;

/**
 *	WaveformEvent is the event class dispatched by the Waveform class.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *
 *	@author Schell Scivally
 *	@since  21.10.2008
 */

public class WaveformEvent extends Event {
	
	//--------------------------------------
	// CLASS CONSTANTS
	//--------------------------------------
	/**
	 *	Defines the value of the <code>type</code> property of a <code>complete</code> event object.
	 */
	public static const COMPLETE:String = "complete";
	/**
	 *	Defines the value of the <code>type</code> property of a <code>progress</code> event object.
	 */
	public static const PROGRESS:String = "progress";
	
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	/**
	 *	Creates a WaveformEvent object.
	 *		
	 *	@constructor
	 *	@param type The type of WaveformEvent, either "complete" or "progress."
	 */
	public function WaveformEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false )
	{
		super(type, bubbles, cancelable);
	}
	
	//--------------------------------------
	//  GETTER/SETTERS
	//--------------------------------------
	
	//--------------------------------------
	//  PUBLIC METHODS
	//--------------------------------------

	override public function clone():Event
	{
		var event:WaveformEvent = new WaveformEvent(type, bubbles, cancelable);
			event.windowsAnalyzed = windowsAnalyzed;
			event.windowsTotal = windowsTotal;
			event.leftChunk = leftChunk;
			event.rightChunk = rightChunk;
		return event;
	}
	
	//--------------------------------------
	//  EVENT HANDLERS
	//--------------------------------------
	
	//--------------------------------------
	//  PRIVATE VARIABLES
	//--------------------------------------
	/**
	 *	The number of windowsAnalyzed thus far.
	 */
	public var windowsAnalyzed:uint = 0;
	/**
	 *	The number of windows total to be analyzed.
	 */
	public var windowsTotal:uint = 0;
	/**
	 *	The left channel values of analyzed windows since the last WaveformEvent.
	 */
	public var leftChunk:Vector.<Number>;
	/**
	 *	The right channel values of analyzed windows since the last WaveformEvent.
	 */
	public var rightChunk:Vector.<Number>;
	//--------------------------------------
	//  PRIVATE & PROTECTED INSTANCE METHODS
	//--------------------------------------
	
}

}

