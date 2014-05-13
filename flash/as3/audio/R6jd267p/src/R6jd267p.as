package
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import feathers.examples.componentsExplorer.Main;
	
	import starling.core.Starling;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#4a4137")]
	public class R6jd267p extends Sprite
	{
		
		
		private var _starling:Starling;
		private var _launchImage:Loader;
		private var _savedAutoOrients:Boolean;
		
		
		public function R6jd267p()
		{
			super();
			
			
			trace("HELLO");
			
			Cc.startOnStage(this, "");
			Cc.width = 200;
			Cc.log("Hello world.");
			Cc.log("Do something");
			
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			//this.showLaunchImage();
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
			
			
			
		}
		
		
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			this._starling = new Starling(Main, this.stage);
			this._starling.enableErrorChecking = false;
			//this._starling.showStats = true;
			//this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			this._starling.start();
			if(this._launchImage)
			{
				this._starling.addEventListener("rootCreated", starling_rootCreatedHandler);
			}
			
			//this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function starling_rootCreatedHandler(event:Object):void
		{
			
			
			/*
			
			if(this._launchImage)
			{
				this.removeChild(this._launchImage);
				this._launchImage.unloadAndStop(true);
				this._launchImage = null;
				this.stage.autoOrients = this._savedAutoOrients;
			}
			*/
			
			
		}
		
		
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}
		
		
	}
}