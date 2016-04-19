// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'BooleanYNSelector',

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
     { value: 'нет', label: 'нет', clearableValue: 'false'},
     { value: 'да', label: 'да', clearableValue: 'false'}]

    return (
      React.createElement(Select, {name: "BooleanYN",
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
