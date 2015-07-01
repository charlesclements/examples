package com.imt.framework.display.button
{
	import starling.textures.Texture;
	
	public class GameButton extends AbstractButton
	{
		public function GameButton($data:Object, upState:Texture, text:String="", downState:Texture = null)
		{
			super($data, upState, text, downState);
		}
	}
}