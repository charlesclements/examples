package hype.framework.core {
	import com.demonsters.debugger.MonsterDebugger;
	
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.trigger.AbstractTrigger;

	/**
	 * Creates and manages pools of objects
	 */
	public class ObjectPool {	
		protected var _classList:Array;
		protected var _max:uint;
		protected var _count:uint;
		protected var _activeSet:ObjectSet;
		protected var _inactiveSet:ObjectSet;
		
		/**
		 * Whether to automatically attempt to remove any triggers and behaviors on an object when it is released back into the pool (defaults to true)
		 */		
		public var autoClean:Boolean = true;		
		
		/**
		 * Callback for when new objects are created
		 */
		public var onCreateObject:Function;
		
		/**
		 * Callback for when new objects are successfully requested
		 */
		public var onRequestObject:Function;
		
		/**
		 * Callback for when objects are released (returned to the pool)
		 */
		public var onReleaseObject:Function;
		
		/**
		 * Constructor
		 * 
		 * @param content Either a single class or array of classes (classes are chosen randomly if a list is passed)
		 * @param max The maximum number of objects to create
		 */
		public function ObjectPool(content:*, max:uint) {
			
			if (content is Class) {
				_classList = [content as Class];
			} else if (content is Array) {
				_classList = content as Array;
			} else {
				throw new Error("Bad argument passed to ObjectPool. First argument must be class or array of classes");
			}
			_max = max;
			_count = 0;
			
			_activeSet = new ObjectSet();
			_inactiveSet = new ObjectSet();
			
			onCreateObject = onRequestObject = onReleaseObject = function(obj:Object):void{};
		}
		
		/**
		 * The active set of objects
		 */
		public function get activeSet():ObjectSet {
			return _activeSet;
		}
		
		/**
		 * Is the pool full (all objects in activeSet)
		 */
		public function get isFull():Boolean {
			return _max == _count;
		}
		
		/**
		 * Destroy the ObjectPool and remove all callbacks
		 */		
		public function destroy():void {
			_classList = null;
			_activeSet.destroy();
			_activeSet = null;
			_inactiveSet.destroy();
			_inactiveSet = null;
			onCreateObject = onRequestObject = onReleaseObject = null;
		}		
				
		/**
		 * Add an additional class
		 * 
		 * @param objectClass class you would like to add
		 * @param numTimes Number of times to add the class (defaults to 1)
		 */		
		 public function addClass(objectClass:Class, numTimes:uint=1):void {
		 	var i:int;
		 	
		 	for (i=0; i<numTimes; ++i) {
		 		_classList.push(objectClass);
		 	}
		 	_inactiveSet = new ObjectSet();
		 }
		 
		/**
		 * Sets the current set of classes
		 */		
		 public function set classList(list:Array):void {
		     _classList = list;
		     _inactiveSet = new ObjectSet();
		 }

		
		/**
		 * Request a new object. If no objects are available, null is returned.
		 * 
		 * @return The new or recycled object
		 */
		public function request():Object {
			
			trace(this + " : request()" );
			
			var obj:Object;
			
			// If an object has already been released back into the pool, it gets added to the _inactiveSet.
			// I guess it first checks and would take from a previously released Obj within the _inactiveSet before calling a new random object.
			if (_inactiveSet.length > 0) {
				obj = _inactiveSet.pull();
				_activeSet.insert(obj);
				onRequestObject(obj);

				return obj;
				
			// Theres nothing in the _inactiveSet, count is less than max.
			// Grab random object.
			} else if (_count < _max) {
				obj = makeRandomObject();
				++_count;
				_activeSet.insert(obj);
				onCreateObject(obj);
				onRequestObject(obj);
				
				return obj;
			} else {
				return null;
			}
		}
		
		/**
		 * Request all of the objects the pool can contain at once.
		 */
		/*
		public function requestAll():void {
			trace(this + " : requestAll()" );
			trace("_count : "+ _count );
			trace("_max : "+ _max );
			
			while(_count < _max) {
				trace( _count );
				request();
			}
		}

*/		
		
		
		/**
		 * Request all of the objects the pool can contain at once.
		 */
		public function requestAll():void {
			trace("" );
			trace("" );
			trace(this + " : requestAll()" );
			trace("_count : "+ _count );
			trace("_max : "+ _max );
			trace("_activeSet.length : "+ _activeSet.length );
			
			//_count = 0;
			
			
			releaseAll();
			
			// Problem w this is that it doesnt check the _inactiveSet pool.
			
			// Prob in counting.
			
			// This will only check for _count,
			// Count is only affected when objects are released.		
			
			while(_count < _max) {
				trace( this + " : requestAll() : _count : " + _count );
				request();
			}
		}
		
		
		public function releaseAll():void {
			
			trace("" );
			trace(this + " : releaseAll()" );
			var o:Object;
			var l:uint = _activeSet.length;
			
			for( var i:uint = 0; i < l; i++ )
			{
				
				// Pull any object it gives you in order to have an Object to reference.
				o = _activeSet.pull();
				
				// Re insert() the Object that was pulled, because only Objects in the _activeSet get released.
				_activeSet.insert( o );
				
				// Do releasing.
				release( o );
				
			}
			
		}
		
		
		// Would releaseAll() be helpful?
		
		/**
		 * Release an object back into the pool.
		 * 
		 * @param object The object to return to the pool
		 * 
		 * @return Whether the object was returned successfully
		 */
		public function release(object:Object):Boolean {
			var max:int;
			var i:int;
			var reusable:Boolean = false;
	
			if (_activeSet.remove(object)) {
				max = _classList.length;
		
				for (i=0; i<max; ++i) {
 					if (object is _classList[i]) {
						_inactiveSet.insert(object)
						reusable = true;
						break;
					}
				}
				
				if (!reusable) {
					--_count;
				}
				
				//trace( this + " : release : reusable: " + reusable );

				if (autoClean) {
					AbstractBehavior.removeBehaviorsFromObject(object);
					AbstractTrigger.removeTriggersFromObject(object);
				}
				onReleaseObject(object);
				
				return true;
			} else {
				return false;
			}
		}
		
		protected function makeRandomObject():Object {
			var i:int = int(Math.random() * _classList.length);
			return new _classList[i];
		}
	}
}
