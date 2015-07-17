package 
{
	
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import com.imt.assets.Assets;
	import com.imt.framework.core.dispatcher.StarlingDispatcher;
	import com.imt.framework.display.IDisplay;
	import com.imt.framework.engine.controller.StageController;
	import com.imt.framework.event.StarlingSiteEvent;
	import com.imt.framework.gadget.ios.gamecenter.GameCenterGadget;
	import com.imt.model.Storage;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flox.model.FloxModel;
	import net.hires.debug.Stats;
	import starling.core.Starling;
	
	
	//[SWF(frameRate="60", width="1024", height="748", backgroundColor="0x333333")]
	public class ClickClickMayhem extends flash.display.Sprite
	{
		
		
		private var _root:IDisplay;
		private var stats:Stats;
		private var myStarling:Starling;
		public var defaultPic:Bitmap;
		public var w:uint;
		public var h:uint;
		
		
		// Constructor.
		private var _gamecenter:GameCenterGadget;
		
		// Constructor.
		public function ClickClickMayhem()
		{
			
			trace(this);
			
			MonsterDebugger.initialize( this );

			// Init FLOX stuff.
			FloxModel.intialize();
			
			// Set stage dimensions.
			Storage.FLASH_STAGE = stage;
			Storage.WIDTH = stage.stageWidth;
			Storage.HEIGHT = stage.stageHeight;
			
			// Starling
			StarlingDispatcher.addEventListener( StarlingSiteEvent.READY, _onReady );
			StarlingDispatcher.addEventListener( StarlingSiteEvent.ALL_ASSETS_LOADED, _onAllAssetsLoaded );
			myStarling = new Starling( StageController, stage, new Rectangle( 0, 0, Storage.WIDTH, Storage.HEIGHT ) );
			myStarling.antiAliasing = 1;
			myStarling.start();
			
		}
		
		
		private function _onReady(event:StarlingSiteEvent):void
		{
			
			trace(this + " : onEvent : " + event.type);
			StarlingDispatcher.removeEventListener( StarlingSiteEvent.READY, _onReady );
			_root = myStarling.root as IDisplay;
			//_root.initialize( { levels:[ new Stage1 ], assetsPath:"../../../SHARED/"  } );
			_root.initialize( { levels:[ new Stage1 ], assetsPath:""  } );
			
		}
		
		
		private function _onAllAssetsLoaded(event:StarlingSiteEvent):void
		{
			trace(this + " : _onAllAssetsLoaded");
			_root.refresh();
			_root.start();
			// GameCenter stuff.
			// This only works from the IOS device.
			/*
			_gamecenter = new GameCenterGadget;
			addChild( _gamecenter );
			_gamecenter.initialize( { isAIR:false } );
			removeChild( _gamecenter );
			*/
		}
		
		
	}
	
	
}
