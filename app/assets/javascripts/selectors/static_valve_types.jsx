// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
const VALVE_TYPES = require('../selectors/data/valve_types.js')

module.exports = React.createClass({
  displayName: 'ValveTypeSelector',

  getInitialState() {
    var value = null;
    var label = this.props.value;
    VALVE_TYPES.forEach(function (obj) {
      if (obj.label == label) {
        value = obj.value;
      }
    })
    return {
      value: value
    };
  },

  setValue(value) {
    onChange(value,this)
  },

  render: function() {
    return (
      React.createElement(Select, {name: "ValveType",
        options: VALVE_TYPES,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        clearable: false
      })
    );
  }
});
