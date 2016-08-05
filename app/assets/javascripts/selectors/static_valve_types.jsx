// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
const VALVE_TYPES = require('../selectors/data/valve_types.js')

var StaticSelector = React.createClass({

  getInitialState() {
    var value = null;
    var label = this.props.value;
    const OPTIONS = this.props.options;
    OPTIONS.forEach(function (obj) {
      if (obj.label == label) {
        value = obj.value;
      }
    })
    return {
      value: value,
    };
  },

  setValue(value) {
    var _this = this.props._this;
    this.setState({value: value});
    var h = {};
    h[_this.props.attribute] = value;
    _this.props.onValue(h);
  },

  render: function() {
    return (
      React.createElement(Select, {
        displayName: this.props.displayName,
        name: this.props.name,
        options: this.props.options,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        clearable: false
      })
    );
  }
});

var ValveTypeSelector = React.createClass({
  displayName: 'ValveTypeSelector',
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} this = {this}
        options = {VALVE_TYPES}
        displayName = 'ValveTypeSelector'
        name = 'ValveType'
      />
    )
  }
});

module.exports = ValveTypeSelector;
