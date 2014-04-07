
var ContainerView =  = Backbone.View.extend({

  tagName: "li",

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

var MarketView =  = Backbone.View.extend({

  tagName: "li",

  className: "market-view",

  events: {
   // "click .icon":          "open",
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

