package model
{

	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.XMLListCollection;
	
	import net.fastindemand.dispatcher.Dispatcher;
	import net.fastindemand.event.AppEvent;

	public class AppModel extends Object
	{
		
		public static const SERVER_PATH:String = "http://localhost:8888/";
		public static const STORAGE:File = File.applicationStorageDirectory;
		public static var ID:String = "";
		public static var PID:String = "";
		public static var PROJECTS_XML:XML = new XML();
		public static var PROJECTS_FILE:File;
		public static var CURRENT_PROJECT_FILE:File;
		public static var CURRENT_AUDIO_DIRECTORY:File;
		public static var CURRENT_MUSIC_FILE:File;
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
			trace(path);
			
			// Point File to the path.
			PROJECTS_FILE = STORAGE.resolvePath( path );
			
			trace( "+" );
			
			trace( PROJECTS_FILE );
			
			
			
			// Read XML info.
			STREAM.open( PROJECTS_FILE, FileMode.READ);
			
			// Get the XML from the File.
			PROJECTS_XML = XML( STREAM.readUTFBytes( STREAM.bytesAvailable ) );
			
			// Must close stream.
			STREAM.close();
			
			
			trace( PROJECTS_FILE );
			trace( PROJECTS_XML );
			trace( PROJECTS_XML.text().length() );
			trace( PROJECTS_XML.toXMLString().length );
			
			
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
			
			
			
			/*
			// Saving the actual file.
			STREAM = new FileStream();
			STREAM.open( PROJECTS_FILE, FileMode.WRITE );
			//STREAM.writeUTFBytes( outputString );
			//STREAM.readUTFBytes(
			STREAM.close();
			*/
			
			
			Dispatcher.dispatchEvent( new AppEvent( AppEvent.SHOW_PROJECTS ) );
			
			
			
		}
		
		
		public static function copyMusic(id:String, file:File):void
		{
			
			trace( "AppModel - copyMusic - " + id + " - " + file.name );

			CURRENT_AUDIO_DIRECTORY = STORAGE.resolvePath("LyricsToGo/" + id + "/audio/");
			CURRENT_AUDIO_DIRECTORY.createDirectory();
			file.copyTo( CURRENT_AUDIO_DIRECTORY.resolvePath( file.name ), true );
			
			// Add audio to project xml.
			
			
			trace( CURRENT_XML );
			trace( CURRENT_XML.@id );
			trace( CURRENT_XML..@id );
			trace( CURRENT_XML.toXMLString() );
			
			
			
			
			
			
			
		}
		
		public static function saveXML(id:String, xmllist:XMLList):void
		{
			
			trace( "AppModel - saveXML - " + id );
			trace( xmllist );
			
			/*
			trace(CURRENT_XML);
			trace(CURRENT_XML.toXMLString().length);
			trace(CURRENT_XML.length());
			trace( "" );
			
			
			
			
			trace( "" );
			trace(CURRENT_XML[ 0 ]);
			
			trace( "" );
			trace(CURRENT_XML[ 0 ].title);
			*/
			
			// add vars this way.
			
			
			
			trace( PROJECTS_XML );
			//trace( PROJECTS_XML.@id );
			trace( PROJECTS_XML..@id );
			
			
			CURRENT_XML[ 0 ].title = xmllist.title;
			CURRENT_XML[ 0 ].content = xmllist.content;
			CURRENT_XML[ 0 ].audio.@name = "";
			//CURRENT_XML[ 0 ].content = xmllist.content;
			
			
			// Update title in Projects var.
			
			
			trace(CURRENT_XML);
			
			
			
			
			
			
			// This is the Strign that will get saved to the File.
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += CURRENT_XML.toXMLString();
			outputString = outputString.replace( /\n/g, File.lineEnding );
			
			trace(outputString);
			
			
			
			
			PROJECTS_FILE = STORAGE.resolvePath("LyricsToGo/projects.xml");
			
			
			// Saving the actual file.
			STREAM = new FileStream();
			STREAM.open( PROJECTS_FILE, FileMode.WRITE );
			STREAM.writeUTFBytes( outputString );
			STREAM.close();
			
			
			
			
			
			
			
			
			
			
			
			
			/*
			trace( "" );
			trace(CURRENT_XML[ 0 ].title);
			*/
			
			//trace( PROJECTS_XML..projects.( "@id" == PID ).toXMLString() );
			
			
			
			
			
			
			//var xml:XML = new XML( xmllist );
			//CURRENT_XML = new XML( xmllist );
			
			trace( "" );
			trace(CURRENT_XML);
			
			
			
			// This is the Strign that will get saved to the File.
			outputString = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += CURRENT_XML.toXMLString();
			outputString = outputString.replace( /\n/g, File.lineEnding );
			
			trace(outputString);
			
			
			
			
			CURRENT_PROJECT_FILE = STORAGE.resolvePath("LyricsToGo/" + id + "/project.xml");
			CURRENT_AUDIO_DIRECTORY = STORAGE.resolvePath("LyricsToGo/" + id + "/audio/");
			CURRENT_AUDIO_DIRECTORY.createDirectory();
			
			
			// Saving the actual file.
			STREAM = new FileStream();
			STREAM.open( CURRENT_PROJECT_FILE, FileMode.WRITE );
			STREAM.writeUTFBytes( outputString );
			STREAM.close();
			
		}
		
		
		
		
		
	}
}