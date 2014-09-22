package net.fastindemand.data
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	import mx.collections.XMLListCollection;

	public class AppData extends Object
	{
		
		
		
		
		public static var projectsXML:XML;
		public static var currentProjectsFile:File;
		public static var stream:FileStream
		
		
		[Bindable]
		public static var projects:XMLListCollection;
		
		
		public function AppData()
		{
			super();
		}
	}
}