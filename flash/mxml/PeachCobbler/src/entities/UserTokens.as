package entities
{
	import com.gamua.flox.Entity;
	
	public class UserTokens extends Entity
	{
		public function UserTokens()
		{
			super();
		}
		
		
		
		private var _tokens:uint = 25;
		
		public function get tokens():Number {
			return _tokens;
		}
		
		public function set tokens(value:Number):void {
			_tokens = value;
		}
		
		
		
		
		
	}
}