package com.bedrock.framework.plugin.view
{
	public class ViewFlowData
	{
		public static const INITIALIZE:String = "initialize";
		public static const INTRO:String = "intro";
		public static const OUTRO:String = "outro";
		public static const CLEAR:String = "clear";
		public static const HOLD:String = "hold";
		public static const INCOMING:Array = [ ViewFlowData.INITIALIZE, ViewFlowData.INTRO ];
		public static const OUTGOING:Array = [ ViewFlowData.OUTRO, ViewFlowData.CLEAR ];
		public static const ROUND_TRIP:Array = [ ViewFlowData.INITIALIZE, ViewFlowData.INTRO, ViewFlowData.HOLD, ViewFlowData.OUTRO, ViewFlowData.CLEAR ];
		
		public var flow:Array;
		public var view:IView;
		public var autoInitialize:Boolean;
		
		public var initializeData:Object;
		public var introData:Object;
		public var outroData:Object;
		
		public function ViewFlowData( $view:IView, $flow:Array = null )
		{
			this.view = $view;
			this.flow = $flow;
			
			this.autoInitialize = true;
			this.flow = $flow;
			if ( this.flow == null ) this.flow = ViewFlowData.INCOMING;
		}

	}
}