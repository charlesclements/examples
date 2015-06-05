package com.imt.framework.gadget.text
{
	
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.imt.framework.engine.data.GameData;
	import com.imt.framework.core.event.SiteEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	// When added to the stage, this gadget displays the current code.
	public class CodeDisplay extends TextField
	{

		
		private var _format:TextFormat;
		

		public function CodeDisplay()
		{
			
			super();
			BedrockDispatcher.addEventListener( SiteEvent.NEW_GAME, onEvent );
			autoSize = TextFieldAutoSize.LEFT;
			_format = new TextFormat( null, 30, 0xff00ff );
			
		}
		

		private function onEvent(e:Event):void
		{
			
			switch( e.type )
			{
				case SiteEvent.NEW_GAME:
					text = GameData.CODE;
					setTextFormat( _format, -1, GameData.CODE.length );
					break;
				
			}
			
		}
		
	}
	
}