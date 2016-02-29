// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');


module.exports = React.createClass({
  displayName: 'BooleanSelector',

  getInitialState() {
    return {
      value: this.props.value
    };
  },

  onChange(value, object) {
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  },

  render: function() {

    var getOptions = function(input, callback) {
      setTimeout(function() {

        var options = [
         { value: 'false', label: 'НЕТ', clearableValue: 'false'},
         { value: 'true', label: 'ДА', clearableValue: 'false'}]
 
        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
          complete: true
        });
      }, 500);
    };

    return (
      React.createElement(Select, {name: "Boolean",
      asyncOptions: getOptions,
      onChange: this.onChange,
      value: this.props.value,
      clearable: false
      })
    );
  }
});

//module.exports.options = function(){
//  var options = []
//  options = [
//    { value: 'false', label: 'FALSE' },
//    { value: 'true', label: 'TRUE' }]
//  return options;
//};  
