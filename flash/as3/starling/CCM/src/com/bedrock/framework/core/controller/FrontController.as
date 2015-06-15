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
package com.bedrock.framework.core.controller
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	
	import flash.utils.getQualifiedClassName;
	import com.bedrock.framework.core.event.GenericEvent;
	import com.bedrock.framework.core.command.ICommand;

	public class FrontController extends StandardBase implements IFrontController
	{
		/*
		Variable Declarations
		*/
		private var _commands:Array;
		/*
		Constructor
		*/
		public function FrontController()
		{
			this._commands=new Array  ;
		}
		
		public function addCommand($type:String,$command:Class):void
		{
			this._commands.push( { type:$type,command:$command } );
			BedrockDispatcher.addEventListener($type, this._executeCommand );
		}
		
		public function removeCommand($type:String,$command:Class):void
		{
			var arrResults:Array=this._findCommands($type);
			for (var i:int=0; i < arrResults.length; i++) {
				if (arrResults[i].command === $command) {
					this._findAndRemove( this._getClassName( $command ) );
					BedrockDispatcher.removeEventListener($type,this._executeCommand );
				}
			}
		}
		
		private function _executeCommand($event:GenericEvent):void
		{
			var arrResults:Array=this._findCommands($event.type);
			for (var i:int=0; i < arrResults.length; i++) {
				var objCommand:ICommand=new arrResults[i].command;
				objCommand.execute($event);
			}
		}
		
		private function _findCommands($type:String):Array
		{
			var arrResults:Array=new Array;
			var numLength:Number=this._commands.length;
			
			for (var i:int=0; i < numLength; i++) {
				if (this._commands[i].type == $type) {
					arrResults.push(this._commands[i]);
				}
			}
			
			return arrResults;
		}
		
		private function _findAndRemove($className:String):void
		{
			var numIndex:uint;
			var numLength:uint = this._commands.length;
			for (var i:int=0; i < numLength; i++) {
				if (this._commands[i].command === $className) {
					numIndex = i;
				}
			}
			this._commands.splice(numIndex,1)
		}
		
		private function _getClassName( $instance:Object ):String
		{
			var strName:String = getQualifiedClassName($instance);
			strName=strName.slice(strName.lastIndexOf(":") + 1,strName.length);
			return "[" +strName +"]";
		}
	}
}