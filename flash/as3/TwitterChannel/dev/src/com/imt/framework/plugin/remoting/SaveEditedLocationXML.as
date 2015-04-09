// FlashPHP Class by Rick Nuthman
// 8.28.09
// Constructor receives 2 arguments:
// url:String - The url to the PHP file
// flashVars:Object - An object that contains variables to be sent to the url
//
// The class dispatches 1 event called "ready" once the php transaction is complete.
// listen for this event. Once it's received you can access returned variabled from receievedVars.

package com.imt.framework.plugin.remoting
{

    import com.imt.mch.TeleMedicineCommandCenter.model.MapStore;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    import flash.system.Capabilities;

    public class SaveEditedLocationXML extends EventDispatcher {
       
        // Public Properties
        public var receivedVars:URLVariables;      
       
        // Private Properties
        private var url:String;    
        private var flashVars:Object;
        private var request:URLRequest;
        private var completeEvent:Event = new Event("ready");
        private var variables:URLVariables = new URLVariables();
        private var loader:URLLoader = new URLLoader();


        public function SaveEditedLocationXML() 
		{
           
            this.url = getUrl()+"?r="+ new Date().getTime();
           
        }
		
		
		public function save($xmlList:XMLList):void
		{
			
			mergeXML( $xmlList );
			
		}
		
		
		/*
        // Private Methods
        private function parseVariables():void 
		{
           
            for (var item in flashVars) {
               
                variables[item] = flashVars[item];             
            }
           
            sendVariables();
        }

		
        private function sendVariables():void 
		{
           
            request = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = variables;
           
            loader.dataFormat = URLLoaderDataFormat.VARIABLES;           
            loader.addEventListener(Event.COMPLETE, variablesAreLoaded);
            loader.load(request);
			
        }
		*/

		
		private function variablesAreLoaded(event:Event):void 
		{
           
			
			trace(this + " : variablesAreLoaded");
			
			
            //receivedVars = new URLVariables(loader.data);
            dispatchEvent(completeEvent);      
			
        }
		
		
		// Merges a modified XMLList to locations XML.
		private function mergeXML($xmlList:XMLList):void
		{
			
			trace(this + " : mergeXML");
			
			
			var locs:XMLList = ( MapStore.getInstance().xml..location as XMLList);
			var length:uint = locs.length();
			// Loop thru the document.
			for(var i:uint = 0; i < length; i++)
			{
				
				// Check for a match.
				if( locs[ i ].label == $xmlList[ 0 ].label )
				{
					
					trace(this + " : mergeXML : Matched!");
					locs[ i ] = $xmlList[ 0 ];
					saveXMLwithPHP();
					//BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.MARKER_REFRESH, this, { xml:_xml, xmlList:$xmlList } ) );
					return;
					
				}
				
			}
			
		}
		
		
		//Saving the XML file with the help of a PHP file
		private function saveXMLwithPHP():void 
		{
			
			trace(this + " : saveXMLwithPHP");
			// declaring var xmlcontents String.
			var xmlcontents:String = MapStore.getInstance().xml.toXMLString();
			
			//trace(xmlcontents);
			
			// declaring var SERVER_PATH String. This is the path for the saving-xml.php.
			//var SERVER_PATH:String = "C:/";
			
			// declaring var foldername String. This is the folder container of the saved XML file
			var foldername:String = "../xml";
			
			// declaring var filename String. This is the filename of the XML file
			var filename:String = "locations.xml";
			
			// declaring var dataPass URLVariables
			var dataPass:URLVariables = new URLVariables();
			
			// declaring var urlLoader URLLoader
			var urlLoader:URLLoader = new URLLoader();
			
			// declaring var previewRequest URLRequest
			// use getSavingXmlUrl() because it runs a special condition to deliver URL.
			var previewRequest:URLRequest = new URLRequest( getUrl() );
			
			// i used method "post" in this sample. you can edit this
			previewRequest.method = URLRequestMethod.POST;
			
			// setting dataPass variables to be passed to PHP
			dataPass.filename = filename;
			dataPass.xmlcontents = xmlcontents;
			dataPass.foldername = foldername;
			
			// passing dataPass data PHP
			previewRequest.data = dataPass;
			//trace (foldername);
			
			urlLoader.addEventListener(Event.COMPLETE, variablesAreLoaded);
			
			// calling the PHP or loading the PHP
			urlLoader.load(previewRequest);
			
		}
		
		
		// Returns the URL to the XML file.
		private function getUrl():String
		{
			
			return ( Capabilities.playerType == 'External' || Capabilities.playerType == 'Desktop' ) ? "scripts/savingxml.php"+"?r=" + new Date().getTime() : "assets/scripts/savingxml.php" +"?r=" + new Date().getTime();
			
		}
		
    }
	
}