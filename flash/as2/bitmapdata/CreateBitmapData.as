/*

Author: Charles D Clements copyright 2007
Email: charlesdclements@yahoo.com
WebSite: www.charlesclements.net

Pass an Array of image paths into this class and it will return an Array with all the 
BitmapData Objects created into the specified return object as a parameter.

*/
import flash.display.BitmapData;
class CreateBitmapData {
	/*
	Variables
	*/
	// MovieClips
	private var mcContainer:MovieClip;
	private var mcInnerContainer:MovieClip;
	// MovieClipLoader
	private var objMovieClipLoader:MovieClipLoader;
	// Numbers
	private var numIncrement:Number = -1;
	// Arrays
	private var arrImageStrings:Array = [];
	private var arrNewBitmaps:Array = [];
	// Strings
	private var strClassName:String = "CreateBitmapData";
	// Objects
	private var objCallback:Object;
	/*
	Constrructor
	*/
	public function CreateBitmapData() {
		this.arrImageStrings = [];
		this.arrNewBitmaps = [];
	}
	/*
	Creates BitmapData from external Images.
	$array: an Array of external image URLs.
	$callbackObj: an Object containing a scope and a callback function in which it returns an Array of BitmapData Objects to.
	The callback function should be expacting an Array.
	---------------------------------------------------------
	ex: objCreateBitmapData.create(["http://www.example.com/pic1.jpg","http://www.example.com/pic2.jpg"], {scope: this, func:"bitmapsCreated"})
	*/
	public function create($array:Array, $callbackObj:Object):Void {
		this.arrImageStrings = $array;
		this.objCallback = $callbackObj;
		this.mcContainer = _root.createEmptyMovieClip("mcContainer", _root.getNextHighestDepth());
		this.mcContainer._visible = false;
		this.loadImages();
	}
	/*
	Load external images from Array.
	*/
	private function loadImages():Void {
		this.numIncrement++;
		if (this.numIncrement < this.arrImageStrings.length) {
			this.mcInnerContainer = this.mcContainer.createEmptyMovieClip("mcInnerContainer", 0);
			this.objMovieClipLoader = new MovieClipLoader();
			this.objMovieClipLoader.addListener(this);
			(this.arrImageStrings[this.numIncrement] == undefined) ? this.spotTaken() : this.loadClip(this.arrImageStrings[this.numIncrement], this.mcInnerContainer);
		} else {
			this.done();
		}
	}
	/*
	Local loadClip() function that calls the MovieClipLoader loadClip() function.
	*/
	private function loadClip($URL:String, $container:MovieClip):Void {
		this.objMovieClipLoader.loadClip($URL,$container);
	}
	/*
	
	*/
	private function onLoadError(target_mc:MovieClip, errorCode:String, httpStatus:Number):Void {
		trace(">> loadListener.onLoadError()");
		trace(">> ==========================");
		trace(">> errorCode: " + errorCode);
		trace(">> httpStatus: " + httpStatus);
		this.spotTaken();
	}
	/*
	If the URL is undefined this inserts an undefined into the Array to be returned.
	*/
	private function spotTaken():Void {
		this.arrNewBitmaps.push(undefined);
		this.loadImages();
	}
	/*
	Listens for when the image has loaded.
	*/
	private function onLoadInit($clip:MovieClip):Void {
		var bmd:BitmapData = new BitmapData(this.mcContainer._width, this.mcContainer._height, true, 0x00000000);
		bmd.draw(this.mcContainer);
		this.arrNewBitmaps.push(bmd);
		this.loadImages();
	}
	/*
	Called when all images have been loaded.
	*/
	private function done():Void {
		this.bitmapDataCreated();
		this.clear();
	}
	/*
	Load external images by passing an Array.
	*/
	private function clear():Void {
		this.numIncrement = -1;
		this.arrImageStrings = [];
		this.arrNewBitmaps = [];
		this.mcContainer.removeMovieClip();
	}
	/*
	Load external images by passing an Array.
	*/
	public function getBitmaps():Array {
		return (this.arrNewBitmaps);
	}
	/*
	Calls the Callback passed into the setup.
	*/
	private function bitmapDataCreated():Void {
		this.objCallback.scope[this.objCallback.func](this.getBitmaps());
	}
}