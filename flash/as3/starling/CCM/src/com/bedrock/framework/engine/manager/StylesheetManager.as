package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.engine.api.IStylesheetManager;
	import com.bedrock.framework.engine.event.BedrockEvent;
	
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	public class StylesheetManager extends StandardBase implements IStylesheetManager
	{
		/*
		Variable Declarations
		*/
		private var _data:StyleSheet;
		/*
		Constructor
		*/
		public function StylesheetManager()
		{
		}
		
		/*
		Parse the StyleSheet
		*/
		public function parse( $data:String ):void
		{
			this._data = new StyleSheet();
			this._data.parseCSS( $data );
		}
		/*
		Apply Tag
		*/
		public function applyTag($text:String, $tag:String):String
		{
			return "<" +$tag +">" + $text +"</" +$tag +">";
		}
		/*
		Apply Style
		*/
		public function applyClass($text:String, $class:String):String
		{
			return "<span class='" +$class +"'>" + $text +"</span>";
		}
		/*
		Apply ID
		*/
		public function applyID($text:String, $id:String):String
		{
			return "<span id='" +$id +"'>" + $text +"</span>";
		}
		/*
		Get Style Object
		*/
		public function getStyleAsObject( $style:String ):Object
		{
			return this._data.getStyle( $style );
		}
		/*
		Get Format Object
		*/
		public function getStyleAsTextFormat( $style:String ):TextFormat
		{
			return this._data.transform( this.getStyleAsObject( $style ) );
		}
		/*
		Property Definitions
		*/
		public function get styleNames():Array
		{
			return this._data.styleNames;
		}
		public function get data():StyleSheet
		{
			return this._data;
		}
	}
}