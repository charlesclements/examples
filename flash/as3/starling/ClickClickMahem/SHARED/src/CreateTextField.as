	
	/*************************************************************************
	*
	* ADOBE CONFIDENTIAL
	* ___________________
	*
	*  Copyright [first year code created] Adobe Systems Incorporated
	*  All Rights Reserved.
	*
	* NOTICE:  All information contained herein is, and remains
	* the property of Adobe Systems Incorporated and its suppliers,
	* if any.  The intellectual and technical concepts contained
	* herein are proprietary to Adobe Systems Incorporated and its
	* suppliers and are protected by trade secret or copyright law.
	* Dissemination of this information or reproduction of this material
	* is strictly forbidden unless prior written permission is obtained
	* from Adobe Systems Incorporated.
	**************************************************************************/


package
{
	import flash.text.TextField;

	public class CreateTextField
	{
		public var tf:TextField;
		private var x:int;
		private var y:int;
		private var width:int;
		private var height:int;
		
		public function customTextField(x:int=0,y:int=0,width:int=60,height:int=50,border1:Boolean=true):TextField
		{
			tf=new TextField();
			tf.x=x;
			tf.y=y;
			tf.width=width;
			tf.height=height;
			tf.border=border1;
			
			
			return(tf);
		}
	}
}