package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.plugin.storage.SuperArray;
	
	import flash.events.Event;

	public class ViewSequence extends DispatcherBase
	{
		/*
		Variable Declarations
		*/
		public var data:ViewSequenceData;
		
		private var _sequence:SuperArray;
		private var _views:SuperArray;
		
		/*
		Constructor
		*/
		public function ViewSequence()
		{	
		}
		public function initialize( $data:ViewSequenceData ):void
		{
			this.data = $data;
			this._sequence = new SuperArray( this.data.sequence );
			this._queue();
		}
		
		private function _queue():void
		{
			
			this._views = new SuperArray();
			var viewProxy:ViewProxy;
			for each( var flowData:ViewFlowData in this._sequence.getSelected() ) {
				viewProxy = new ViewProxy( flowData );
				viewProxy.addEventListener( ViewSequenceEvent.SEQUENCE_COMPLETE, this._onFlowComplete );
				this._views.push( viewProxy );
				viewProxy.initialize();
			}
		}
		private function _dequeue():void
		{
			for each( var viewProxy:ViewProxy in this._views.source ) {
				viewProxy.removeEventListener( ViewSequenceEvent.SEQUENCE_COMPLETE, this._onFlowComplete );
			}
		}
		private function _next():void
		{
			if ( this._sequence.hasNext() ) {
				this._dequeue();
				this._sequence.selectNext();
				this._queue();
			} else {
				this._dequeue();
				this.dispatchEvent( new ViewSequenceEvent( ViewSequenceEvent.SEQUENCE_COMPLETE, this ) );
			}
		}
		private function _isFlowComplete():Boolean
		{
			for each( var viewProxy:ViewProxy in this._views.source ) {
				if ( !viewProxy.complete ) {
					return false;
				}
			}
			return true;
		}
		/*
		Manager Event Listening
		*/
		private function _onFlowComplete( $event:Event ):void
		{
			if ( this._isFlowComplete() ) {
				this._next();
			}
		}
		
		/*
		Property Definitions
		*/
		public function get complete():Boolean
		{
			return !this._sequence.hasNext();
		}
	}

}
	import com.bedrock.framework.plugin.storage.SuperArray;
	import com.bedrock.framework.core.base.DispatcherBase;
	import flash.events.Event;
	import com.bedrock.framework.plugin.view.ViewFlowData;
	import com.bedrock.framework.plugin.view.ViewEvent;
	import com.bedrock.framework.plugin.view.ViewSequenceEvent;

class ViewProxy extends DispatcherBase 
{
	public var data:ViewFlowData;
	public var flow:SuperArray;
	public var complete:Boolean;
	
	public function ViewProxy( $data:ViewFlowData )
	{
		this.data = $data;
		this.flow = new SuperArray( this.data.flow );
		this.complete = false;
	}
	public function initialize():void
	{
		this.data.view.addEventListener(ViewEvent.INITIALIZE_COMPLETE, this._onInitializeComplete);
		this.data.view.addEventListener(ViewEvent.INTRO_COMPLETE, this._onIntroComplete);
		this.data.view.addEventListener(ViewEvent.OUTRO_COMPLETE, this._onOutroComplete);
		this.data.view.addEventListener(ViewEvent.CLEAR_COMPLETE, this._onClearComplete);
		
		this._queue();
	}
	private function _queue():void
	{
		switch ( this.flow.getSelected() ) {
			case ViewFlowData.INITIALIZE :
				if ( !this.data.view.hasInitialized ) {
					this.data.view.initialize( this.data.initializeData );
				} else {
					this._next();
				}
				break;
			case ViewFlowData.INTRO :
				this.data.view.intro( this.data.introData );
				break;
			case ViewFlowData.OUTRO :
				this.data.view.outro( this.data.outroData );
				break;
			case ViewFlowData.CLEAR :
				this.data.view.clear();
				break;
			case ViewFlowData.HOLD :
				this.flow.selectNext();
				break;
		}
	}
	private function _dequeue():void
	{
		this.data.view.removeEventListener(ViewEvent.INITIALIZE_COMPLETE, this._onInitializeComplete);
		this.data.view.removeEventListener(ViewEvent.INTRO_COMPLETE, this._onIntroComplete);
		this.data.view.removeEventListener(ViewEvent.OUTRO_COMPLETE, this._onOutroComplete);
		this.data.view.removeEventListener(ViewEvent.CLEAR_COMPLETE, this._onClearComplete);
	}
	private function _next():void
	{
		if ( this.flow.hasNext() ) {
			this.flow.selectNext();
			this._queue();
		} else {
			this._dequeue();
			this.complete = true;
			this.dispatchEvent( new ViewSequenceEvent( ViewSequenceEvent.SEQUENCE_COMPLETE, this ) );
		}
	}
	/*
	Event Handlers
	*/
	private  function _onInitializeComplete($event:ViewEvent):void
	{
		this.dispatchEvent( new ViewEvent( ViewEvent.INITIALIZE_COMPLETE, this ) );
		this._next();
	}
	private  function _onIntroComplete($event:ViewEvent):void
	{
		this.dispatchEvent( new ViewEvent( ViewEvent.INTRO_COMPLETE, this ) );
		this._next();
	}
	private function _onOutroComplete($event:ViewEvent):void
	{
		this.dispatchEvent( new ViewEvent( ViewEvent.OUTRO_COMPLETE, this ) );
		this._next();
	}
	private function _onClearComplete($event:ViewEvent):void
	{
		this.dispatchEvent( new ViewEvent( ViewEvent.CLEAR_COMPLETE, this ) );
		this._next();
	}
	
}

