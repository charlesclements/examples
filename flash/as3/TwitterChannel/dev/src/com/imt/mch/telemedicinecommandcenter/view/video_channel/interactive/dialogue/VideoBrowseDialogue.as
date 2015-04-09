package com.imt.mch.TeleMedicineCommandCenter.view.video_channel.interactive.dialogue
{
	import com.imt.mch.TeleMedicineCommandCenter.event.MapEvent;

	public class VideoBrowseDialogue extends AbstractDialogue
	{
		public function VideoBrowseDialogue()
		{
			super();
			eventComplete = MapEvent.CLOSE_CONNECT_DIALOGUE;
		}
		
	}
}