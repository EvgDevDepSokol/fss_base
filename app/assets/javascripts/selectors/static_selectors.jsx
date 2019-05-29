'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import Select from 'react-select';
var createReactClass = require('create-react-class');

const DATA_VALVE_TYPES = require('../selectors/data/valve_types.js');
const DATA_MALFUNCTION_TYPES = require('../selectors/data/malfunction_types.js');
const DATA_RF_TYPES = require('../selectors/data/rf_types.js');
const DATA_BOOLEAN = require('../selectors/data/boolean.js');
const DATA_BOOLEANYN = require('../selectors/data/booleanyn.js');
const DATA_BOOLEANNUMB = require('../selectors/data/booleannumb.js');
const DATA_MOTOR_ZMNS = require('../selectors/data/motor_zmns.js');
const DATA_USER_RIGHTS = require('../selectors/data/user_rights.js');
const DATA_REGIDITY_UNIT = require('../selectors/data/regidity_unit.js');
const DATA_ANNOUNCIATOR_TYPE = require('../selectors/data/announciator_type.js');
const DATA_ANNOUNCIATOR_SIGN = require('../selectors/data/announciator_sign.js');
const DATA_SYSLIST_DESCRIPTOR = [
  { value: 'TH', label: 'TH' },
  { value: 'L', label: 'L' },
  { value: 'EL', label: 'EL' },
  { value: 'CR', label: 'CR' },
  { value: 'D', label: 'D' },
  { value: 'addl', label: 'addl' }
];
const DATA_SYSLIST_CATEGORY = [
  { value: '1', label: '1' },
  { value: '2', label: '2' },
  { value: '3', label: '3' }
];

class StaticSelector extends React.Component {
  static displayName = 'SomeStaticSelector';
  static propTypes = {
    label: PropTypes.string,
    value: PropTypes.string,
    attribute: PropTypes.string,
    clearable: PropTypes.bool,
    displayName: PropTypes.string,
    name: PropTypes.string,
    options: PropTypes.array,
    onValue: PropTypes.func
  };

  constructor(props) {
    super(props);
    var value = null;
    var label = props.value;
    const OPTIONS = props.options;
    OPTIONS.forEach(function(obj) {
      if (obj.label == label) {
        value = obj.value;
      }
    });

    this.state = {
      value: value
    };
  }

  setValue = value => {
    this.setState({ value: value });
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  };

  render() {
    var clearable = this.props.clearable ? this.props.clearable : false;
    return (
      <Select
        name={this.props.name}
        options={this.props.options}
        onChange={this.setValue}
        value={this.state.value}
        simpleValue={true}
        multi={false}
        clearable={clearable}
      />
    );
  }
}

class ValveTypeSelector extends React.Component {
  static displayName = 'ValveTypeSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_VALVE_TYPES}
        name="ValveType"
      />
    );
  }
}

class MalfunctionTypeSelector extends React.Component {
  static displayName = 'MalfunctionTypeSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_MALFUNCTION_TYPES}
        name="MalfunctionType"
      />
    );
  }
}

class BooleanSelector extends React.Component {
  static displayName = 'BooleanSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_BOOLEAN}
        name="Boolean"
      />
    );
  }
}

class BooleanYNSelector extends React.Component {
  static displayName = 'BooleanYNSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_BOOLEANYN}
        name="BooleanYN"
      />
    );
  }
}

class BooleanNumbSelector extends React.Component {
  static displayName = 'BooleanNumbSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_BOOLEANNUMB}
        name="BooleanNumb"
      />
    );
  }
}

class RFTypeSelector extends React.Component {
  static displayName = 'RFTypeSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_RF_TYPES}
        name="RFType"
      />
    );
  }
}

class MotorZmnSelector extends React.Component {
  static displayName = 'MotorZmnSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_MOTOR_ZMNS}
        name="MotorZmn"
      />
    );
  }
}

class UserRightsSelector extends React.Component {
  static displayName = 'UserRightsSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_USER_RIGHTS}
        name="UserRights"
      />
    );
  }
}

class RegidityUnitSelector extends React.Component {
  static displayName = 'RegidityUnitSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_REGIDITY_UNIT}
        name="RegidityUnit"
      />
    );
  }
}

class AnnounciatorTypeSelector extends React.Component {
  static displayName = 'AnnounciatorTypeSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_ANNOUNCIATOR_TYPE}
        name="AnnounciatorType"
        clearable={true}
      />
    );
  }
}

class AnnounciatorSignSelector extends React.Component {
  static displayName = 'AnnounciatorSignSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_ANNOUNCIATOR_SIGN}
        name="AnnounciatorSign"
        clearable={true}
      />
    );
  }
}

class SyslistDescriptorSelector extends React.Component {
  static displayName = 'SyslistDescriptorSelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_SYSLIST_DESCRIPTOR}
        name="SyslistDescriptor"
        clearable={true}
      />
    );
  }
}

class SyslistCategorySelector extends React.Component {
  static displayName = 'SyslistCategorySelector';
  render() {
    return (
      <StaticSelector
        value={this.props.value}
        attribute={this.props.attribute}
        onValue={this.props.onValue}
        options={DATA_SYSLIST_CATEGORY}
        name="SyslistCategory"
        clearable={true}
      />
    );
  }
}

module.exports.ValveTypeSelector = ValveTypeSelector;
module.exports.RFTypeSelector = RFTypeSelector;
module.exports.MalfunctionTypeSelector = MalfunctionTypeSelector;
module.exports.BooleanSelector = BooleanSelector;
module.exports.BooleanYNSelector = BooleanYNSelector;
module.exports.BooleanNumbSelector = BooleanNumbSelector;
module.exports.MotorZmnSelector = MotorZmnSelector;
module.exports.UserRightsSelector = UserRightsSelector;
module.exports.RegidityUnitSelector = RegidityUnitSelector;
module.exports.AnnounciatorTypeSelector = AnnounciatorTypeSelector;
module.exports.AnnounciatorSignSelector = AnnounciatorSignSelector;
module.exports.SyslistDescriptorSelector = SyslistDescriptorSelector;
module.exports.SyslistCategorySelector = SyslistCategorySelector;

module.exports.AnnounciatorSignSelector.options = DATA_ANNOUNCIATOR_SIGN;
module.exports.ValveTypeSelector.options = DATA_VALVE_TYPES;
module.exports.RFTypeSelector.options = DATA_RF_TYPES;
module.exports.MalfunctionTypeSelector.options = DATA_MALFUNCTION_TYPES;
module.exports.BooleanSelector.options = DATA_BOOLEAN;
module.exports.BooleanYNSelector.options = DATA_BOOLEANYN;
module.exports.BooleanNumbSelector.options = DATA_BOOLEANNUMB;
module.exports.MotorZmnSelector.options = DATA_MOTOR_ZMNS;
module.exports.UserRightsSelector.options = DATA_USER_RIGHTS;
module.exports.RegidityUnitSelector.options = DATA_REGIDITY_UNIT;
module.exports.AnnounciatorTypeSelector.options = DATA_ANNOUNCIATOR_TYPE;
module.exports.SyslistDescriptorSelector.options = DATA_SYSLIST_DESCRIPTOR;
module.exports.SyslistCategorySelector.options = DATA_SYSLIST_CATEGORY;
