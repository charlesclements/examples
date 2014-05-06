

// Create Model.
var SingleMarket = Backbone.Model.extend({
    initialize: function() {
        console.log(this + " SingleMarket initialize()" );
        
    }
    
});
                                    
// Create Model.
var Markets = Backbone.Model.extend({
    
    //url:"http://pubapi.cryptsy.com/api.php?method=marketdatav2",
    initialize: function() {
        console.log(this + " MarketsModel initialize()" );
        //this.on( "reset", "onNewData", this );
        this.fetch({})
        
    },
    
    
	// override backbone synch to force a jsonp call
	sync: function(method, model, options) {
        console.log( "sync" );
        //console.log( options );
		// Default JSON-request options.
		var params = _.extend({
		  type:         'GET',
		  dataType:     'jsonp',
		  url:			"http://pubapi.cryptsy.com/api.php?method=marketdatav2",
		  jsoncallback :       "jsoncallback ",   // the api requires the jsonp callback name to be this exact name
		  processData:  false
		}, options);
 
		// Make the request.
		return $.ajax(params);
	},
	
	jsoncallback : function(response, obj) {
        console.log( "callback called" );
		// parse can be invoked for fetch and save, in case of save it can be undefined so check before using 
		if (response) {
			if (response.success ) {
                // here you write code to parse the model data returned and return it as a js object 
                // of attributeName: attributeValue
                console.log( "success" );
                console.log( response.name );
				return {name: response.name};      // just an example,                
			} 
		}
	}
    
    
    /*
    onNewData: function(obj) {
            console.log('onNewData');
            
        },
    
    sync: function(method, model, options) {
        var params = _.extend({
            type: 'GET',
            dataType: 'jsonp',
            url: this.url(),
            processData: false
        }, options);

        return $.ajax(params);
    },
    parse: function(response) {
        return response.shots;
    },

    url: function() {
        return "http://pubapi.cryptsy.com/api.php?method=marketdatav2";
    }
    
    
    
    
	// override backbone synch to force a jsonp call
	sync: function(method, model, options) {
        console.log( "sync" );
        console.log( options );
		// Default JSON-request options.
		var params = _.extend({
		  type:         'GET',
		  dataType:     'json',
		  url:			"http://pubapi.cryptsy.com/api.php?method=marketdatav2",
		  callback:       "callback",   // the api requires the jsonp callback name to be this exact name
		  processData:  false
		}, options);
 
		// Make the request.
		return $.ajax(params);
	},
	
	jsonpCallback: function(response, obj) {
        console.log( "callback called" );
		// parse can be invoked for fetch and save, in case of save it can be undefined so check before using 
		if (response) {
			if (response.success ) {
                // here you write code to parse the model data returned and return it as a js object 
                // of attributeName: attributeValue
                console.log( "success" );
                console.log( response.name );
				return {name: response.name};      // just an example,                
			} 
		}
	}
    
    
    */
    
    
});



function onProjectReady()
{
    
    console.log( "onProjectReady!.." );
    //MyModel.initialize();
    
    /*
    // Create a new script element
    var script_element = document.createElement('script');
    
    // Set its source to the JSONP API
    script_element.src = "http://pubapi.cryptsy.com/api.php?method=marketdatav2",
    
    // Stick the script element in the page <head>
    document.getElementsByTagName('head')[0].appendChild(script_element);
      */  
    
    
    
    //var model = new Markets();
    //model.initialize();
    
    
    
    $.ajax({
        type: 'GET',
        //url: 'http://jsonp.guffa.com/Proxy.ashx?url=pubapi.cryptsy.com%2fapi.php%3fmethod=marketdatav2',
        //url: 'http://jsonp.guffa.com/Proxy.ashx?url=http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=20', 
        url: 'http://jsonp.guffa.com/Proxy.ashx?url=pubapi.cryptsy.com%2fapi.php%3fmethod=singlemarketdata&marketid=40', 
        
        
        //"http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3"
        dataType: 'jsonp',
        success: function (data) {
            console.log(data);
        }
    });
    
    
    
    
    /*
    
    //window.
    // Title text.
    var div = document.getElementById("header-title-text");
    div.innerHTML = "Coin Advisor";
    // Title Subtext.
    div = document.getElementById("header-subtitle-text");
    div.innerHTML = "Make informed decisions before trading.";
    
    //div = document.getElementById("footer-subtitle-text");
    //div.innerHTML = "YESSS!!!";
    
    
    
    
    
    var container = new ContainerView({
        model: model,
        id: "document-row-"// + doc.id
    });
    
    
     
    
    
    
    
    var container = new ContainerView();
    container.initialize();
    
    var market0 = new MarketView();
    market0.initialize();
    
    
    var model = new MyModel();
    model.initialize();
    var view = new MyView();
    view.initialize();
    */
    
    
};



//onProjectReady();





