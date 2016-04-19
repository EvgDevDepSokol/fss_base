// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'ValveTypeSelector',

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
     { value: 'valve', label: 'valve', clearableValue: 'false'},
     { value: 'vlv_cntr', label: 'vlv_cntr', clearableValue: 'false'},
     { value: 'vlv_pneumo', label: 'vlv_pneumo', clearableValue: 'false'},
     { value: 'vlv_hydr', label: 'vlv_hydr', clearableValue: 'false'},
     { value: 'vlv_sol', label: 'vlv_sol', clearableValue: 'false'},
     { value: 'vlv_check', label: 'vlv_check', clearableValue: 'false'},
     { value: 'vlv_relief', label: 'vlv_relief', clearableValue: 'false'},
     { value: 'R/C', label: 'R/C', clearableValue: 'false'}]

    return (
      React.createElement(Select, {name: "ValveType",
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
