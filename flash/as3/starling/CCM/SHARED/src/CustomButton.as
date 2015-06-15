	
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
	
package{
	
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;


public class CustomButton extends Sprite {
	private var wsize:uint;
	private var hsize:uint;
	private var overColor:uint = 0xBBBBBB;
	private var downColor:uint = 0x00CCFF;
	private var tf:TextField;
	
	public function CustomButton(str:String="Button",x:int=0,y:int=0,width:int=70,height:int=50) {
		this.x=x;
		this.y=y;
		this.wsize=width;
		this.hsize=height;
		this.mouseChildren=false;		
		draw(wsize, hsize, overColor);
		tf=new TextField();
		tf.text=str;		
		
		this.addChild(tf);
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
	}
	
	public function draw(w:uint, h:uint, bgColor:uint):void {
		graphics.clear();
		graphics.beginFill(bgColor);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
	}	
	
	public function mouseDownHandler(event:MouseEvent):void {		
		draw(wsize, hsize, downColor);	
	}
	
	public function mouseUpHandler(event:MouseEvent):void {	
		draw(wsize, hsize, overColor);
	}
}
}
