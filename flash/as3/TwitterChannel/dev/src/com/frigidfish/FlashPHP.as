// FlashPHP Class by Rick Nuthman
// 8.28.09
// Constructor receives 2 arguments:
// url:String - The url to the PHP file
// flashVars:Object - An object that contains variables to be sent to the url
//
// The class dispatches 1 event called "ready" once the php transaction is complete.
// listen for this event. Once it's received you can access returned variabled from receievedVars.

package com.frigidfish{

    import flash.net.URLVariables;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequestMethod;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class FlashPHP extends EventDispatcher {
       
        // Public Properties
        public var receivedVars:URLVariables;      
       
        // Private Properties
        private var url:String;    
        private var flashVars:Object;
        private var request:URLRequest;
       
        private var completeEvent:Event              = new Event("ready");
        private var variables:URLVariables           = new URLVariables();
        private var loader:URLLoader                 = new URLLoader();

        public function FlashPHP(url:String, flashVars:Object) {
           
            this.flashVars                      = flashVars;
            this.url                            = url+"?r="+ new Date().getTime();
           
            parseVariables();
        }

        // Private Methods
        private function parseVariables() {
           
            for (var item in flashVars) {
               
                variables[item] = flashVars[item];             
            }
           
            sendVariables();
        }

        private function sendVariables() {
           
            request                                 = new URLRequest(url);
            request.method                          = URLRequestMethod.POST;
            request.data                            = variables;
           
            loader.dataFormat                       = URLLoaderDataFormat.VARIABLES;           
            loader.addEventListener(Event.COMPLETE, variablesAreLoaded);
            loader.load(request);
        }

        function variablesAreLoaded(event:Event) {
           
            receivedVars                            = new URLVariables(loader.data);
            dispatchEvent(completeEvent);          
        }
    }
}