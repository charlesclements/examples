package net.charlesclements.behaviour
{
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.behavior.IBehavior;
	import hype.framework.behavior.SimpleBehavior;
	
	public class Sequencer extends AbstractBehavior implements IBehavior
	{
		
		private var _seq:Array;
		private var _index:int = -1;
		protected var _prop:String;
		
		public function Sequencer(target:Object, prop:String, sequence:Array )
		{
			super(target);
			
			_prop = prop;
			
			_seq = sequence;
			_index = -1
			
		}
		
		
		/**
		 * @protected
		 */
		public function run(target:Object):void 
		{
			
			_index = (_index>=_seq.length)?0:_index;
			
			setProperty(_prop, _index);
			
			_index++;
			
		}
		
		
	}
	
}