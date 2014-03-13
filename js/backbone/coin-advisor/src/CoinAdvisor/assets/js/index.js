

// Create Model.
var MarketsModel = Backbone.Model.extend({
    initialize: function() {
        console.log(this + " MarketsModel initialize()" );
        this.updateValues();
        // Set event handler.
        this.on('change:start_at', this.updateValues, this);
    },
    updateValues: function() {
        console.log(" MarketsModel : updateValues" );
        // Define the new vars here.
        this.set({
            new_number: 17,
            old_number: 67
            //start_date: Utils.dateFromDate( this.get( "start_at" ) ),
            //start_time: Utils.timeFromDate( this.get( "start_at" ) )//,
           // duration: Utils.youGetTheIdea()
        }, {silent:false});
    }
});





var ContainerView = Backbone.View.extend({

    
  tagName: "div",

  className: "document-row",

  events: {
    //"click .icon":          "open",
    //"click .button.edit":   "openEditDialog",
    //"click .button.delete": "destroy"
  },

  initialize: function() {
    this.listenTo(this.model, "change", this.render);
  },

  render: function() {
   // ...
  }





});



function onProjectReady()
{
    
    console.log( "onProjectReady!" );
    //MyModel.initialize();
    //var model = new MarketsModel();
    //model.initialize();
    
    
    
    //window.
    // Title text.
    var div = document.getElementById("title-text");
    div.innerHTML = "Coin Advisor";
    // Title Subtext.
    var div = document.getElementById("subtitle-text");
    div.innerHTML = "Make informed decisions before trading.";
    
    var container = new ContainerView();
    
     /*
    
    
    
    
    
    
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









