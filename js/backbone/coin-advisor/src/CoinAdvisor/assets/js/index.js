
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
    initialize: function() {
        console.log("ContainerView initialize()" );
        this.updateValues();
        this.on('change:start_at', this.updateValues, this);
    },
    updateValues: function() {
        
        
        console.log("ContainerView : updateValues" );
        
        /*
        this.set({
            start_date: Utils.dateFromDate( this.get( "start_at" ) ),
            start_time: Utils.timeFromDate( this.get( "start_at" ) ),
            duration: Utils.youGetTheIdea()
        }, {silent:true});
        */
        
    }, {silent:false}););

var MarketView = Backbone.View.extend({
    initialize: function() {
        console.log("MarketsView : initialize()" );
        this.updateValues();
        this.on('change:start_at', this.updateValues, this);
    },
    updateValues: function() {
        
        
        console.log(" MarketsView : updateValues" );
        
    }
}, {silent:false}););


function onProjectReady()
{
    
    console.log( "onProjectReady!" );
    //MyModel.initialize();
    var model = new MarketsModel();
    //model.initialize();
    
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









