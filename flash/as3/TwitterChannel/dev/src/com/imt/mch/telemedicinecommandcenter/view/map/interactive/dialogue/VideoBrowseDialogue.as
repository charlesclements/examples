package com.imt.mch.TeleMedicineCommandCenter.view.map.interactive.dialogue
{
	import com.imt.mch.TeleMedicineCommandCenter.event.MapEvent;

	public class ConnectionDialogue extends AbstractDialogue
	{
		public function ConnectionDialogue()
		{
			super();
			eventComplete = MapEvent.CLOSE_CONNECT_DIALOGUE;
		}
		
	}
}