package assets
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import oak.interfaces.IDestroyable;
	
	[Embed(source="/../assets/background.jpg", mimeType="image/jpeg")]
	public class BackgroundAsset extends Bitmap implements IDestroyable
	{
		private var _destroyed:Boolean;
		
		public function BackgroundAsset()
		{
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			
			smoothing = true;
		}
		
		private function _addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			
			stage.addEventListener(Event.RESIZE, _resizeHandler);
			
			_resizeHandler();
		}
		
		private function _resizeHandler(event:Event = null):void
		{
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
		
		public function destroy():void
		{
			if (_destroyed) return;
			
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			stage.removeEventListener(Event.RESIZE, _resizeHandler);
			
			bitmapData.dispose();
			
			_destroyed = true;
		}
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
	}
}