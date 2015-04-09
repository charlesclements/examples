package com.bedrock.framework.engine.controller
{
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.bedrock;
	import com.bedrock.framework.engine.data.BedrockAssetGroupData;
	import com.bedrock.framework.engine.data.BedrockContentData;
	import com.bedrock.framework.engine.data.BedrockContentGroupData;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.engine.data.BedrockSequenceData;
	import com.bedrock.framework.engine.event.BedrockEvent;
	import com.bedrock.framework.engine.view.BedrockContentDisplay;
	import com.bedrock.framework.engine.view.IPreloader;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	import com.bedrock.framework.plugin.view.*;
	
	import flash.events.Event;
	
	public class TransitionController extends DispatcherBase
	{
		/*
		Variable Declarations
		*/
		private var _bedrockSequenceData:BedrockSequenceData;
		private var _viewSequence:ViewSequence;
		private var _viewSequenceData:ViewSequenceData;
		
		private var _shellView:*;
		private var _preloader:IPreloader;
		private var _initialTransitionComplete:Boolean;
		/*
		Constructor
		*/
		public function TransitionController()
		{
		}
		/*
		Basic view functions
	 	*/
		public function initialize( $shellView:* ):void
		{
			this._initialTransitionComplete = false;
			
			this._shellView = $shellView;
			
			this._viewSequence = new ViewSequence;
			this._viewSequence.addEventListener( ViewSequenceEvent.SEQUENCE_COMPLETE, this._onSequenceComplete );
			
			BedrockDispatcher.addEventListener( BedrockEvent.PREPARE_INITIAL_TRANSITION, this._onPrepareInitialTransition );
			BedrockDispatcher.addEventListener( BedrockEvent.PREPARE_INITIAL_LOAD, this._onPrepareInitialLoad );
			BedrockDispatcher.addEventListener( BedrockEvent.TRANSITION, this._onTransition );
			
			if ( BedrockEngine.config.getSettingValue( BedrockData.DEEPLINKING_ENABLED ) && BedrockEngine.config.getSettingValue( BedrockData.DEEPLINK_CONTENT ) ) {
				BedrockDispatcher.addEventListener( BedrockEvent.DEEPLINK_CHANGE, this._onDeeplinkChange );
			}
			
		}
		/*
		Initial Run Functions
		*/
		public function _prepareInitialLoad():void
		{
			for each( var assetGroup:BedrockAssetGroupData in BedrockEngine.assetManager.filterGroups( true, BedrockData.INITIAL_LOAD ) ) {
				BedrockEngine.loadController.appendAssetGroup( assetGroup );
			}
			
			for each( var data:BedrockContentData in BedrockEngine.contentManager.filterContents( true, BedrockData.INITIAL_LOAD ) ) {
				if ( data is BedrockContentGroupData ) {
					for each( var subData:BedrockContentData in data.contents ) {
						BedrockEngine.loadController.appendContent( subData );
					}
				} else {
					BedrockEngine.loadController.appendContent( data );
				}
			}
		}
		private function _prepareInitialTransition( $details:Object ):void
		{
			this._bedrockSequenceData = new BedrockSequenceData;
			var deeplinkPath:String;
			var deeplinkEnabled:Boolean = ( BedrockEngine.config.getSettingValue( BedrockData.DEEPLINKING_ENABLED ) && BedrockEngine.config.getSettingValue( BedrockData.DEEPLINK_CONTENT ) );
			if ( deeplinkEnabled ) deeplinkPath = BedrockEngine.deeplinkingManager.getPath();
			deeplinkEnabled = ( deeplinkEnabled && deeplinkPath != this._bedrockSequenceData.deeplink && deeplinkPath != "/" && deeplinkPath != null );
			
			var idEnabled:Boolean = ( $details.id != null && BedrockEngine.contentManager.hasContent( $details.id ) );
			
			this._bedrockSequenceData.preloader = BedrockData.INITIAL_PRELOADER;
			this._bedrockSequenceData.preloaderTime = BedrockEngine.config.getSettingValue( BedrockData.INITIAL_PRELOADER_TIME );
			
			var defaultContent:Array = BedrockEngine.contentManager.filterContents( true, BedrockData.INITIAL_TRANSITION );
			this._appendIndexedContent( defaultContent, "incoming", false );
			
			var content:BedrockContentData;
			if ( !deeplinkEnabled && !idEnabled ) {
				this._appendIndexedContent( defaultContent, "incoming" );
			} else if ( deeplinkEnabled ) {
				content = BedrockEngine.contentManager.filterContents( deeplinkPath, "deeplink" )[ 0 ];
				if ( content != null ) {
					this._bedrockSequenceData.deeplink = content.deeplink;
					this._bedrockSequenceData.appendIncoming( [ content ] );
				} else {
					this._appendIndexedContent( defaultContent, "incoming" );
				}
			} else if ( idEnabled ) {
				content = BedrockEngine.contentManager.getContent( $details.id );
				this._bedrockSequenceData.deeplink = content.deeplink;
				this._bedrockSequenceData.appendIncoming( [ content ] );
			}
			this.runTransition();
		}
		private function _prepareDeeplinkTransition( $details:Object ):void
		{
			this._bedrockSequenceData = new BedrockSequenceData;
			var content:Object = BedrockEngine.contentManager.filterContents( $details.path, "deeplink" )[ 0 ];
			if ( $details.style != null ) this._bedrockSequenceData.style = $details.style;
			
			if ( content != null ) {
				return this._prepareStandardTransition( content );
			} else if ( $details.path == this._bedrockSequenceData.deeplink ) {
				var defaultContent:Array = BedrockEngine.contentManager.filterContents( true, BedrockData.INITIAL_TRANSITION );
				this._appendIndexedContent( defaultContent, "incoming" );
				this._appendOutgoingContent( $details );
				
				this.runTransition();
			}
		}
		private function _prepareStandardTransition( $details:Object ):void
		{
			this._bedrockSequenceData = new BedrockSequenceData;
			
			var isGood:Boolean = true;
			if ( !BedrockEngine.contentManager.hasContent( $details.incoming || $details.id ) ) {
				this.warning( "Content \"" + ( $details.incoming || $details.id ) + "\" does not exist!" );
				isGood = false;
			}
			if ( this._isContentInHistory( $details.incoming || $details.id ) ) {
				this.warning( "Content \"" + ( $details.incoming || $details.id ) + "\" is already being viewed!" );
				isGood = false;
			}
			
			if ( isGood ) {
				if ( $details.preloader != null ) this._bedrockSequenceData.preloader = $details.preloader;
				if ( $details.preloaderTime != null ) this._bedrockSequenceData.preloaderTime = $details.preloaderTime;
				if ( $details.style != null ) this._bedrockSequenceData.style = $details.style;
				
				this._appendIncomingContent( $details );
				this._appendOutgoingContent( $details );
				
				this.runTransition();
			}
			
		}
		/*
		Appends
		*/
		private function _appendIncomingContent( $details:Object ):void
		{
			var data:BedrockContentData = BedrockEngine.contentManager.getContent( $details.incoming || $details.id );
			this._bedrockSequenceData.deeplink = $details.deeplink || data.deeplink;
			data.container = $details.container || data.container;
			
			this._bedrockSequenceData.appendIncoming( [ data ] );
		}
		
		private function _appendOutgoingContent( $details:Object ):void
		{
			var data:BedrockContentData;
			if ( $details.outgoing != null ) data = BedrockEngine.contentManager.getContent( $details.outgoing );
			if ( data == null ) {
				for each( var queue:Array in BedrockEngine.history.current.incoming ) {
					this._appendIndexedContent( queue, "outgoing" );
				}
			} else {
				this._bedrockSequenceData.appendOutgoing( [ data ] );
			}
		}
		/*
		Utility Functions
		*/
		private function _appendIndexedContent( $queue:Array, $flow:String, $indexed:Boolean = true ):void
		{
			var result:Array = ArrayUtil.filter( $queue, $indexed, BedrockData.INDEXED );
			if ( result.length > 0 ) {
				switch( $flow ) {
					case "incoming" :
						this._bedrockSequenceData.appendIncoming( result );
						break;
					case "outgoing" :
						this._bedrockSequenceData.appendOutgoing( result );
						break;
				}
			}
		}
		
		
		private function _isContentInHistory( $id:String ):Boolean
		{
			for each ( var queue:Array in BedrockEngine.history.current.incoming ) {
				for each ( var data:BedrockContentData in queue ) {
					if ( data is BedrockContentGroupData ) {
						if ( data.id == $id ) return true;
						for each( var subData:BedrockContentData in data.contents ) {
							if ( subData.id == $id ) return true;
						}
					} else {
						if ( data.id == $id ) return true;
					}
				}
			}
			return false;
		}
		
		
		/*
		Initial Run Functions
		*/
		public function runShellTransition():void
		{
			this._bedrockSequenceData = new BedrockSequenceData;
			this._bedrockSequenceData.preloader = BedrockData.INITIAL_PRELOADER;
			this._bedrockSequenceData.preloaderTime = BedrockEngine.data.initialPreloaderTime;
			
			this._preparePreloader();
			
			BedrockEngine.deeplinkingManager.disableChangeHandler();
			
			BedrockEngine.loadController.addEventListener( BedrockEvent.LOAD_COMPLETE, this._onLoadComplete );
			BedrockEngine.loadController.addEventListener( BedrockEvent.LOAD_PROGRESS, this._onLoadProgress );
			
			this._viewSequenceData = new ViewSequenceData;
			this._viewSequenceData.append( [ new ViewFlowData( this._preloader, ViewFlowData.ROUND_TRIP ) ] );
			this._viewSequenceData.append( [ new ViewFlowData( this._shellView, ViewFlowData.INCOMING ) ] );
			
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.TRANSITION_PREPARED, this ) );
			this._viewSequence.initialize( this._viewSequenceData );
		}
		public function runTransition():void
		{
			BedrockEngine.history.appendItem( this._bedrockSequenceData );
			
			BedrockEngine.deeplinkingManager.disableChangeHandler();
			
			BedrockEngine.loadController.addEventListener( BedrockEvent.LOAD_COMPLETE, this._onLoadComplete );
			BedrockEngine.loadController.addEventListener( BedrockEvent.LOAD_PROGRESS, this._onLoadProgress );
			
			this._preparePreloader();
			this._prepareContentLoad();
			this._prepareSequence();
			
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.TRANSITION_PREPARED, this ) );
			
			this._viewSequence.initialize( this._viewSequenceData );
		}
		
		private function _preparePreloader():void
		{
			if ( BedrockEngine.config.getSettingValue( BedrockData.LIBRARY_ENABLED ) ) {
				if ( BedrockEngine.libraryManager.hasPreloader( this._bedrockSequenceData.preloader ) ) {
					this._preloader = BedrockEngine.libraryManager.getPreloader( this._bedrockSequenceData.preloader );
				}
			} else {
				this._preloader = BedrockEngine.libraryManager.getPreloader( BedrockData.INITIAL_PRELOADER );
			}
			this._preloader.addEventListener( ViewEvent.INTRO_COMPLETE, this._onPreloaderIntroComplete );
			this._preloader.addEventListener( ViewEvent.CLEAR_COMPLETE, this._onPreloaderClearComplete );
			BedrockEngine.containerManager.getContainer( BedrockData.PRELOADER ).addChild( this._preloader );
			
			BedrockEngine.bedrock::preloadManager.minimumTime = this._bedrockSequenceData.preloaderTime;
			BedrockEngine.bedrock::preloadManager.preloader = this._preloader;
		}
		
		private function _prepareContentLoad():void
		{
			for each( var queue:Array in this._bedrockSequenceData.incoming ) {
				for each( var data:BedrockContentData in queue ) {
					if ( data is BedrockContentGroupData ) {
						for each( var subData:BedrockContentData in data.contents ) {
							BedrockEngine.loadController.appendContent( BedrockEngine.contentManager.getContent( subData.id ) );
						}
					} else {
						BedrockEngine.loadController.appendContent( BedrockEngine.contentManager.getContent( data.id ) );
					}
				}
			}
		}
		private function _prepareSequence():void
		{
			this._viewSequenceData = new ViewSequenceData;
					
			 switch ( this._bedrockSequenceData.style ) {
				case BedrockSequenceData.NORMAL :
					this._appendFlows( this._bedrockSequenceData.outgoing, ViewFlowData.OUTGOING );
					if ( !BedrockEngine.loadController.empty ) {
						this._viewSequenceData.append( [ new ViewFlowData( this._preloader, ViewFlowData.ROUND_TRIP ) ] );
					} else {
						this._loadComplete();
					}
					if ( !this._initialTransitionComplete ) {
						this._viewSequenceData.append( [ new ViewFlowData( this._shellView, ViewFlowData.INCOMING ) ] );
					}
					this._appendFlows( this._bedrockSequenceData.incoming, ViewFlowData.INCOMING );
					
					break;
				case BedrockSequenceData.PRELOAD :
					if ( !BedrockEngine.loadController.empty ) {
						this._viewSequenceData.append( [ new ViewFlowData( this._preloader, ViewFlowData.ROUND_TRIP ) ] );
					} else {
						this._loadComplete();
					}
					this._appendFlows( this._bedrockSequenceData.outgoing, ViewFlowData.OUTGOING );
					this._appendFlows( this._bedrockSequenceData.incoming, ViewFlowData.INCOMING );
					
					break;
				case BedrockSequenceData.REVERSE :
					if ( !BedrockEngine.loadController.empty ) {
						this._viewSequenceData.append( [ new ViewFlowData( this._preloader, ViewFlowData.ROUND_TRIP ) ] );
					} else {
						this._loadComplete();
					}
					this._appendFlows( this._bedrockSequenceData.incoming, ViewFlowData.INCOMING );
					this._appendFlows( this._bedrockSequenceData.outgoing, ViewFlowData.OUTGOING );
					
					break;
				case BedrockSequenceData.CROSS :
					this._viewSequenceData.append( [ new ViewFlowData( this._preloader, ViewFlowData.ROUND_TRIP ) ] );
					//sequenceData.append.apply( this, this._appendFlows( sequence.incoming ).concat( this._appendOutgoingFlows( sequence.outgoing ) ) );
					
					break;
				case BedrockSequenceData.CUSTOM :
					break;
			}
			
		}
		private function _appendFlows( $sequence:Array, $flow:Array ):void
		{
			var flows:Array;
			for each ( var queue:Array in $sequence ) {
				for each( var data:BedrockContentData in queue ) {
					flows = new Array;
					if ( data is BedrockContentGroupData ) {
						for each ( var subData:BedrockContentData in data.contents ) {
							flows.push( new ViewFlowData( BedrockEngine.loadController.getLoaderContent( subData.id ), $flow ) );
						}
					} else {
						flows.push( new ViewFlowData( BedrockEngine.loadController.getLoaderContent( data.id ), $flow ) );
					}
					this._viewSequenceData.append( flows );
				}
			}
			
		}
		
		
		
		
		private function _prepareIncomingContent():void
		{
			for each( var queue:Array in this._bedrockSequenceData.incoming ) {
				for each( var data:BedrockContentData in queue ) {
					if ( data is BedrockContentGroupData ) {
						for each( var subData:BedrockContentData in data.contents ) {
							this._collectExtras( subData.id );
						}
					} else {
						this._collectExtras( data.id );
					}
					
				}
				
			}
		}
		
		private function _disposePreloader():void
		{
			Object( this._preloader ).parent.removeChild( this._preloader );
			this._preloader = null;
		}
		private function _disposeOutgoingContent():void
		{
			var contentDisplay:BedrockContentDisplay
			for each( var queue:Array in this._bedrockSequenceData.outgoing ) {
				
				for each( var data:BedrockContentData in queue ) {
					if ( data is BedrockContentGroupData ) {
						for each( var subData:BedrockContentData in data.contents ) {
							if ( subData.autoDispose ) BedrockEngine.loadController.disposeContent( subData.id );
						}
					} else {
						if ( data.autoDispose ) BedrockEngine.loadController.disposeContent( data.id );
					}
				}
				
			}
		}
		private function _updateDeeplinking():void
		{
			BedrockEngine.deeplinkingManager.setPath( this._bedrockSequenceData.deeplink );
		}
		
		
		/*
		Collect
		*/
		private function _collectShellExtras():void
		{
			this._shellView.assets = BedrockEngine.loadController.getAssetGroupContents( BedrockData.SHELL );
			if ( BedrockEngine.config.getSettingValue( BedrockData.DATA_BUNDLE_ENABLED ) && BedrockEngine.dataBundleManager.hasBundle( BedrockData.SHELL ) ) {
				this._shellView.bundle = BedrockEngine.dataBundleManager.getBundle( BedrockData.SHELL );
			}
		}
		private function _collectExtras( $id:String ):void
		{
			var contentObj:Object = BedrockEngine.contentManager.getContent( $id );
			
			var contentView:BedrockContentDisplay = BedrockEngine.loadController.getLoaderContent( $id );
			contentView.assets = BedrockEngine.loadController.getAssetGroupContents( contentObj.assetGroup );
			contentView.data = BedrockEngine.contentManager.getContent( $id );
			if ( BedrockEngine.config.getSettingValue( BedrockData.DATA_BUNDLE_ENABLED ) && BedrockEngine.dataBundleManager.hasBundle( $id ) ) {
				contentView.bundle = BedrockEngine.dataBundleManager.getBundle( $id );
			}
		}
		
		private function _loadComplete():void
		{
			if ( !this._initialTransitionComplete ) this._collectShellExtras();
			this._prepareIncomingContent();
			BedrockEngine.bedrock::preloadManager.loadComplete();
		}
		/*
		Event Handlers
		*/
		private function _onPreloaderIntroComplete( $event:ViewEvent ):void
		{
			BedrockEngine.bedrock::preloadManager.loadBegin();
			BedrockEngine.loadController.load();
		}
		private function _onPreloaderClearComplete( $event:ViewEvent ):void
		{
			this._disposePreloader();
			if ( BedrockEngine.config.getSettingValue( BedrockData.DEEPLINK_CONTENT ) ) this._updateDeeplinking();
		}
		
		private function _onLoadComplete($event:BedrockEvent):void
		{
			this._loadComplete();
		}
		private function _onLoadProgress($event:BedrockEvent):void
		{
			BedrockEngine.bedrock::preloadManager.progress = $event.details.progress;
		}
		private function _onSequenceComplete($event:Event):void
		{
			if ( !this._initialTransitionComplete ) {
				this._initialTransitionComplete = true;
			}
			
			BedrockEngine.deeplinkingManager.enableChangeHandler();
			
			BedrockEngine.loadController.removeEventListener( BedrockEvent.LOAD_COMPLETE, this._onLoadComplete );
			BedrockEngine.loadController.removeEventListener( BedrockEvent.LOAD_PROGRESS, this._onLoadProgress );
			
			this.dispatchEvent( new BedrockEvent( BedrockEvent.TRANSITION_COMPLETE, this ) );
			this._disposeOutgoingContent();
		}
		/*
		Global Events
		*/
		private function _onPrepareInitialLoad( $event:BedrockEvent ):void
		{
			this._prepareInitialLoad();
		}
		private function _onPrepareInitialTransition( $event:BedrockEvent ):void
		{
			this._prepareInitialTransition( $event.details || new Object );
		}
		private function _onTransition( $event:BedrockEvent ):void
		{
			this._prepareStandardTransition( $event.details || new Object );
		}
		private function _onDeeplinkChange( $event:BedrockEvent ):void
		{
			this._prepareDeeplinkTransition( $event.details || new Object );
		}
		
	}
}