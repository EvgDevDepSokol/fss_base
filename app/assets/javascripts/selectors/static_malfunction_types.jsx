// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'MalfunctionTypeSelector',

  getInitialState() {
    return {
      value: this.props.value
    };
  },

  setValue(value) {
    onChange(value,this)
  },

  render: function() {

    var options = [
     { value: 'GBN', label: 'GBN', clearableValue: 'false'},
     { value: 'GBR', label: 'GBR', clearableValue: 'false'},
     { value: 'GVN', label: 'GVN', clearableValue: 'false'},
     { value: 'GVR', label: 'GVR', clearableValue: 'false'},
     { value: 'IBN', label: 'IBN', clearableValue: 'false'},
     { value: 'IBR', label: 'IBR', clearableValue: 'false'},
     { value: 'IVN', label: 'IVN', clearableValue: 'false'},
     { value: 'IVR', label: 'IVR', clearableValue: 'false'}]

    return (
      React.createElement(Select, {name: "MalfunctionType",
        options: options,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        clearable: false
      })
    );
  }
});
