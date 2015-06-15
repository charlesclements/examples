package com.bedrock.framework.engine.data
{
	import com.bedrock.framework.engine.BedrockEngine;
	
	
	public class BedrockSequenceData
	{
		public static const NORMAL:String = "normal";
		public static const PRELOAD:String = "preload";
		public static const REVERSE:String = "reverse";
		public static const CUSTOM:String = "custom";
		public static const CROSS:String = "cross";

		public static const INITIAL_LOAD:String = "initialLoad";
		public static const INITIAL_TRANSITION:String = "initialTransition";
		public static const STANDARD_TRANSITION:String = "initialTransition";
		
		public var style:String;
		public var preloader:String;
		public var preloaderTime:Number;
		public var deeplink:String;
		public var type:String;
		private var _incoming:Array;
		private var _outgoing:Array;
		
		
		public function BedrockSequenceData()
		{
			this.type = BedrockSequenceData.STANDARD_TRANSITION;
			this._incoming = new Array;
			this._outgoing = new Array;
			this.style = BedrockSequenceData.NORMAL;
			this.preloader = BedrockData.DEFAULT_PRELOADER;
			this.deeplink = "/" + BedrockData.DEFAULT + "/";
			this.preloaderTime = BedrockEngine.config.getSettingValue( BedrockData.DEFAULT_PRELOADER_TIME );
			this.style = BedrockSequenceData[ BedrockEngine.config.getSettingValue( BedrockData.DEFAULT_TRANSITION_STYLE ) ];
		}
		
		public function appendIncoming( $data:Array ):void
		{
			if ( $data.length > 0 ) {
				this._incoming.push( $data );
			}
		}
		public function appendOutgoing( $data:Array ):void
		{
			if ( $data.length > 0 ) this._outgoing.push( $data );
		}
		
		public function get incoming():Array
		{
			return this._incoming;
		}
		public function get outgoing():Array
		{
			return this._outgoing;
		}
	}
}