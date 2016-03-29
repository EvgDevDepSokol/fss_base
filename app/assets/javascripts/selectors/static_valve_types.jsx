// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');

module.exports = React.createClass({
  displayName: 'ValveTypeSelector',

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
         { value: 'valve', label: 'valve', clearableValue: 'false'},
         { value: 'vlv_cnt', label: 'vlv_cnt', clearableValue: 'false'},
         { value: 'vlv_pneumo', label: 'vlv_pneumo', clearableValue: 'false'},
         { value: 'vlv_hydr', label: 'vlv_hydr', clearableValue: 'false'},
         { value: 'vlv_sol', label: 'vlv_sol', clearableValue: 'false'},
         { value: 'vlv_relief', label: 'vlv_relief', clearableValue: 'false'}]
 
        callback(null, {
          options: options,
          complete: true
        });
      }, 5);
    };

    return (
      React.createElement(Select, {name: "ValveType",
      asyncOptions: getOptions,
      onChange: this.onChange,
      value: this.props.value,
      clearable: false
      })
    );
  }
});
