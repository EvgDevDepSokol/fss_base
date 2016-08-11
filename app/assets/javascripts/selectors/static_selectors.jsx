'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
const DATA_VALVE_TYPES = require('../selectors/data/valve_types.js')
const DATA_MALFUNCTION_TYPES = require('../selectors/data/malfunction_types.js')
const DATA_RF_TYPES = require('../selectors/data/rf_types.js')
const DATA_BOOLEAN = require('../selectors/data/boolean.js')
const DATA_BOOLEANYN = require('../selectors/data/booleanyn.js')
const DATA_BOOLEANNUMB = require('../selectors/data/booleannumb.js')
const DATA_MOTOR_ZMNS = require('../selectors/data/motor_zmns.js')

var StaticSelector = React.createClass({

  getInitialState() {
    debugger
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
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_VALVE_TYPES}
        displayName = 'ValveTypeSelector'
        name = 'ValveType'
      />
    )
  }
});

var MalfunctionTypeSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_MALFUNCTION_TYPES}
        displayName = 'MalfunctionTypeSelector'
        name = 'MalfunctionType'
      />
    )
  }
});

var BooleanSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_BOOLEAN}
        displayName = 'BooleanSelector'
        name = 'Boolean'
      />
    )
  }
});

var BooleanYNSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_BOOLEANYN}
        displayName = 'BooleanYNSelector'
        name = 'BooleanYN'
      />
    )
  }
});

var BooleanNumbSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_BOOLEANNUMB}
        displayName = 'BooleanNumbSelector'
        name = 'BooleanNumb'
      />
    )
  }
});

var RFTypeSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_RF_TYPES}
        displayName = 'RFTypeSelector'
        name = 'RFType'
      />
    )
  }
});

var MotorZmnSelector = React.createClass({
  render: function() {
    return (
      <StaticSelector  value = {this.props.value} _this = {this}
        options = {DATA_MOTOR_ZMNS}
        displayName = 'MotorZmnSelector'
        name = 'MotorZmn'
      />
    )
  }
});



module.exports.ValveTypeSelector = ValveTypeSelector;
module.exports.RFTypeSelector = RFTypeSelector;
module.exports.MalfunctionTypeSelector = MalfunctionTypeSelector;
module.exports.BooleanSelector = BooleanSelector;
module.exports.BooleanYNSelector = BooleanYNSelector;
module.exports.BooleanNumbSelector = BooleanNumbSelector;
module.exports.MotorZmnSelector = MotorZmnSelector;
