package feathers.examples.componentsExplorer.screens
{
	
	import com.junkbyte.console.Cc;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class ProjectsScreen extends PanelScreen
	{

		private var _backButton:Button;
		private var _newProjectButton:Button;
		private var _openProjectButton:Button;
		
		
		public function ProjectsScreen()
		{
			
			Cc.logch("ProjectsScreen", "Constructor" );
			
			
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}

		protected function initializeHandler(event:Event):void
		{
			
			this.layout = new AnchorLayout();

			this._newProjectButton = new Button();
			this._newProjectButton.label = "Create a new project";
			this._newProjectButton.addEventListener(Event.TRIGGERED, newProjectButton_triggeredHandler);
			const buttonGroupLayoutData:AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;
			this._newProjectButton.layoutData = buttonGroupLayoutData;
			this.addChild(this._newProjectButton);
			
			
			
			this.headerProperties.title = "Projects";
			
			
			
			Cc.logch("ProjectsScreen", "isTablet" + DeviceCapabilities.isTablet(Starling.current.nativeStage) );
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				
				
				this._backButton = new Button();
				this._backButton.nameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
				this._backButton.label = "Back";
				this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				this.headerProperties.leftItems = new <DisplayObject>
				[
					this._backButton
				];

				this.backButtonHandler = this.onBackButton;
			}
			
		}

		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}

		private function newProjectButton_triggeredHandler(event:Event):void
		{
			Alert.show("I just wanted you to know that I have a very important message to share with you.", "Alert", new ListCollection(
			[
				{ label: "OK" }
			]));
		}
	}
}
