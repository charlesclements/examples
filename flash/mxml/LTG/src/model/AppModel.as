package model
{
	
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import mx.collections.XMLListCollection;
	
	import net.fastindemand.dispatcher.Dispatcher;
	import net.fastindemand.event.AppEvent;
	
	public class AppModel extends Object
	{
		
		public static const SERVER_PATH:String = "http://localhost:8888/";
		
		// Get server php.
		//public static const SERVER_PATH:String = "http://www.charlesclements.net/apps/ltg/";
		
		public static const STORAGE:File = File.applicationStorageDirectory;
		public static var ID:String = "";
		public static var PID:String = "";
		public static var PROJECTS_XML:XML = new XML();
		public static var PROJECTS_FILE:File;
		public static var CURRENT_PROJECT_FILE:File;
		public static var CURRENT_AUDIO_DIRECTORY:File;
		public static var CURRENT_AUDIO_FILE_URL:String = "";
		public static var CURRENT_MUSIC_FILE:File;
		public static var CURRENT_SOUND:Sound = null;
		public static var CURRENT_SOUNDCHANNEL:SoundChannel = null;
		public static var CURRENT_XML:XML = new XML();
		public static var STREAM:FileStream = new FileStream();
		public static var PROJECT_INDEX:uint = 0;
		
		
		[Bindable]
		public static var PROJECTS_LIST:XMLListCollection;
		
		
		public function AppModel()
		{
			super();
		}
		
		
		public static function init():void
		{
			
			trace( "AppModel - init");
			
			// At this point:
			// Login success.
			
			// Use the returned info to get projects.xml of the User.
			var path:String = "LyricsToGo/user/" + ID + "/projects.xml";
			
			// Point File to the path.
			PROJECTS_FILE = STORAGE.resolvePath( path );
			
			// Read XML info.
			STREAM.open( PROJECTS_FILE, FileMode.READ);
			
			// Get the XML from the File.
			PROJECTS_XML = XML( STREAM.readUTFBytes( STREAM.bytesAvailable ) );
			
			// Must close stream.
			STREAM.close();
			
			// From here we already have the XML pulled from the File.
			
			
			// Test if the File has and XML data, if not, must create XML data here.
			
			var length:uint = PROJECTS_XML.toXMLString().length;
			
			if( length < 0 )
			{
				
				// Set stuff in motion.
				PROJECTS_XML = new XML( <projects></projects> );
				
			}
			else
			{
				
				
				
				
				
			}
			
			Dispatcher.dispatchEvent( new AppEvent( AppEvent.SHOW_PROJECTS ) );
			
		}
		
		
		public static function setupSound():void
		{
		
			trace( "AppModel - setupSound()" );
			if( CURRENT_SOUNDCHANNEL ) CURRENT_SOUNDCHANNEL.stop();
			var list:XMLList = new XMLList( AppModel.CURRENT_XML );
			CURRENT_AUDIO_FILE_URL = list.audio.@url.toString();
			CURRENT_SOUND = new Sound( new URLRequest( CURRENT_AUDIO_FILE_URL ) );
			
		}
		
		
		public static function copyMusic(id:String, file:File):void
		{
			
			trace( "AppModel - copyMusic - " + id + " - " + file.name );
			
			CURRENT_AUDIO_DIRECTORY = STORAGE.resolvePath("LyricsToGo/user/" + ID + "/audio/");
			CURRENT_AUDIO_DIRECTORY.createDirectory();
			file.copyTo( CURRENT_AUDIO_DIRECTORY.resolvePath( PID + "/" + file.name ), true );
			
			// Create new file and use it.
			var f:File = new File( CURRENT_AUDIO_DIRECTORY.nativePath + "/" + PID + "/" + file.name );
			CURRENT_AUDIO_FILE_URL = f.url;
			CURRENT_XML.audio.@url = CURRENT_AUDIO_FILE_URL
			CURRENT_XML.audio.@name = file.name;
			f = null;
			
		}
		
		
		public static function saveAllProjectsXML(xml:XML):void
		{
			
			trace( "AppModel - saveAllProjectsXML" );
			
			// This is the String that will get saved to the File.
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			//outputString += CURRENT_XML.toXMLString();
			outputString += xml.toXMLString();
			outputString = outputString.replace( /\n/g, File.lineEnding );
			
			//var path:String = STORAGE.nativePath + "/LyricsToGo/user/" + ID + "/projects/" + PID + "/project.xml";
			var path:String = STORAGE.nativePath + "/LyricsToGo/user/" + ID + "/projects.xml";
			CURRENT_PROJECT_FILE = File.documentsDirectory.resolvePath( path ); 
			STREAM = new FileStream;
			STREAM.open( CURRENT_PROJECT_FILE, FileMode.WRITE );
			STREAM.writeUTFBytes( outputString );
			STREAM.close();
			
			// Alert everyone else that the XML has been saved and changed.
			Dispatcher.dispatchEvent( new AppEvent( AppEvent.UPDATE_PROJECTS ) );
			
			trace( "AppModel - saveAllProjectsXML - END" );
			
		}
		
		
		public static function saveSingleProjectXML(id:String, xmllist:XMLList):void
		{
			
			trace( "AppModel - saveSingleProjectXML - " + id );
			
			// Current project.
			CURRENT_XML = new XML( xmllist );
			
			// This is the String that will get saved to the File.
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += CURRENT_XML.toXMLString();
			outputString = outputString.replace( /\n/g, File.lineEnding );
			
			var path:String = STORAGE.nativePath + "/LyricsToGo/user/" + ID + "/projects/" + PID + "/project.xml";
			CURRENT_PROJECT_FILE = File.documentsDirectory.resolvePath( path ); 
			STREAM = new FileStream;
			STREAM.open( CURRENT_PROJECT_FILE, FileMode.WRITE );
			STREAM.writeUTFBytes( outputString );
			STREAM.close();
			
		}
		
	}
	
}