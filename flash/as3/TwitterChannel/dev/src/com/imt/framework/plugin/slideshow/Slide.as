/**
 * VERSION: 0.6
 * DATE: 2010-08-19
 * AS3
 * http://www.greensock.com
 * 
 * Copyright 2010, GreenSock. All rights reserved. This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 **/
package com.imt.framework.plugin.slideshow {
	import com.greensock.TweenLite;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Slide extends EventDispatcher {
		public static const CLICK_THUMBNAIL:String = "clickThumbnail";
		
		public var name:String;
		public var thumbnailLoader:ImageLoader;
		public var imageLoader:ImageLoader;
		public var thumbnail:ContentDisplay;
		public var image:Sprite;
		
		public function Slide(name:String, description:String, thumbnailLoader:ImageLoader, imageLoader:ImageLoader) {
			this.name = name;
			this.thumbnailLoader = thumbnailLoader;
			this.imageLoader = imageLoader;
			
			this.thumbnail = thumbnailLoader.content;
			this.thumbnail.addEventListener(MouseEvent.ROLL_OVER, _rollOverThumbnailHandler);
			this.thumbnail.addEventListener(MouseEvent.ROLL_OUT, _rollOutThumbnailHandler);
			this.thumbnail.addEventListener(MouseEvent.CLICK, _clickThumbnailHandler);
			
			_buildImage(description);
		}
		
		//The image is actually a Sprite that contains some description text at the bottom. If it has descriptive text, we put a 30% opaque black bar behind the white text to make it more readable too. 
		private function _buildImage(description:String):void {
			this.image = new Sprite();
			this.image.addChild(this.imageLoader.content);
			this.image.alpha = 0;
			
			if (description != "") {
				
				trace("_buildImage");
				var bgBar:Shape = new Shape();
				bgBar.graphics.beginFill(0x000000, 0.3);
				
				
				
				//new Rectangle(
				
				
				
				bgBar.graphics.drawRect( 0, 0, this.imageLoader.content.width, this.imageLoader.content.height );
				bgBar.graphics.endFill();
				/*
				
				*/
				
				
				bgBar.y = this.image.height - bgBar.height;
				this.image.addChild(bgBar);
				
				
				/*
				var tf:TextField = new TextField();
				tf.defaultTextFormat = new TextFormat("Arial", 12, 0xFFFFFF);
				tf.x = 6;
				tf.y = this.image.height - 20;
				tf.width = this.image.width - 12;
				tf.text = description;
				tf.selectable = false;
				tf.embedFonts = true;
				tf.multiline = false;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				tf.filters = [new GlowFilter(0x000000, 0.8, 8, 8, 2, 2)];
				this.image.addChild(tf);
				*/
				
				
			}
		}
		
		public function dispose():void {
			this.thumbnail.removeEventListener(MouseEvent.ROLL_OVER, _rollOverThumbnailHandler);
			this.thumbnail.removeEventListener(MouseEvent.ROLL_OUT, _rollOutThumbnailHandler);
			this.thumbnail.removeEventListener(MouseEvent.CLICK, _clickThumbnailHandler);
			this.thumbnailLoader.dispose(true);
			this.imageLoader.dispose(true);
		}
		
		public function setShowingStatus(showing:Boolean):void {
			if (showing) {
				TweenLite.to(this.thumbnail, 0.3, {glowFilter:{alpha:1, strength:4, blurX:3, blurY:4, color:0xFFFFFF, quality:1, inner:true}});
			} else {
				TweenLite.to(this.thumbnail, 0.3, {glowFilter:{alpha:0, strength:0, remove:true}});
			}
		}
		
		
		private function _rollOverThumbnailHandler(event:MouseEvent):void {
			TweenLite.to(this.thumbnail, 0.3, {colorTransform:{brightness:1}});
		}
		
		private function _rollOutThumbnailHandler(event:MouseEvent):void {
			TweenLite.to(this.thumbnail, 0.5, {colorTransform:{brightness:0.5}});
		}
		
		private function _clickThumbnailHandler(event:MouseEvent):void {
			dispatchEvent(new Event(CLICK_THUMBNAIL));
		}
		
	}
}