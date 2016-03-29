// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');

module.exports = React.createClass({
  displayName: 'MalfunctionTypeSelector',

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

        var options = [
         { value: 'GBN', label: 'GBN', clearableValue: 'false'},
         { value: 'GBR', label: 'GBR', clearableValue: 'false'},
         { value: 'GVN', label: 'GVN', clearableValue: 'false'},
         { value: 'GVR', label: 'GVR', clearableValue: 'false'},
         { value: 'IBN', label: 'IBN', clearableValue: 'false'},
         { value: 'IBR', label: 'IBR', clearableValue: 'false'},
         { value: 'IVN', label: 'IVN', clearableValue: 'false'},
         { value: 'IVR', label: 'IVR', clearableValue: 'false'}]
 
        callback(null, {
          options: options,
          complete: true
        });
      }, 5);
    };

    return (
      React.createElement(Select, {name: "MalfunctionType",
      asyncOptions: getOptions,
      onChange: this.onChange,
      value: this.props.value,
      clearable: false
      })
    );
  }
});
