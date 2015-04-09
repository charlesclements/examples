package com.imt.framework.display
{

	public interface IDisplay
	{
		
		function initialize():IDisplay;
		function refresh():IDisplay;
		function start():IDisplay;
		function intro():IDisplay;
		function outro():IDisplay;
		function clear():IDisplay;
		function destroy():IDisplay;
			
	}
}