// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');

module.exports = React.createClass({
  displayName: 'BooleanSelector',

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
         { value: 'false', label: 'НЕТ', clearableValue: 'false'},
         { value: 'true', label: 'ДА', clearableValue: 'false'}]
 
        callback(null, {
          options: options,
          complete: true
        });
      }, 5);
    };

    return (
      React.createElement(Select, {name: "Boolean",
      asyncOptions: getOptions,
      onChange: this.onChange,
      value: this.props.value,
      clearable: false
      })
    );
  }
});
