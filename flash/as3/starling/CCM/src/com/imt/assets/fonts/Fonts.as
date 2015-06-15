/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package com.imt.assets.fonts
{
	//import com.hsharma.hungryHero.customObjects.Font;
	
	//import com.imt.framework.display.ui.Font;
	
	import com.greensock.loading.ImageLoader;
	import com.imt.assets.Assets;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	//import starling.textures.TextureAtlas;
	
	/**
	 * This class embeds the bitmap fonts used in the game. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Fonts
	{
		/**
		 *  Regular font used for UI.
		 */		
		//[Embed(source="fontRegular.png")]
		
		
		//[Embed(source = "C:/Windows/Fonts/Verdana.ttf", fontName = "Verdana", fontWeight = "bold", advancedAntiAliasing = "true", mimeType = "application/x-font")] 
		
		
		
		
		/*
		[Embed(source="fontRegular.png")]
		public static const Font_Regular:Class;
		
		[Embed(source="fontRegular.fnt", mimeType="application/octet-stream")]
		public static const XML_Regular:Class;
		
		[Embed(source="fontScoreLabel.png")]
		public static const Font_ScoreLabel:Class;
		
		[Embed(source="fontScoreLabel.fnt", mimeType="application/octet-stream")]
		public static const XML_ScoreLabel:Class;
		
		[Embed(source="fontScoreValue.png")]
		public static const Font_ScoreValue:Class;
		
		[Embed(source="fontScoreValue.fnt", mimeType="application/octet-stream")]
		public static const XML_ScoreValue:Class;
		*/
			
			
			
			
		/**
		 * Font objects.
		 */
/*		
		private static var Regular:BitmapFont;
		private static var ScoreLabel:BitmapFont;
		private static var ScoreValue:BitmapFont;
*/		
		private static var ChildrenArray:Array = [];
		private static var ChildrenDictionary:Dictionary = new Dictionary;
		
		
		/**
		 * Returns the BitmapFont (texture + xml) instance's fontName property (there is only oneinstance per app).
		 * @return String 
		 */
		
		/*
		public static function getFont(_fontStyle:String):Font
		{
			if (Fonts[_fontStyle] == undefined)
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_" + _fontStyle]());
				var xml:XML = XML(new Fonts["XML_" + _fontStyle]());
				Fonts[_fontStyle] = new BitmapFont(texture, xml);
				TextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return new Font(Fonts[_fontStyle].name, Fonts[_fontStyle].size);
		}
		public static function getFont(_fontStyle:String, _textureImage:Bitmap, _atlasXML:XML):Font
		{
			
			if (ChildrenDictionary[_fontStyle] == undefined)
			{
				
				ChildrenDictionary[ _fontStyle ] = new BitmapFont( Texture.fromBitmap(_textureImage), _atlasXML );
				TextField.registerBitmapFont(ChildrenDictionary[_fontStyle]);
				
			}
			var f:Font = new Font(ChildrenDictionary[_fontStyle].name, ChildrenDictionary[_fontStyle].size);
			return f;
		}
		*/
		
		public static function getFont($key:String):Font
		{
			
			trace("Fonts - getFont " + $key);
			if( ChildrenDictionary[ $key ] == undefined ) throw( "The Font " + $key + " was never created!" );
			return ChildrenDictionary[ $key ] as Font;
			
		}
		
		
		
		
		public static function createFont(_fontStyle:String, _textureImage:Bitmap, _atlasXML:XML):Font
		{
			
			trace("Fonts - createFont " + _fontStyle);
			if (ChildrenDictionary[_fontStyle] == undefined)
			{
				
				var b:BitmapFont = new BitmapFont( Texture.fromBitmap(_textureImage), _atlasXML );
				TextField.registerBitmapFont( b, _fontStyle );
				ChildrenDictionary[ _fontStyle ] = new Font( _fontStyle, 30 );
			}
			trace(ChildrenDictionary[ _fontStyle ]);
			return ChildrenDictionary[ _fontStyle ];
			
		}
		
		
		
		
		
		
		
		
		
		
	}
}

