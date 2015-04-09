package com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.dialogue.nav
{
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.plugin.util.ButtonUtil;
	import com.greensock.TweenMax;
	import com.imt.framework.display.IDisplay;
	import com.imt.mch.TeleMedicineCommandCenter.event.MapEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class TopNavView extends Sprite implements IDisplay
	{
		
		// Textfields.
		public var txtClose:TextField;
		public var txtEdit:TextField;
		public var txtCancel:TextField;
		public var txtSave:TextField;
		
		// Hotspots.
		public var btnClose:MovieClip;
		public var btnEdit:MovieClip;
		public var btnCancel:MovieClip;
		public var btnSave:MovieClip;
		
		
		
		
		public function TopNavView()
		{
			
			trace(this)
			
			
			super();
			
		}
		
		public function initialize():IDisplay
		{
			
			
			
			return this;
			
		}
		
		public function refresh():IDisplay
		{
			
			// Buttons.
			ButtonUtil.addListeners( btnClose, { down:onEvent } );
			ButtonUtil.addListeners( btnEdit, { down:onEvent } );
			ButtonUtil.addListeners( btnCancel, { down:onEvent } );
			ButtonUtil.addListeners( btnSave, { down:onEvent } );
			// Properties.
			txtCancel.visible = false;
			btnCancel.visible = false;
			txtSave.visible = false;
			btnSave.visible = false;
			txtEdit.alpha = 1;
			btnEdit.visible = true;
			return this;
			
		}
		
		public function clear():IDisplay
		{
			
			ButtonUtil.removeListeners( btnClose, { down:onEvent } );
			ButtonUtil.removeListeners( btnEdit, { down:onEvent } );
			ButtonUtil.removeListeners( btnCancel, { down:onEvent } );
			ButtonUtil.removeListeners( btnSave, { down:onEvent } );
			return this;
			
		}
		
		public function start():IDisplay
		{
			return null;
		}
		
		public function intro():IDisplay
		{
			return null;
		}
		
		public function outro():IDisplay
		{
			return null;
		}
		
		public function destroy():IDisplay
		{
			return null;
		}
		
		
		private function onEvent($e:Event):void
		{
			
			switch($e.currentTarget)
			{
				
				case btnClose:
					BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.CLOSE_WINDOW, this, {} ) );
					break;
				
				case btnEdit:
					
					
					
					btnEdit.visible = false;
					TweenMax.to( txtEdit, 0.7, { alpha:0.5 } );
					TweenMax.allFromTo( [ txtCancel, btnCancel, txtSave, btnSave ], 0.7, { autoAlpha:1, colorTransform:{ tint:0xFFFFFF, tintAmount:1 }, immediateRender:true }, { delay:0.3, colorTransform:{ tint:0xFFFFFF, tintAmount:0 }, overwrite:1 } );
					//{ colorTransform:{ tint:0xFFFFFF, tintAmount:1 }, immediateRender:true }, { colorTransform:{ tint:0xFFFFFF, tintAmount:0 }, overwrite:1, onComplete:_onPostResizeComplete } );
					/*
					txtCancel.visible = true;
					btnCancel.visible = true;
					txtSave.visible = true;
					btnSave.visible = true;
					*/
					
					//txtEdit.alpha = 0.5;
					BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.EDIT, this, {} ) );
					break;
				
				case btnCancel:
					/*
					txtCancel.visible = false;
					btnCancel.visible = false;
					txtSave.visible = false;
					btnSave.visible = false;
					txtEdit.alpha = 1;
					btnEdit.visible = true;
					*/
					TweenMax.allTo( [ txtCancel, btnCancel, txtSave, btnSave ], 0.7, { autoAlpha:0, immediateRender:true } );
					TweenMax.allFromTo( [ txtEdit, btnEdit ], 0.7, { autoAlpha:1, colorTransform:{ tint:0xFFFFFF, tintAmount:1 }, immediateRender:true }, { delay:0.3, colorTransform:{ tint:0xFFFFFF, tintAmount:0 }, overwrite:1 } );
					BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.CANCEL, this, {} ) );
					break;
				
				case btnSave:
					/*
					txtCancel.visible = false;
					btnCancel.visible = false;
					txtSave.visible = false;
					btnSave.visible = false;
					txtEdit.alpha = 1;
					btnEdit.visible = true;
					*/
					TweenMax.allTo( [ txtCancel, btnCancel, txtSave, btnSave ], 0.7, { autoAlpha:0, immediateRender:true } );
					TweenMax.allFromTo( [ txtEdit, btnEdit ], 0.7, { autoAlpha:1, colorTransform:{ tint:0xFFFFFF, tintAmount:1 }, immediateRender:true }, { delay:0.3, colorTransform:{ tint:0xFFFFFF, tintAmount:0 }, overwrite:1 } );
					BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.SAVE, this, {} ) );
					break;
				
				default:
					trace(this + " : Unhandled event.");
					break;
				
			}
			
		}
		
	}
	
}