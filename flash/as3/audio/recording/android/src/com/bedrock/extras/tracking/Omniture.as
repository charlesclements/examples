package com.bedrock.extras.tracking
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.plugin.tracking.ITrackingService;
	
	import flash.external.ExternalInterface;
	
	public class Omniture extends StandardBase implements ITrackingService
	{
		/*
		Constructor
		*/
		public function Omniture()
		{
			
		}
		/**
		 * Will make the call to javascript using the external interface.
		 * @param $details Generic object will all of the necessary information for the tracking.
		 */		 
		public function track($details:Object):void 
		{
	    	if (ExternalInterface.available && $details) {
	    		this.status($details);
	    		ExternalInterface.call("TMSSite.analytics.sendEvent", $details);	
	    	}	    	 
		}
	}
}