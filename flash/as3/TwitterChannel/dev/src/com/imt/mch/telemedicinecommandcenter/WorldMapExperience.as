package com.imt.mch.TeleMedicineCommandCenter
{
	import com.greensock.TweenMax;
	import com.greensock.layout.*;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.LiquidArea;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.ScaleMode;
	import com.greensock.layout.core.LiquidData;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.ScalePlugin;
	import com.greensock.plugins.ThrowPropsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.imt.mch.TeleMedicineCommandCenter.controller.DialogueController;
	import com.imt.mch.TeleMedicineCommandCenter.data.AppData;
	import com.imt.mch.TeleMedicineCommandCenter.data.CommandCenterData;
	import com.imt.mch.TeleMedicineCommandCenter.model.MapStore;
	import com.imt.mch.TeleMedicineCommandCenter.view.MapView;
	import com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.InteractiveView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.ui.Mouse;
	import com.demonsters.debugger.MonsterDebugger;
	
	import net.charlesclements.gadgets.display.SimpleAutoSmoothMovieClip;
	
	import settings.Settings;
	
	public class WorldMapExperience extends MovieClip
	{
		
		public var map:MapView;
		public var branding:MovieClip;
		private var _dialogues:DialogueController;
		private var _interactive:InteractiveView;
		private var _imageHolder:Sprite;
		private var _box:Box;
		
		
		// Constructor
		public function WorldMapExperience()
		{
			
			trace(this)
			super();
			// Start the MonsterDebugger
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "Hello World!");
			
			CommandCenterData.ASSETS_URL = "";
			// Activate Greensock plugins.
			TweenPlugin.activate( [ ScalePlugin, AutoAlphaPlugin, ColorTransformPlugin, GlowFilterPlugin, ThrowPropsPlugin ] );
			// Get the app going.
			setupMap().setupInteractionLayer().setupDialogues().setupStageSizing().setupMousing().setupStore();
			
		}

		
		// Sets up the dialogue boxes for the app.
		private function setupDialogues():WorldMapExperience
		{
			
			_dialogues = new DialogueController;
			addChild( _dialogues );
			_dialogues.initialize();
			return this;
			
		}
		
		
		// Sets up the dialogue boxes for the app.
		private function setupMap():WorldMapExperience
		{
			
			map.initialize();
			return this;
			
		}
		
		
		// Sets up the dialogue boxes for the app.
		private function setupStore():WorldMapExperience
		{
			
			MapStore.getInstance().initialize();
			return this;
			
		}
		
		
		// Sets up the dialogue boxes for the app.
		private function setupInteractionLayer():WorldMapExperience
		{
			
			// Potential solution.
			// Creating a holder on the root to pass in items to be masked from anywhere.
			_imageHolder = new Sprite;
			addChild( _imageHolder );
			_imageHolder.visible = false;
			AppData.GLOBAL_IMAGE_CONTAINER = _imageHolder;
			
			// Set up all the Interactive stuff that has to do with the Map.
			_interactive = new InteractiveView;
			addChild( _interactive );
			_interactive.initialize();
			return this;
			
		}
		
		
		// Sets up the Mouse functionality for the app.
		private function setupMousing():WorldMapExperience
		{
			
			//Mouse.hide();
			return this;
			
		}
		
		
		// 
		private function setupStageSizing():WorldMapExperience
		{
			
			// Need black box to account for background.
			_box = new Box;
			addChildAt( _box, 0 );
			// LiquidStage stuff.
			var ls:LiquidStage = new LiquidStage( this.stage, 1920, 540 );
			ls.attach( map, ls.LEFT_CENTER );
			ls.attach( _interactive, ls.LEFT_CENTER );
			ls.attach( _dialogues, ls.LEFT_CENTER );
			// Area.
			//var area:LiquidArea = new LiquidArea(this, 0, 0, 1920, 540, 0x313f19);
			var area:LiquidArea = new LiquidArea(this, 0, 0, AppData.STAGE_WIDTH, AppData.STAGE_HEIGHT, 0x313f19);
			area.attach( map, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER });
			area.attach( _interactive, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER });
			area.attach( branding, { scaleMode:ScaleMode.PROPORTIONAL_INSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER });
			area.attach( _box, { scaleMode:ScaleMode.STRETCH, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER });
			return this;
			
		}
		
	}
	
}