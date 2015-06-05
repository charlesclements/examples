package com.bedrock.framework.plugin.view
{
	
	public class ViewSequenceData
	{
		
		private var _sequence:Array;
		public var loop:Boolean;
		
		
		public function ViewSequenceData():void
		{
			this.loop = false;
			this._sequence = new Array;
		}
		
		public function prepend( $data:Array ):void
		{
			if ( $data.length > 0 ) this._sequence.unshift( $data );
		}
		public function append( $data:Array ):void
		{
			if ( $data.length > 0 ) this._sequence.push( $data );
		}
		
		public function get sequence():Array
		{
			return this._sequence;
		}
	}
}