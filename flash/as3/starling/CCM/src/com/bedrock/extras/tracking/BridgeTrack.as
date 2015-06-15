package com.bedrock.extras.tracking
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.plugin.tracking.ITrackingService;
	
	import flash.external.ExternalInterface;

	public class BridgeTrack extends StandardBase implements ITrackingService
	{
		public function BridgeTrack()
		{
		}
		public function track($details:Object):void
		{
			if (ExternalInterface.available) {
				this.status($details);
				ExternalInterface.call("doBridgeTrackMovieEvent", $details.event);
			}
		}
	}
}