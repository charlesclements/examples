
package com.bedrock.framework.engine.manager
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.bedrock.framework.core.base.DispatcherBase;
	import com.bedrock.framework.engine.api.IDeeplinkingManager;
	import com.bedrock.framework.engine.event.BedrockEvent;
	import com.bedrock.framework.plugin.util.VariableUtil;
	
	public class DeeplinkingManager extends DispatcherBase implements IDeeplinkingManager
	{
		/*
		Variable Declarations
		*/
		private var _changeEnabled:Boolean;
		/*
		Constructor
		*/
		public function DeeplinkingManager()
		{
			
		}

		public function initialize():void
		{
			this._changeEnabled = false;
			SWFAddress.addEventListener(SWFAddressEvent.INIT, this._onDeeplinkingInitialized );
			SWFAddress.initialize();
			SWFAddress.addEventListener(SWFAddressEvent.EXTERNAL_CHANGE, this._onChangeNotification);
		}
		
		/*
		Enable/ Disable Change Event
		*/
		public function enableChangeHandler():void
		{
			this._changeEnabled = true;
			
		}
		public function disableChangeHandler():void
		{
			this._changeEnabled = false;
		}
		
		private function _getDetailObject():Object
		{
			var objDetails:Object = new Object();
			objDetails.parameters = this.getParametersAsObject();
			objDetails.query = this.getQueryString();
			objDetails.path = this.getPath();
			objDetails.paths = this.getPathNames();
			return objDetails;
		}
		/*
		Returns everything currently in the address bar
		*/
		public function getAddress():String
		{
			return SWFAddress.getValue();
		}
		public function setAddress($value:String):void
		{
			SWFAddress.setValue($value);
		}
		public function clearAddress():void
		{
			this.setAddress("");
		}
		/*
		
		
		Wrapper functions
		
		
		*/
		public function getTitle():String
		{
			return SWFAddress.getTitle();
		}
		public function setTitle($title:String):void
		{
			SWFAddress.setTitle($title);
		}
		/*
		
		Status bar functions 
		
		*/
		public function getStatus():String
		{
			return SWFAddress.getStatus();
		}
		public function setStatus($status:String):void
		{
			SWFAddress.setStatus($status);
		}
		public function resetStatus():void
		{
			SWFAddress.resetStatus();
		}
		/*
		
		Path functions
		
		*/
		public function getPath():String
		{
			return SWFAddress.getPath();
		}
		public function setPath($path:String):void
		{
			SWFAddress.setValue( $path);
		}
		public function clearPath():void
		{
			SWFAddress.setValue("");
		}
		public function getPathNames():Array
		{
			return SWFAddress.getPathNames();
		}
		/*
		
		Query string functions
		
		*/
		public function setQueryString($query:String):void
		{
			var strAddress:String=this.getAddress();
			if (strAddress.indexOf("?") != -1) {
				var strBeginning:String=strAddress.substr(0,strAddress.indexOf('?'));
				this.setAddress(strBeginning + $query);
			} else {
				this.setAddress(strAddress + "?" + $query);
			}
		}
		public function getQueryString():String
		{
			return SWFAddress.getQueryString();
		}
		public function clearQueryString():void
		{
			var strAddress:String=this.getAddress();
			var arrDivision:Array=strAddress.split("?");
			this.setAddress( arrDivision[ 0 ] );
		}
		/*
		
		Single Parameter functions
		
		*/
		public function getParameter($parameter:String):*
		{
			return SWFAddress.getParameter($parameter);
		}
		public function populateParameters($query:Object):void
		{
			this.clearQueryString();
			for (var q:String in $query) {
				this.addParameter(q,$query[q]);
			}
		}
		public function addParameter($parameter:String,$value:String):void
		{
			var strAddress:String=this.getAddress();
			if (strAddress.indexOf("?") != -1) {
				strAddress+= "&" + $parameter + "=" + $value;
			} else {
				strAddress+= "?" + $parameter + "=" + $value;
			}
			this.setAddress(strAddress);
		}
		public function setParameter($parameter:String,$value:String):void
		{
			var objQuery:Object=this.getParametersAsObject();
			if (objQuery[$parameter] != undefined) {
				objQuery[$parameter]=$value;
				this.populateParameters(objQuery);
			} else {
				this.addParameter($parameter,$value);
			}
		}
		public function getParametersAsObject():Object
		{
			var strQuery:String=this.getQueryString() || "";
			var objQuery:Object=new Object;
			var arrValuePairs:Array=strQuery.split("&");
			var tmpPreviousResult:*;
			for (var i:* in arrValuePairs) {
				var arrPair:Array=arrValuePairs[i].split("=");


				var tmpValueName:String = arrPair[0];
				var tmpValueClean:* = VariableUtil.sanitize(arrPair[1]);

				// Look for an existing value by that name

				if (objQuery[tmpValueName] != null) {

					//If found and is Array push value else, create array and push value

					if (objQuery[tmpValueName] is Array) {
						objQuery[tmpValueName].push(tmpValueClean);
					} else {
						//create new array
						tmpPreviousResult = objQuery[tmpValueName];
						objQuery[tmpValueName] = new Array();
						objQuery[tmpValueName].push(tmpPreviousResult);
						objQuery[tmpValueName].push(tmpValueClean);
					}
				} else {
					objQuery[tmpValueName]=tmpValueClean;
				}
			}
			return objQuery;
		}
		/*
		Returns all the names of the query string parameters
		*/
		public function getParameterNames():Array
		{
			return SWFAddress.getParameterNames();
		}
		/*
		Clears a single parameter
		*/
		public function clearParameter($parameter:String):void
		{
			var objQuery:Object=this.getParametersAsObject();
			delete objQuery[$parameter];
			this.populateParameters(objQuery);
		}
		
		/*
		Event Handlers
		*/
		private function _onChangeNotification( $event:SWFAddressEvent ):void
		{
			if ( this._changeEnabled ) this.dispatchEvent(new BedrockEvent(BedrockEvent.DEEPLINK_CHANGE, this, this._getDetailObject()));
		}		
		private function _onDeeplinkingInitialized( $event:SWFAddressEvent ):void
		{
			this.dispatchEvent(new BedrockEvent(BedrockEvent.DEEPLINKING_INITIALIZED, this, this._getDetailObject()));
		}		
	}
}