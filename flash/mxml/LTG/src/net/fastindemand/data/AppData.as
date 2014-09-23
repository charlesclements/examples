package net.fastindemand.data
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	import mx.collections.XMLListCollection;

	public class AppData extends Object
	{
		
		public static var projectsXML:XML = new XML();
		public static var currentProjectsFile:File;
		public static var stream:FileStream = new FileStream();
		public static var projectIndex:uint = 0;
		
		
		[Bindable]
		public static var projects:XMLListCollection;
		
		
		public function AppData()
		{
			super();
		}
	}
}