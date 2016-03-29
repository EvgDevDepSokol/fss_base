// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');

module.exports = React.createClass({
  displayName: 'ProjectShortSelector',

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
         { value: 90        , label: 'ПМТ Смоленск-2'}, 
         { value: 87        , label: 'ПМТ СмАЭС-3'},
         { value: 83        , label: 'Курск-2'}'
         { value: 80000001  , label: 'ПМТ КуАЭС-4'},
         { value: 88        , label: 'ПМТ БалАЭС-1'  }] 
        callback(null, {
          options: options,
          complete: true
        });
      }, 5);
    };

    return (
      React.createElement(Select, {name: "Project",
      asyncOptions: getOptions,
      onChange: this.onChange,
      value: this.props.value,
      clearable: false
      })
    );
  }
});
