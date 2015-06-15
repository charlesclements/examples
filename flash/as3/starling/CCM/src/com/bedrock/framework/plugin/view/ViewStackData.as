package com.bedrock.framework.plugin.view
{
	import com.bedrock.framework.core.logging.Logger;
	import com.bedrock.framework.plugin.view.IView;
	
	import flash.display.Sprite;
	
	public class ViewStackData
	{
		public static const FORWARD:String = "forward";
		public static const REVERSE:String = "reverse";
		public static const SELECT:String = "select";
		
		private var _arrStack:Array;
		
		public var container:Sprite;
		public var wrap:Boolean;
		public var manageViewsAsChildren:Boolean;
		
		public var defaultIndex:uint;
		public var defaultID:String;
		
		public var autoStart:Boolean;
		
		public function ViewStackData():void
		{
			this._arrStack = new Array;
			this.defaultIndex = 0;
			this.manageViewsAsChildren = true;
			this.wrap = true;
			this.autoStart = true;
		}
		
		public function addToStack($view:IView, $id:String = null ):void
		{
			Logger.debug( $view );
			this._arrStack.push( { view:$view, id:$id } );
		}
		
		public function get stack():Array
		{
			return this._arrStack;
		}
	}
}