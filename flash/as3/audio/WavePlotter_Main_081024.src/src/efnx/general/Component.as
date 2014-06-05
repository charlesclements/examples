/* AS3
	Copyright 2008 efnx.com.
*/
package efnx.general
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
    import flash.utils.getDefinitionByName;
	import flash.utils.ByteArray;

	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.CheckBox;
	import fl.controls.Label;
	import fl.controls.ProgressBar;
	import fl.controls.DataGrid;
	import fl.controls.Slider;
	
	/**
	 *	A complete event is dispatched after the assets swf is loaded.
	 *	@eventType flash.events.Event
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 *	The Component class handles loading external component swfs and answers requests for component instantiation. 
	 *	Before a request for a component can be fulfilled the swf containing said components must be fully loaded.
	 *	After loading the swf with the load(path) method, Component will dispatch a "complete" event.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Schell Scivally
	 *	@since  21.04.2008
	 */
	
	public class Component extends Object 
	{
		
		/*---------------------------------------------------------------------------------------------------*/
		/*  CLASS CONSTANTS						                                      		CLASS CONSTANTS */
		/*-------------------------------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------------------------*/
		/*  PRIVATE VARIABLES			                                                 PRIVATE VARIABLES  */
		/*-------------------------------------------------------------------------------------------------*/
		private static var _loaded:Boolean = false;
		private static var dispatcher:EventDispatcher = new EventDispatcher();
		/*---------------------------------------------------------------------------------------------------*/
		/*  PUBLIC VARIABLES			                                                  PUBLIC VARIABLES  */
		/*-------------------------------------------------------------------------------------------------*/
		/**
	 	*	Indicates whether or not to display verbose information.
	 	*/
		public static var testing:Boolean = false;
		/*---------------------------------------------------------------------------------------------------*/
		/*  CONSTRUCTOR							                                         	   CONSTRUCTOR  */
		/*-------------------------------------------------------------------------------------------------*/
		
		/**
		 *	@Constructor
		 */
		public function Component():void
		{
			super();
		}
		
		/*---------------------------------------------------------------------------------------------------*/
		/*  GETTER/SETTERS							                                      	GETTER/SETTERS  */
		/*-------------------------------------------------------------------------------------------------*/
		/**
		*	Returns whether or not the component swf has loaded.
		*/
		public static function get loaded():Boolean
		{
			return _loaded;
		}
		/*---------------------------------------------------------------------------------------------------*/
		/*  PUBLIC METHODS							                               	       	PUBLIC METHODS  */
		/*-------------------------------------------------------------------------------------------------*/
		/**
		*	Used to load the swf that contains your components.
		*	
		*	@param path Path to the swf to load or a ByteArray containing the embedded swf asset.
		*/
		public static function load(path:*):void
		{
			if(testing) trace("Component::load()", path);
			if(_loaded) throw new Error("Component::load() Components have already been loaded.");
			
			var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener("complete", loadComponentsComplete, false, 0, true);
				loader.contentLoaderInfo.addEventListener("ioError", loadComponentsError, false, 0, true);
			var context:LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);
			if(path is String)
			{	
				loader.load(new URLRequest(path), context);
			}else if(path is ByteArray)
			{
				context.checkPolicyFile = false;
				loader.loadBytes(path, context);
			}else
			{
				throw new Error("Component::load() argument is neither a path nor a ByteArray.");
			}
		}
		/**
		*	Registers an event listener object with an EventDispatcher object so that the listener receives 
		*	notification of an event.
		*/
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if(testing) trace("Component::addEventListener()");
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		/**
		*	Removes a listener from the EventDispatcher object. If there is no matching listener registered 
		*	with the EventDispatcher object, a call to this method has no effect.
		*/
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if(testing) trace("Component::removeEventListener()");
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		/**
		*	Returns an instance of the given class.
		*/
		public static function New(component:String):*
		{
			if(testing) trace("Component::New()", component);
			if(!_loaded) throw new Error("Component::"+component+"() Component swf has not loaded.")
			var componentClass:Class = getDefinitionByName("fl.controls."+component) as Class;
			return new componentClass();
		}
		/*---------------------------------------------------------------------------------------------------*/
		/*  EVENT HANDLERS							                                       EVENT HANDLERS   */
		/*-------------------------------------------------------------------------------------------------*/
		private static function loadComponentsComplete(event:Event):void
		{
			if(testing) trace("Component::loadComponentsComplete()");
			_loaded = true;
			dispatcher.dispatchEvent(new Event("complete"));
		}
		private static function loadComponentsError(event:Event):void
		{
			if(testing) trace("Component::loadComponentsError() "+event);
		}
		/*---------------------------------------------------------------------------------------------------*/
		/*  PRIVATE/PROTECTED METHODS				                           	 PRIVATE/PROTECTED METHODS  */
		/*-------------------------------------------------------------------------------------------------*/
		
	}
	
}
