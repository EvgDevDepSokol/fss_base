// selector to be used for systems for corrunt project

'use strict';

var React = require('react');
var Select = require('react-select');
//var onChange = require('./selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'SystemSelector',

  getInitialState() {
    return {
      value: this.props.value
    };
  },

  onChange(value, object) {
    if(object.length > 0) this.setState({value: object[0].label});
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  },

  render: function() {
    var getOptions = function(input, callback) {
      setTimeout(function() {

        var options = [];
        $.ajax({
          url: '/api/pds_syslists',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            options = data;
          }.bind(this),
          error: function(xhr, status, err) {
            //debugger;
            console.error(this.props.url, status, err.toString());
            options = [];
          }.bind(this),
          async: false
        });

        options = $.map(options , function(el){ return {value: el.id, label: el.System} } )
        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
        //  complete: true,
        });
      }, 0);
    };


    return (
      React.createElement(Select, {name: "System",
        asyncOptions: getOptions,
        onChange: this.onChange,
        //onChange: onChange,
        value: this.state.value,
        clearable: false
        })
    );
  }
});


//module.exports.options = function(){
//  var options = [];
//  $.ajax({
//    url: '/api/pds_syslists',
//    dataType: 'json',
//    type: 'GET',
//    success: function(data) {
//      options = data;
//    }.bind(this),
//    error: function(xhr, status, err) {
//      //debugger;
//      console.error(this.props.url, status, err.toString());
//      options = [];
//    }.bind(this),
//    async: false
//  });
//
//  options = $.map(options , function(el){ return {value: el.id, label: el.System} } )
//  return options;
//};