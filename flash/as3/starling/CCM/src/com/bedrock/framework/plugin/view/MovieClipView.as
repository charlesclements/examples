/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
*/
package com.bedrock.framework.plugin.view
{
	import com.greensock.TweenLite;
	import com.bedrock.framework.core.base.MovieClipBase;
	
	[Event(name="ViewEvent.onInitializeComplete", type="com.bedrock.framework.plugin.event.ViewEvent")]
	[Event(name="ViewEvent.onIntroComplete", type="com.bedrock.framework.plugin.event.ViewEvent")]
	[Event(name="ViewEvent.onOutroComplete", type="com.bedrock.framework.plugin.event.ViewEvent")]
	[Event(name="ViewEvent.onClearComplete", type="com.bedrock.framework.plugin.event.ViewEvent")]
	
	
	public class MovieClipView extends MovieClipBase
	{
		/*
		Variable Declarations
		*/
		private var _hasInitialized:Boolean;
		/**
		 * The initializeComplete() function will dispatch ViewEvent.INITIALIZE_COMPLETE notifying any listeners of this class that the initialization of the view is complete.
		 * This function should be called at the end of the initialize function
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function initializeComplete():void
		{
			this._hasInitialized = true;
			TweenLite.delayedCall( 0, this.dispatchEvent, [ new ViewEvent(ViewEvent.INITIALIZE_COMPLETE, this ) ] );
		}
		/**
		 * The introComplete() function will dispatch ViewEvent.INTRO_COMPLETE notifying any listeners of this class that the intro of the view is complete.
		 * This function should be called after the view has finished it's intro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function introComplete():void
		{
			TweenLite.delayedCall( 0, this.dispatchEvent, [ new ViewEvent(ViewEvent.INTRO_COMPLETE, this ) ] );
		}
		/**
		 * The outroComplete() function will dispatch ViewEvent.OUTRO_COMPLETE notifying any listeners of this class that the outro of the view is complete.
		 * This function should be called after the view has finished it's outro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function outroComplete():void
		{
			TweenLite.delayedCall( 0, this.dispatchEvent, [ new ViewEvent(ViewEvent.OUTRO_COMPLETE, this ) ] );
		}
		/**
		 * The clearComplete() function will dispatch ViewEvent.OUTRO_COMPLETE notifying any listeners of this class that the clear of the view is complete.
		 * This function should be called at the end of the clear function.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function clearComplete():void
		{
			TweenLite.delayedCall( 0, this.dispatchEvent, [ new ViewEvent(ViewEvent.CLEAR_COMPLETE, this ) ] );
		}
		
		
		
		public function get hasInitialized():Boolean
		{
			return this._hasInitialized;
		}
	}

}