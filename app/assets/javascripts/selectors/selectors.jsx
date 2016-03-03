// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');

module.exports = function onChange(value, object) {
  debugger
  if(object){
    if(object.length > 0){
      this.setState({value: object[0].label});
    }
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  }
};
