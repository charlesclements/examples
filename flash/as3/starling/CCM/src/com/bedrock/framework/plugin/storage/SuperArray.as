package com.bedrock.framework.plugin.storage
{
	public class SuperArray
	{
		import com.bedrock.framework.plugin.util.ArrayUtil;
		/*
		Variable Declarations
		*/
		private var _data:Array;
		private var _selectedIndex:int;
		public var itemLimit:int;
		public var wrapIndex:Boolean;
		public var allowDuplicates:Boolean;
		/*
		Constructor
		*/
		public function SuperArray( $data:Array = null )
		{
			this.source = $data || new Array;
			this.wrapIndex=false;
			this.reset();
		}
		/*
		Clear
		*/
		public function clear():void
		{
			var numLength:int=this._data.length;
			for (var i:int=0; i < numLength; i++) {
				this._data.pop();
			}
			this.reset();
		}
		/*
		Reset Selections
		*/
		public function reset():void
		{
			this._selectedIndex = 0;
		}
		/*
		Returns a copy of the array
		*/
		public function duplicate():Array
		{
			return ArrayUtil.duplicate(this._data);
		}
		/*
		Insert new data at index
		*/
		public function insert($location:int,$item:*):Array
		{
			return ArrayUtil.insert(this._data,$location,$item);
		}
		/*
		Move item to a different location
		*/
		public function move($index:int,$location:int):Array
		{
			return ArrayUtil.move(this._data, $index, $location);
		}
		
		public function swap( $index1:int, $index2:int ):void
		{
			var tmpData1:* = this._data[ $index1 ];
			var tmpData2:* = this._data[ $index2 ];
			
			this._data[ $index1 ] = tmpData2;
			this._data[ $index2 ] = tmpData1;
		}
		/*
		Remove item at index
		*/
		public function remove($index:int):*
		{
			return ArrayUtil.remove(this._data,$index);
		}
		/*
		Add to end
		*/
		public function automaticPush($array:Array):void
		{
			var numLength:int=$array.length;
			for (var i:int=0; i < numLength; i++) {
				this._data.push($array[i]);
			}
		}
		/*
		Loop through an array unshift each item in
		*/
		public function automaticUnshift($array:Array):void
		{
			var numLength:int=$array.length;
			for (var i:int=0; i < numLength; i++) {
				this._data.unshift($array[i]);
			}
		}
		/*
		Wrappers 
		*/
		public function push(...$arguments:Array):void
		{
			var numLength:int = $arguments.length;
			for (var a:int = 0 ; a < numLength; a++) {
				this._data.push( $arguments[ a ] );
			}			
			if (this.itemLimit != 0) {
				if (this._data.length > this._data._numLimit) {
					var numLoop:int=this.itemLimit - this._data.length;
					for (var i:int=0; i < numLoop; i++) {
						this._data.shift();
					}
				}
			}
		}
		public function unshift(...$arguments:Array):void
		{
			var numLength:int = $arguments.length;
			for (var a:int = 0 ; a < numLength; a++) {
				this._data.unshift( $arguments[ a ] );
			}
			if (this.itemLimit != 0) {
				if (this._data.length > this.itemLimit) {
					var numLoop:int=this.itemLimit - this._data.length;
					for (var i:int=0; i < numLoop; i++) {
						this._data.pop();
					}
				}
			}
		}
		/*
		Return item at location
		*/
		public function getItemAt( $index:uint ):*
		{
			if (this.wrapIndex){
				return this._data[ArrayUtil.wrapIndex($index, this._data.length, true)];
			}else{
				try{
					return this._data[$index];
				} catch($error:Error){
					return null
				}					
			}		
		}
		/*
		Increment selected index
		*/
		public function selectNext():*
		{
			return this.setSelected(this._selectedIndex + 1);
		}
		/*
		Decrement selected index
		*/
		public function selectPrevious():*
		{
			return this.setSelected(this._selectedIndex - 1);
		}
		/*
		Select current index
		*/
		public function setSelected($index:int):*
		{
			//check for wrapping
			this._selectedIndex=ArrayUtil.wrapIndex($index, this._data.length, this.wrapIndex);
			return this.getSelected();
		}
		/*
		Return selected item from the array
		*/
		public function getSelected():*
		{
			return this.getItemAt(this._selectedIndex);
		}
		
		/*
		Select a random item in the array
		*/
		public function selectRandom():*
		{
			if (this._data.length > 0) {
				return this.setSelected(ArrayUtil.randomIndex(this._selectedIndex,this._data.length));
			}
		}
		/*
		* Has more items
		*/
		public function hasNext():Boolean
		{
			if (this.wrapIndex) {			
				return true;
			}
			return ( ( this._selectedIndex + 1 )  < this._data.length );
		}
		public function hasPrevious():Boolean
		{
			if (this.wrapIndex) {			
				return true;
			}
			return ( ( this._selectedIndex - 1 )  >= 0 );
		}
		/*
		Get random items based on a total
		*/
		public function getRandomItems($total:int):*
		{
			if (this._data.length > 0) {
				return ArrayUtil.getRandomItems(this._data,$total);
			}
		}
		/*
		Get object properties from array
		*/
		public function getProperties($property:String):Array
		{
			var result:Array = new Array;
			for each ( var data:* in this._data ) {
				result.push( data[ $property ] );
			}
			return result;
		}
		/*
		Search: Returns array with results
		*/
		public function filter($value:*,$field:String=null):Array
		{
			return ArrayUtil.filter(this._data,$value,$field);
		}
		/*
		Search for and remove an item from an array
		*/
		public function filterAndRemove($value:*,$field:String=null):Array
		{
			return ArrayUtil.filterAndRemove(this._data,$value,$field);
		}
		/*
		Search: Returns Single Index
		*/
		public function findIndex($value:*,$field:String=null):int
		{
			return ArrayUtil.findIndex(this._data,$value,$field);
		}
		/*
		Search: Returns Single Item
		*/
		public function findItem($value:*, $field:String=null ):*
		{
			return ArrayUtil.findItem(this._data,$value,$field);
		}
		/*
		Search: Finds a string within a field
		*/
		public function findContaining($value:*,$field:String=null):*
		{
			return ArrayUtil.findContaining(this._data,$value,$field);
		}
		public function findAndRemove($value:*, $field:String=null):*
		{
			return ArrayUtil.findAndRemove( this._data, $value, $field );
		}
		/*
		Search: Returns true or false wether a value exists or not
		*/
		public function containsItem($value:*,$field:String=null):Boolean
		{
			return ArrayUtil.containsItem(this._data,$value,$field);
		}
		/*
		Search: Selects and Returns a Single Item
		*/
		public function findAndSelect($value:*,$field:String=null):*
		{
			return this.setSelected( ArrayUtil.findIndex( this._data, $value, $field ) );
		}
		/*
		*/
		public function iterate( $handler:Function ):void
		{
			ArrayUtil.iterate( this.source, $handler );
		}
		/*
		Set/ Get data
		*/
		public function set source($data:Array):void
		{
			this._data = $data;
			this.reset();
		}
		public function get source():Array
		{
			return this._data;
		}
		
		public function get length():int
		{
			return this.source.length;
		}
		/*
		Return the last index from the array
		*/
		public function get lastIndex():int
		{
			return (this._data.length - 1);
		}
		/*
		Return selected item from the array
		*/
		public function get selectedIndex():int
		{
			return this._selectedIndex;
		}
		public function get selectedItem():*
		{
			return this.getSelected();
		}
	}
}