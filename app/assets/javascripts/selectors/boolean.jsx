// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'BooleanSelector',

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
     { value: 'false', label: 'НЕТ', clearableValue: 'false'},
     { value: 'true', label: 'ДА', clearableValue: 'false'}]

    return (
      React.createElement(Select, {name: "Boolean",
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
