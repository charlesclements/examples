package com.bedrock.extras.data
{
	import com.bedrock.framework.core.base.StandardBase;
	
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;

	public class Cookie extends StandardBase		/*
		Variable Declarations
		*/
		private var _shared:SharedObject;
		private var _id:String;
		/*
		Constructor
		*/
		public function Cookie($id:String)
		{
			this._id = $id;
			this._shared = SharedObject.getLocal( this._id );
		}
		/*
		Clear Object
		*/
		public function clear():void
		{
			this._shared.clear();
		}
		/*
		Getter and Setter
		*/
		public function saveValue($id:String, $value:*):Boolean
		{
			this._shared.data[$id] = $value;
			return this.flushValues();
		}
		public function getValue($id:String):*
		{
			return this._shared.data[$id];
		}
		/*
		Import/ Export
		*/
		public function importValues($data:Object):void
		{
			var objData:Object = $data;
			for (var d:* in objData) {
				this._shared.data[d] = objData[d];
			}
			this.flushValues();
		}
		public function exportValues():Object
		{
			var objData:Object = new Object;
			for (var d:* in this._shared.data) {
				objData[d] = this._shared.data[d];
			}
			return objData;
		}
		/*
		Process Flush Result
		*/
		private function _flushValues():Boolean
		{
			try {
				return this.processResult(this._shared.flush());
			} catch($error:Error){
				this.warning("Cannot save!");
			}
			return false;
		}
		private function _processResult($result:String):Boolean
		{
			var bolStatus:Boolean
			switch($result){
				case SharedObjectFlushStatus.FLUSHED:
					bolStatus = true;
					break;
				case SharedObjectFlushStatus.PENDING:
					bolStatus = false;
					break;
			}
			return bolStatus;
		}
		
		
	}
}