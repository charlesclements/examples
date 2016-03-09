package entities
{
	import com.gamua.flox.Entity;
	
	public class Tokens extends Entity
	{
		public function Tokens()
		{
			super();
		}
		
		
		
		private var _tokens:uint = 0;
		
		public function get tokens():Number {
			return _tokens;
		}
		
		public function set tokens(value:Number):void {
			_tokens = value;
		}
		
		
		
		
		
	}
}