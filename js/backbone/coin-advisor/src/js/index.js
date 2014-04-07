

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
        this.fetch({})
        
    },
	// override backbone synch to force a jsonp call
	sync: function(method, model, options) {
        console.log( "sync" );
		// Default JSON-request options.
		var params = _.extend({
		  type:         'GET',
		  dataType:     'jsonp',
		  url:			"http://pubapi.cryptsy.com/api.php?method=marketdatav2",
		  jsonpCallback : 		"jsonpCallback",   // the api requires the jsonp callback name to be this exact name
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
    
});



var ContainerView = Backbone.View.extend({

    
  initialize: function() {
      console.log(" ContainerView : initialize" );
      this.listenTo(this.model, "change", this.render);
  },
  render: function() {
      console.log(" ContainerView : render" );
  }

});



function onProjectReady()
{
    
    console.log( "onProjectReady!.." );
    //MyModel.initialize();
    
    
    
    var model = new Markets();
    //model.initialize();
    
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





