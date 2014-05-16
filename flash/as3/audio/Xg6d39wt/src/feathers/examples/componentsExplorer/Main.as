package feathers.examples.componentsExplorer
{
	import com.junkbyte.console.Cc;
	
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.examples.componentsExplorer.data.EmbeddedAssets;
	import feathers.examples.componentsExplorer.data.GroupedListSettings;
	import feathers.examples.componentsExplorer.data.ItemRendererSettings;
	import feathers.examples.componentsExplorer.data.ListSettings;
	import feathers.examples.componentsExplorer.data.NumericStepperSettings;
	import feathers.examples.componentsExplorer.data.SliderSettings;
	import feathers.examples.componentsExplorer.data.TextInputSettings;
	import feathers.examples.componentsExplorer.screens.AlertScreen;
	import feathers.examples.componentsExplorer.screens.ButtonGroupScreen;
	import feathers.examples.componentsExplorer.screens.ButtonScreen;
	import feathers.examples.componentsExplorer.screens.CalloutScreen;
	import feathers.examples.componentsExplorer.screens.GroupedListScreen;
	import feathers.examples.componentsExplorer.screens.GroupedListSettingsScreen;
	import feathers.examples.componentsExplorer.screens.ItemRendererScreen;
	import feathers.examples.componentsExplorer.screens.ItemRendererSettingsScreen;
	import feathers.examples.componentsExplorer.screens.LabelScreen;
	import feathers.examples.componentsExplorer.screens.ListScreen;
	import feathers.examples.componentsExplorer.screens.ListSettingsScreen;
	import feathers.examples.componentsExplorer.screens.MainMenuScreen;
	import feathers.examples.componentsExplorer.screens.NumericStepperScreen;
	import feathers.examples.componentsExplorer.screens.NumericStepperSettingsScreen;
	import feathers.examples.componentsExplorer.screens.PageIndicatorScreen;
	import feathers.examples.componentsExplorer.screens.PickerListScreen;
	import feathers.examples.componentsExplorer.screens.ProgressBarScreen;
	import feathers.examples.componentsExplorer.screens.ProjectsScreen;
	import feathers.examples.componentsExplorer.screens.ScrollTextScreen;
	import feathers.examples.componentsExplorer.screens.SliderScreen;
	import feathers.examples.componentsExplorer.screens.SliderSettingsScreen;
	import feathers.examples.componentsExplorer.screens.TabBarScreen;
	import feathers.examples.componentsExplorer.screens.TextInputScreen;
	import feathers.examples.componentsExplorer.screens.TextInputSettingsScreen;
	import feathers.examples.componentsExplorer.screens.ToggleScreen;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class Main extends Drawers
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const PROJECTS:String = "projects";
		private static const ALERT:String = "alert";
		private static const BUTTON:String = "button";
		private static const BUTTON_SETTINGS:String = "buttonSettings";
		private static const BUTTON_GROUP:String = "buttonGroup";
		private static const CALLOUT:String = "callout";
		private static const GROUPED_LIST:String = "groupedList";
		private static const GROUPED_LIST_SETTINGS:String = "groupedListSettings";
		private static const ITEM_RENDERER:String = "itemRenderer";
		private static const ITEM_RENDERER_SETTINGS:String = "itemRendererSettings";
		private static const LABEL:String = "label";
		private static const LIST:String = "list";
		private static const LIST_SETTINGS:String = "listSettings";
		private static const NUMERIC_STEPPER:String = "numericStepper";
		private static const NUMERIC_STEPPER_SETTINGS:String = "numericStepperSettings";
		private static const PAGE_INDICATOR:String = "pageIndicator";
		private static const PICKER_LIST:String = "pickerList";
		private static const PROGRESS_BAR:String = "progressBar";
		private static const SCROLL_TEXT:String = "scrollText";
		private static const SLIDER:String = "slider";
		private static const SLIDER_SETTINGS:String = "sliderSettings";
		private static const TAB_BAR:String = "tabBar";
		private static const TEXT_INPUT:String = "textInput";
		private static const TEXT_INPUT_SETTINGS:String = "textInputSettings";
		private static const TOGGLES:String = "toggles";

		private static const MAIN_MENU_EVENTS:Object =
		{
			
			showProjects: PROJECTS,
			showAlert: ALERT,
			showButton: BUTTON,
			showButtonGroup: BUTTON_GROUP,
			showCallout: CALLOUT,
			showGroupedList: GROUPED_LIST,
			showItemRenderer: ITEM_RENDERER,
			showLabel: LABEL,
			showList: LIST,
			showNumericStepper: NUMERIC_STEPPER,
			showPageIndicator: PAGE_INDICATOR,
			showPickerList: PICKER_LIST,
			showProgressBar: PROGRESS_BAR,
			showScrollText: SCROLL_TEXT,
			showSlider: SLIDER,
			showTabBar: TAB_BAR,
			showTextInput: TEXT_INPUT,
			showToggles: TOGGLES
			
		};
		
		public function Main()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}

		private var _navigator:ScreenNavigator;
		private var _menu:MainMenuScreen;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function initializeHandler(event:Event):void
		{
			EmbeddedAssets.initialize();

			new MetalWorksMobileTheme();
			
			this._navigator = new ScreenNavigator();
			this.content = this._navigator;

			Cc.logch( "Main", "initializeHandler");
			
			//Cc.logch( "Main", PROJECTS);
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(ALERT, new ScreenNavigatorItem(AlertScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(PROJECTS, new ScreenNavigatorItem(ProjectsScreen,
			{
				complete: MAIN_MENU
			}));
			
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(BUTTON, new ScreenNavigatorItem(ButtonScreen,
			{
				complete: MAIN_MENU,
				showSettings: BUTTON_SETTINGS
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(BUTTON_GROUP, new ScreenNavigatorItem(ButtonGroupScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(CALLOUT, new ScreenNavigatorItem(CalloutScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(SCROLL_TEXT, new ScreenNavigatorItem(ScrollTextScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			const sliderSettings:SliderSettings = new SliderSettings();
			this._navigator.addScreen(SLIDER, new ScreenNavigatorItem(SliderScreen,
			{
				complete: MAIN_MENU,
				showSettings: SLIDER_SETTINGS
			},
			{
				settings: sliderSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(SLIDER_SETTINGS, new ScreenNavigatorItem(SliderSettingsScreen,
			{
				complete: SLIDER
			},
			{
				settings: sliderSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(TOGGLES, new ScreenNavigatorItem(ToggleScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			const groupedListSettings:GroupedListSettings = new GroupedListSettings();
			this._navigator.addScreen(GROUPED_LIST, new ScreenNavigatorItem(GroupedListScreen,
			{
				complete: MAIN_MENU,
				showSettings: GROUPED_LIST_SETTINGS
			},
			{
				settings: groupedListSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(GROUPED_LIST_SETTINGS, new ScreenNavigatorItem(GroupedListSettingsScreen,
			{
				complete: GROUPED_LIST
			},
			{
				settings: groupedListSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			const itemRendererSettings:ItemRendererSettings = new ItemRendererSettings();
			this._navigator.addScreen(ITEM_RENDERER, new ScreenNavigatorItem(ItemRendererScreen,
			{
				complete: MAIN_MENU,
				showSettings: ITEM_RENDERER_SETTINGS
			},
			{
				settings: itemRendererSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(ITEM_RENDERER_SETTINGS, new ScreenNavigatorItem(ItemRendererSettingsScreen,
			{
				complete: ITEM_RENDERER
			},
			{
				settings: itemRendererSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(LABEL, new ScreenNavigatorItem(LabelScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			const listSettings:ListSettings = new ListSettings();
			this._navigator.addScreen(LIST, new ScreenNavigatorItem(ListScreen,
			{
				complete: MAIN_MENU,
				showSettings: LIST_SETTINGS
			},
			{
				settings: listSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(LIST_SETTINGS, new ScreenNavigatorItem(ListSettingsScreen,
			{
				complete: LIST
			},
			{
				settings: listSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			const numericStepperSettings:NumericStepperSettings = new NumericStepperSettings();
			this._navigator.addScreen(NUMERIC_STEPPER, new ScreenNavigatorItem(NumericStepperScreen,
			{
				complete: MAIN_MENU,
				showSettings: NUMERIC_STEPPER_SETTINGS
			},
			{
				settings: numericStepperSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(NUMERIC_STEPPER_SETTINGS, new ScreenNavigatorItem(NumericStepperSettingsScreen,
			{
				complete: NUMERIC_STEPPER
			},
			{
				settings: numericStepperSettings
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(PAGE_INDICATOR, new ScreenNavigatorItem(PageIndicatorScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(PICKER_LIST, new ScreenNavigatorItem(PickerListScreen,
			{
				complete: MAIN_MENU
			}));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			this._navigator.addScreen(TAB_BAR, new ScreenNavigatorItem(TabBarScreen,
			{
				complete: MAIN_MENU
			}));

			const textInputSettings:TextInputSettings = new TextInputSettings();
			this._navigator.addScreen(TEXT_INPUT, new ScreenNavigatorItem(TextInputScreen,
			{
				complete: MAIN_MENU,
				showSettings: TEXT_INPUT_SETTINGS
			},
			{
				settings: textInputSettings
			}));
			this._navigator.addScreen(TEXT_INPUT_SETTINGS, new ScreenNavigatorItem(TextInputSettingsScreen,
			{
				complete: TEXT_INPUT
			},
			{
				settings: textInputSettings
			}));

			this._navigator.addScreen(PROGRESS_BAR, new ScreenNavigatorItem(ProgressBarScreen,
			{
				complete: MAIN_MENU
			}));

			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;

			
			
			Cc.logch( "Main", this._navigator.getChildByName( PROJECTS ));
			Cc.logch( "Main", this._navigator.getScreenIDs(  ));
			Cc.logch( "Main", "Length : " + this._navigator.getScreenIDs(  ).length);
			
			
			
			Cc.logch("ProjectsScreen", "isTablet : " + DeviceCapabilities.isTablet(Starling.current.nativeStage) );
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				
				//Cc.logch( "Main", "isTablet : true" );
				
				//we don't want the screens bleeding outside the navigator's
				//bounds when a transition is active, so clip it.
				this._navigator.clipContent = true;
				this._menu = new MainMenuScreen();
				for(var eventType:String in MAIN_MENU_EVENTS)
				{
					this._menu.addEventListener(eventType, mainMenuEventHandler);
				}
				this._menu.height = 400;
				this.leftDrawer = this._menu;
				
				//this.leftDrawer.width = 400;
				this.leftDrawer.width = Starling.current.nativeStage.stageWidth / 3;
				
				
				
				this._minWidth = 30;
				
				//this.leftDrawerDockMode = Drawers.DOCK_MODE_BOTH;
				this.leftDrawerDockMode = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;
				
				
				//this.left
				
				
				
				//this.leftDrawerDockMode = Drawers.AUTO_SIZE_MODE_STAGE;
				
				Cc.logch( "Main", "initializeHandler END" );
				
			}
			else
			{
				//Cc.logch( "Main", "isTablet : false" );
				this._navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen, MAIN_MENU_EVENTS));
				this._navigator.showScreen(MAIN_MENU);
			}
		}

		private function mainMenuEventHandler(event:Event):void
		{
			const screenName:String = MAIN_MENU_EVENTS[event.type];
			//because we're controlling the navigation externally, it doesn't
			//make sense to transition or keep a history
			this._transitionManager.clearStack();
			this._transitionManager.skipNextTransition = true;
			this._navigator.showScreen(screenName);
		}
	}
}