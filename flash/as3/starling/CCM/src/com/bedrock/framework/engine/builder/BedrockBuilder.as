/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
*/
package com.bedrock.framework.engine.builder
{
	
	import com.bedrock.framework.engine.controller.BuildController;
	import com.bedrock.framework.engine.event.BedrockEvent;
	
	import flash.events.Event;
	import com.bedrock.framework.engine.view.BedrockContentView;
	import com.bedrock.framework.plugin.storage.HashMap;
	
	public class BedrockBuilder extends BedrockContentView
	{
		/*
		Variable Declarations
		*/
		private var _buildController:BuildController;
		/*
		Constructor
	 	*/
		public function BedrockBuilder() 
		{
			this.loaderInfo.addEventListener( Event.INIT, this._onBootUp );
		}
		private function _createBuildController():void
		{
			this._buildController = new BuildController;
			this._buildController.addEventListener( BedrockEvent.INITIALIZE_COMPLETE, this._onInitializeComplete );
			this._buildController.initialize( this );
		}
		private function _disposeBuildController():void
		{
			this._buildController.removeEventListener( BedrockEvent.INITIALIZE_COMPLETE, this._onInitializeComplete );
			this._buildController = null;
		}
	 	/*
		Event Handlers
	 	*/
		private function _onBootUp( $event:Event ):void
		{
			this._createBuildController();
		}
		private function _onInitializeComplete( $event:BedrockEvent ):void
		{
			this._disposeBuildController();
		}
		
		
	}
}