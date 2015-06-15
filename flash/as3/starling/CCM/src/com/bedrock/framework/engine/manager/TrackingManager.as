package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.ITrackingManager;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.tracking.ITrackingService;
	import com.bedrock.framework.plugin.trigger.Trigger;
	import com.bedrock.framework.plugin.trigger.TriggerEvent;

	public class TrackingManager extends StandardBase implements ITrackingManager
	{
		/*
		Variable Declarations
		*/
		private var _enabled:Boolean;
		private var _trigger:Trigger;
		private var _services:HashMap;
		private var _queue:Array;
		/*
		Constructor
		*/
		public function TrackingManager()
		{
			this._enabled = true;
		}
		/*
		Initialize
		*/
		public function initialize($enabled:Boolean = true):void
		{
			this.enabled = $enabled;
			this._services = new HashMap();
			this._queue = new Array;
			
			this._createTrigger();
		}
		private function _createTrigger():void
		{
			this._trigger = new Trigger;
			this._trigger.addEventListener( TriggerEvent.TIMER_TRIGGER, this._onTrack );
			this._trigger.silenceLogging = true;
		}
		/*
		Run Tracking
		*/
		public function track($id:String, $details:Object):void
		{
			if (this.enabled) {
				if ( this.hasService( $id ) ) {
					this._appendCall( $id, $details );
					this._startDelay();
				}
			}
		}
		/*
		Add/ Get Services
		*/
		public function addService($id:String, $service:ITrackingService):void
		{
			this._services.saveValue($id, $service);
		}
		public function getService($id:String):*
		{
			return this._services.getValue($id);
		}
		public function hasService( $id:String ):Boolean
		{
			return this._services.containsKey( $id );
		}
		/*
		Internal
		*/
		private function execute($id:String, $details:Object):void
		{
			if ( this.hasService( $id ) ) {
				this.getService( $id ).track( $details );
			}
		}
		private function _startDelay():void
		{
			if (this._queue.length > 0) {
				if ( !this._trigger.timerRunning ) {
					this._trigger.startTimer( 0.3 );
				}
			}
		}
		
		/*
		Queue Functions 
		*/
		private function _appendCall($id:String, $details:Object):void
		{
			this._queue.push( { id:$id, details:$details } );
		}
		private function _getNext():Object
		{
			return this._queue.shift();
		}
		/*
		Event Handlers
		*/
		private function _onTrack($event:TriggerEvent):void
		{
			var objDetails:Object = this._getNext();
			if (objDetails != null) {
				this.execute(objDetails.id, objDetails.details);
			}
			this._startDelay()
		}
		/*
		Property Definitions
		*/
		public function set enabled($status:Boolean):void
		{
			this._enabled = $status;
			if ( this._enabled ) {
				this.status( "Tracking Enabled" );
			} else {
				this.status( "Tracking Disabled" );
			}
		}
		public function get enabled():Boolean
		{
			return this._enabled;
		}
	}
}