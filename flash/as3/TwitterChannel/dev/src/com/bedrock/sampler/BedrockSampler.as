package com.bedrock.sampler
{
	import com.bedrock.framework.plugin.storage.HashMap;
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	
	public class BedrockSampler extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _testHash:HashMap;
		private var _selectedID:String;
		/*
		Constructor
		*/
		public function BedrockSampler()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.initialize();
		}
		
		public function initialize():void
		{
			this._testHash = new HashMap;
		}
		
		protected function initializeComplete():void
		{
			this.selectTestItem( this._selectedID );
		}
		
		protected function _addTestItem( $id:String, $target:MovieClip ):void
		{
			if ( this._testHash.size == 0 ) this._selectedID = $id;
			this.addChild( $target );
			this._testHash.saveValue( $id, $target );
		}
		private function _getTestItem( $id:String ):MovieClip
		{
			return this._testHash.getValue( $id );
		}
		
		public function selectTestItem( $id:String ):void
		{
			this._selectedID = $id;
			for each( var key:String in this._testHash.getKeys() ) {
				this._getTestItem( key ).visible = false;
			}
			this._getTestItem( this._selectedID ).visible = true;
		}
		
		public function callSelectedTestItem( $function:String, $data:Object ):void
		{
			this._getTestItem( this._selectedID )[ $function ]( $data );
		}
	}
}
