package com.bedrock.framework.engine.command
{
	import com.bedrock.framework.core.command.Command;
	import com.bedrock.framework.core.command.ICommand;
	import com.bedrock.framework.core.event.GenericEvent;
	import com.bedrock.framework.engine.BedrockEngine;
	import com.bedrock.framework.engine.data.BedrockData;

	public class ShowBlockerCommand extends Command implements ICommand
	{
		public function ShowBlockerCommand()
		{
		}
		public  function execute($event:GenericEvent):void
		{
			BedrockEngine.containerManager.getContainer( BedrockData.OVERLAY ).getChildByName( BedrockData.BLOCKER ).show();
		}
	}

}