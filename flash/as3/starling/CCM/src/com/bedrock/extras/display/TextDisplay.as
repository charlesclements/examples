package com.bedrock.extras.display
{
	import com.bedrock.framework.core.base.MovieClipBase;
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.engine.event.BedrockEvent;
	import com.bedrock.framework.plugin.data.TextDisplayData;
	import com.bedrock.framework.plugin.util.VariableUtil;
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.TextLine;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.TextFlowTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;

	public class TextDisplay extends MovieClipBase
	{
		/*
		Variable Declarations
		*/
		public var data:TextDisplayData;
		
		private var _objSpanElement:SpanElement;
		private var _objParagraphElement:ParagraphElement;
		private var _objTextFlow:TextFlow;
		private var _objTextLine:TextLine;
		private var _arrTextLines:Array;
		
		private var _bolCreated:Boolean;
		public var background:MovieClip;
		/*
		Constructor
		*/
		public function TextDisplay()
		{
			super( false );
			this.mouseChildren = false;
			this._arrTextLines = new Array;
		}
		/*
		Basic Functions
		*/
		public function initialize( $data:TextDisplayData ):void
		{
			this.data =$data;
			if ( this.background != null ) {
				this.data.width = this.background.width;
				this.data.height = this.background.height;
			}
			this.createBaseElements();
			
			this.populate( this.data.text );
		}
		
		/*
		Creation Functions
		*/
		public function populate( $text:String ):void
		{
			this._objSpanElement.text = $text;
			
			switch ( this.data.mode ) {
				case TextDisplayData.SINGLE_LINE :
					this.createSingleLine();
					break;
				case TextDisplayData.MULTI_LINE :
					this.createMultiline();
					break;
				case TextDisplayData.MULTI_SINGLE_LINE :
					this.createMultiline();
					break;
			}
		}
		/*
		Create Single Line
		*/
		private function createSingleLine():void
		{
			this.removeSingleLines();
			
			var objFactory:TextFlowTextLineFactory  = new TextFlowTextLineFactory();
			objFactory.compositionBounds = new Rectangle( 0, 0, this.data.width, this.data.height );
			objFactory.createTextLines( this.addSingleLines, this._objTextFlow );
		}

		private function addSingleLines($textLine:TextLine):void
		{
			switch ( this.data.mode ) 
			{
				case TextDisplayData.SINGLE_LINE :
					if ( this._arrTextLines.length == 0 ) {
						this._arrTextLines.push( $textLine );
						this.addChild( $textLine );
					}
					break;
				case TextDisplayData.MULTI_SINGLE_LINE :
					this._arrTextLines.push( $textLine );
					this.addChild( $textLine );
					break;
			}
		}
		private function removeSingleLines():void
		{
			var numLength:int = this._arrTextLines.length;
			for( var i:int = 0; i < numLength; i ++ ) {
				this.removeChild( this._arrTextLines.pop() );
			}
		}
		
		private function createBaseElements():void
		{
			var objFormat:TextLayoutFormat = this.createCustomFormat();
			
			this._objSpanElement = new SpanElement();
			this._objSpanElement.format = objFormat;
			
			this._objParagraphElement = new ParagraphElement;
			this._objParagraphElement.format = objFormat;
			this._objParagraphElement.addChild( this._objSpanElement );
			
			this._objTextFlow = new TextFlow();
			this._objTextFlow.format = objFormat;
			this._objTextFlow.addChildAt(0, this._objParagraphElement );
		}
		/*
		Paragraph
		*/
		private function createMultiline():void
		{
			if ( this._objTextFlow.flowComposer.numControllers == 0 ) {
				this._objTextFlow.flowComposer.addController( new ContainerController( this, this.data.width, this.data.height ) );
			}
			this._objTextFlow.flowComposer.updateAllControllers();
		}
		/*
		TextLayoutFormat
		*/
		private function createCustomFormat():TextLayoutFormat
		{
			if ( this.data.styleName != null ) {
				
				if ( this.data.autoStyle ) {
					var objStyle:Object = this.data.styleObject || BedrockEngine.stylesheetManager.getStyleAsObject( this.data.styleName );
					var objFormat:TextLayoutFormat = new TextLayoutFormat();
					for (var s:String in objStyle) {
						objFormat[ s ] = VariableUtil.sanitize( objStyle[ s ] );
					}
				}
				
				if ( this.data.autoLocale ) objFormat.locale = BedrockEngine.config.getSettingValue( BedrockData.CURRENT_LOCALE );
				objFormat.fontLookup = FontLookup.EMBEDDED_CFF;
				objFormat.renderingMode = RenderingMode.CFF;
				
				return objFormat;
			} else {
				return this.createDefaultFormat();
			}
		}
		private function createDefaultFormat():TextLayoutFormat
		{
			var objFormat:TextLayoutFormat = new TextLayoutFormat();
			
			objFormat.direction = Direction.LTR;
			objFormat.color = 0x333333;
			objFormat.fontSize = 12;
			objFormat.fontLookup = FontLookup.EMBEDDED_CFF;
			objFormat.renderingMode = RenderingMode.CFF;
			if ( this.data.autoLocale ) objFormat.locale = BedrockEngine.config.getSettingValue( BedrockData.CURRENT_LOCALE );
			
			return objFormat;
		}
		/*
		Event Handlers
	 	*/
		/*
		Property Definitions
	 	*/
	}
}