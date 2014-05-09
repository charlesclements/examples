package com.bedrock.framework.engine.api
{
	
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	
	public interface IStylesheetManager
	{
		/*
		Parse the StyleSheet
		*/
		function parse( $data:String ):void;
		/*
		Apply Tag
		*/
		function applyTag($text:String, $tag:String):String;
		/*
		Apply Style
		*/
		function applyClass($text:String, $style:String):String;
		/*
		Get Style Object
		*/
		function getStyleAsObject($style:String):Object;
		/*
		Get Text Format Object
		*/
		function getStyleAsTextFormat($style:String):TextFormat;
		/*
		Property Definitions
		*/
		function get styleNames():Array;
		function get data():StyleSheet;
	}
}