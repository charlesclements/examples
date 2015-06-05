package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.base.SpriteBase;
	import com.bedrock.framework.plugin.storage.HashMap;
	import com.bedrock.framework.plugin.util.ButtonUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	/*
	Class Declarations
	*/
	public class Blocker extends SpriteBase
	{
		private static var __replacements:HashMap;
		/*
		Variable Declarations
		*/
		private var _active:Boolean;
		private var _color:Number;
		/*
		Constructor
		*/
		Blocker.__setupReplacements();
		
		public function Blocker($alpha:Number=0, $color:Number = 0x000000 )
		{
			this.alpha=$alpha;
			this._color = $color;
			this._active=false;
		}
		private static function __setupReplacements():void
		{
			var events:Array=new Array("MOUSE_DOWN","MOUSE_UP","MOUSE_OVER","MOUSE_OUT");
			__replacements=new HashMap;
			//
			var numLength:Number=events.length;
			for (var i:Number=0; i < numLength; i++) {
				__replacements.saveValue(MouseEvent[ events[ i ] ],BlockerEvent[ events[ i ] ] );
			}
		}
		public function show():void
		{
			if (! this.active) {
				this.status("Show");
				this._active=true;
				this.stage.focus = this;
				this.stage.addEventListener( Event.RESIZE, this._onStageResize );
				this.draw();
				this.dispatchEvent(new BlockerEvent( BlockerEvent.SHOW, this ) );
			}
		}
		public function hide():void
		{
			this.status("Hide");
			this._active=false;
			this.clear();
			this.stage.focus = null;
			this.stage.removeEventListener(Event.RESIZE, this._onStageResize);
			this.dispatchEvent(new BlockerEvent(BlockerEvent.HIDE,this));
		}
		public function clear():void
		{
			this.graphics.clear();
			ButtonUtil.removeListeners(this,{down:this._onMouseInteraction,up:this._onMouseInteraction,over:this._onMouseInteraction,out:this._onMouseInteraction},false);
		}
		/*
		Draw the blocker
		*/
		public function draw():void
		{
			if (this.stage) {
				this.graphics.clear();
				this.graphics.moveTo(0,0);
				this.graphics.beginFill( this._color );
				this.graphics.lineTo(this.stage.stageWidth,0);
				this.graphics.lineTo(this.stage.stageWidth,this.stage.stageHeight);
				this.graphics.lineTo(0,this.stage.stageHeight);
				this.graphics.endFill();
				//
				ButtonUtil.addListeners(this,{down:this._onMouseInteraction,up:this._onMouseInteraction,over:this._onMouseInteraction,out:this._onMouseInteraction},false);
				//
			} else {
				this.error("Blocker must be added to stage before it can be shown!");
			}
		}
		/*
		Mouse Handlers
		*/
		private function _onMouseInteraction($event:MouseEvent):void
		{
			if ( $event.type == MouseEvent.MOUSE_DOWN ) {
				this.warning( "Blocker is active!" );
			}
			this.dispatchEvent(new BlockerEvent(Blocker.__replacements.getValue($event.type),this));
		}
		private function _onStageResize($event:Event):void
		{
			this.draw();
		}
		/*
		Property Definitions
		*/
		
		public function get active():Boolean
		{
			return this._active;
		}
	}
}