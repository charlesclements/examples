package com.bedrock.extras.delegate
{
	import com.bedrock.framework.core.base.StandardBase;
	
	public class Delegate extends StandardBase
	{
		/*
		Variable Declarations
		*/
		public var responder:IResponder;
		/*
		Constructor
		*/
		public function Delegate($responder:IResponder)
		{
			this.responder = $responder;
		}
		
	}
}