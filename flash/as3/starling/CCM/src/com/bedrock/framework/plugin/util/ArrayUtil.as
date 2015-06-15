package com.bedrock.framework.plugin.util
{
	import com.bedrock.framework.core.base.StaticBase;
	
	import flash.utils.*;
	
	public class ArrayUtil extends StaticBase
	{
		public static  function wrapIndex($index:Number,$total:Number,$wrap:Boolean=false):Number
		{
			var numIndex:Number;
			var numDifference:Number;
			var numRemainder:Number;
			var numTotal:Number=$total;
			var bolWrap:Boolean=$wrap;
			if (bolWrap) {
				if ($index >= $total) {
					numIndex=$index;
					numDifference=Math.floor(numIndex / numTotal);
					//
					if (numDifference > 1) {
						numRemainder=numIndex % numTotal;
						return numRemainder;
					}
					return numIndex - numTotal;
				} else if ($index < 0) {
					numIndex=Math.abs($index);
					numDifference=Math.ceil(numIndex / numTotal);
					if (numDifference > 1) {
						numRemainder=numIndex % numTotal;
						if (numRemainder == 0) {
							return numRemainder;
						} else {
							return (numTotal - numRemainder);
						}
					}
					return Math.abs(numTotal - numIndex);
				} else {
					return $index;
				}
			} else {
				if ($index >= numTotal) {
					return (numTotal - 1);
				} else if ($index < 0) {
					return 0;
				} else {
					return $index;
				}
			}
		}
		/*
		Search: Returns Matching Index
		*/
		public static function findIndex( $array:Array, $value:*, $field:String=null ):int
		{
			var i:Number;
			var numLength:Number=$array.length;
			if ($field == null) {
				for (i=0; i < numLength; i++) {
					if ($array[i] == $value) {
						return i;
					}
				}
			} else {
				for (i=0; i < numLength; i++) {
					if ($array[i][$field] == $value) {
						return i;
					}
				}
			}
			return -1;
		}
		public static function findContaining( $array:Array,$value:String,$field:String=null ):*
		{
			var i:Number;
			var strItem:String;
			var numLength:Number=$array.length;
			if ($field == null) {
				for (i=0; i < numLength; i++) {
					strItem = String($array[i]);
					if (strItem.indexOf($value) != -1) {
						return $array[i];
					}
				}
			} else {
				for (i=0; i < numLength; i++) {
					strItem = String($array[i][$field]);
					if (strItem.indexOf($value) != -1) {
						return $array[i];
					}
				}
			}
			return null;
		}
		public static function findAndRemove( $array:Array, $value:*, $field:String=null ):*
		{
			var numIndex:int = ArrayUtil.findIndex( $array, $value, $field );
			if ( numIndex != -1 ) {
				return $array.splice( numIndex, 1 )[ 0 ];
			} else {
				return null;
			}
		}
		/*
		Search: Returns Single Item
		*/
		public static function findItem($array:Array,$value:*, $field:String=null):*
		{
			var i:Number;
			var numLength:Number=$array.length;
			if ($field == null) {
				for (i=0; i < numLength; i++) {
					if ($array[i] == $value) {
						return $array[i];
					}
				}
			} else {
				for (i=0; i < numLength; i++) {
					if ($array[i][$field] == $value) {
						return $array[i];
					}
				}
			}
			return null;
		}
		/*
		Search: Returns Single Item
		*/
		public static function containsItem($array:Array,$value:*,$field:String=null):Boolean
		{
			return ( ArrayUtil.findIndex($array, $value, $field) != -1 );
		}

		/*
		Search: Returns New Array
		*/
		public static function filter($array:Array,$value:*,$field:String=null):Array
		{
			var arrResults:Array=new Array;
			var i:Number;
			var numLength:Number=$array.length;
			if ($field == null) {
				for (i=0; i < numLength; i++) {
					if ($array[i] == $value) {
						arrResults.push($array[i]);
					}
				}
			} else {
				for (i=0; i < numLength; i++) {
					if ($array[i][$field] == $value) {
						arrResults.push($array[i]);
					}
				}
			}
			return arrResults;
		}
		
		/*
		Search for and remove an item from an array
		*/
		public static function filterAndRemove($array:Array,$value:*,$field:String=null):Array
		{
			var arrResults:Array=new Array;
			var numLength:Number=$array.length;
			var i:Number;
			if ($field == null) {
				for (i=(numLength-1); i > -1; i--) {
					if ($array[i] == $value) {
						arrResults.push( $array.splice( i, 1 )[ 0 ] );
					}
				}
			} else {
				for (i=(numLength-1); i > -1; i--) {
					if ($array[i][$field] == $value) {
						arrResults.push( $array.splice( i, 1 )[ 0 ] );
					}
				}
			}
			return arrResults;
		}
		/*
		Divides an array into several smalled arrays
		*/
		public static function segment($array:Array,$count:Number):Array
		{
			var arrOutput:Array=new Array;
			var numItems:Number=$count;
			var numGroups:Number=Math.ceil($array.length / numItems);
			for (var i:int=0; i < numGroups; i++) {
				var numStartIndex:Number=numItems * i;
				var numEndIndex:Number=numItems * i + numItems;
				var arrResult:Array=$array.slice(numStartIndex,numEndIndex);
				arrOutput.push(arrResult);
			}
			return arrOutput;
		}
		/*
		Output Random Number from Array
		*/
		public static function randomIndex($current:Number,$total:Number):Number
		{
			var numTemp:Number=$current;
			do {
				numTemp=ArrayUtil.__getRandomIndex($total);
			} while (numTemp == $current);
			return numTemp;
		}
		private static function __getRandomIndex($maximum:Number,$minimum:Number=0,$decimal:Boolean=false):Number
		{
			var numRandom:Number = ($decimal) ? (Math.random() * ($maximum - $minimum)) + $minimum : Math.floor(Math.random() * ($maximum - $minimum)) + $minimum;
			return numRandom;
		}
		/*
		Insert new data at location
		*/
		public static function insert($array:Array,$location:Number,$item:*):Array
		{
			$array.splice($location,0,$item);
			return $array;
		}
		/*
		Move item to a different location
		*/
		public static function move($array:Array,$index:Number,$location:Number):Array
		{
			var arrTemp:Array=$array;
			var objItem:*=ArrayUtil.remove(arrTemp,$index);
			ArrayUtil.insert($array,$location,objItem);
			return $array;
		}
		/*
		Remove data from index
		*/
		public static function remove($array:Array,$index:Number):*
		{
			var item:*=$array.splice($index,1);
			return item[0];
		}
		/*
		Duplicate Array
		*/
		public static function duplicate($array:Array):Array
		{
			return $array.concat();
		}
		/*
		Shuffle Array
		*/
		public static function shuffle($array:Array):void
		{
			for(var i:int=0;i<$array.length;i++){
		      var objTemp:*=$array[i];
		      var numRandom:Number = ArrayUtil.__getRandomIndex($array.length);
		      $array[i]=$array[numRandom];
		      $array[numRandom]=objTemp;
		   }
		}
		/*
		Get random items based on a total
		*/
		public static function getRandomItems($array:Array,$total:Number):Array
		{
			var arrTemp:Array=duplicate($array);
			var arrNewItems:Array=new Array;
			//
			arrTemp=arrTemp.concat();
			for (var i:int=0; i < $total; i++) {
				var numLength:Number=arrTemp.length;
				var objPackage:Object=remove(arrTemp, ArrayUtil.__getRandomIndex( numLength ) );
				arrNewItems.push(objPackage);
			}
			return arrNewItems;
		}
		
		/*
		Get random items based on a total
		*/
		public static function iterate($array:Array, $handler:Function ):void
		{
			for ( var i:int = 0; i < $array.length; i ++ ) {
				$handler( i, $array[ i ] );
			}
		}
	}
}