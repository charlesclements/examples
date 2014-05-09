package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.base.SpriteBase;
	import com.bedrock.framework.plugin.util.ArrayUtil;
	
	import flash.display.DisplayObjectContainer;
	

	public class ViewStack extends SpriteBase
	{
		/*
		Variable Declarations
		*/
		public var data:ViewStackData;
		private var _container:DisplayObjectContainer;
		private var _selectedIndex:int;
		private var _viewSequence:ViewSequence;
		/*
		Constructor
		*/
		public function ViewStack()
		{
			this._viewSequence = new ViewSequence;
		}
		public function initialize( $data:ViewStackData ):void
		{
			this.data = $data;
			this._selectedIndex = -1;
		
			this.refresh();
		}
		public function refresh():void
		{
			this.clear();
			this._setContainer( this.data.container );
			
			if ( this.data.manageViewsAsChildren ) {
				for each( var item:Object in this.data.stack ) {
					this._container.addChild( item.view );
				}
			}
			
			if ( this.data.autoStart ) {
				if ( this.data.defaultID != null ) {
					this.selectByID( this.data.defaultID );
				} else {
					this.selectByIndex( this.data.defaultIndex );
				}
			}
		}
		public function clear():void
		{
			if ( this.data != null && this.data.manageViewsAsChildren && this._container != null ) {
				for each( var item:Object in this.data.stack ) {
					if ( this._container.getChildIndex( item.view ) != -1 ) {
						this._container.removeChild( item.view );
					}
				}
			}
		}
		/*
		Set the container where the views will be showing up
		*/
		private function _setContainer( $container:DisplayObjectContainer = null ):void
		{
			this._container = $container || this;
		}
		/*
		Show View
		*/
		public function selectByIndex( $index:int ):void
		{
			var index:int = ( this.data.wrap ) ? ArrayUtil.wrapIndex( $index, this.data.stack.length, true ) : $index;
			var outgoing:Object = this.getByIndex( this._selectedIndex );
			var incoming:Object = this.getByIndex( index );
			this._selectedIndex = index;
			
			this._runSequence( outgoing, incoming );
			this.dispatchEvent( new ViewStackEvent( ViewStackEvent.CHANGE, this, incoming ) );
		}
		public function selectByID( $id:String ):void
		{
			this.selectByIndex( ArrayUtil.findIndex( this.data.stack, $id, "id" ) );
		}
		
		public function deselect():void
		{
			this._runSequence( this.getByIndex( this._selectedIndex ) );
			this._selectedIndex = -1;
		}
		
		private function _runSequence( $outgoing:Object = null, $incoming:Object = null ):void
		{
			var data:ViewSequenceData = new ViewSequenceData;
			if ( $outgoing != null ) data.append( [ new ViewFlowData( $outgoing.view, ViewFlowData.OUTGOING ) ] );
			if ( $incoming != null ) data.append( [ new ViewFlowData( $incoming.view, ViewFlowData.INCOMING ) ] );
			
			if ( $outgoing != null ) this._container.setChildIndex( $outgoing.view, 0 );
			
			this._viewSequence.initialize( data );
			
		}
		/*
		Get View
		*/
		public function getByIndex( $index:int ):Object
		{
			return this.data.stack[ $index ];
		}
		public function getByID( $id:String ):Object
		{
			return this.getByIndex( ArrayUtil.findIndex( this.data.stack, $id, "id" ) );
		}
		
		
		/*
		External Next/ Previous
		*/
		public function selectNext():void
		{
			this.selectByIndex( this._selectedIndex + 1 );
			if ( !this.data.wrap && ( this._selectedIndex + 1 ) >= this.data.stack.length ) {
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.AT_FINISH, this ) );
			}
		}
		public function selectPrevious():void
		{
			this.selectByIndex( this._selectedIndex - 1 );
			if ( !this.data.wrap && ( this._selectedIndex - 1 ) < 0 ) {
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.AT_START, this ) );
			}
		}
		/*
		
		*/
		private function _getDetailObject():Object
		{
			var objData:Object = new Object;
			return objData;
		}
		/*
		Property Definitions
		*/
		public function get selectedIndex():int
		{
			return this._selectedIndex;
		}
	}

}
