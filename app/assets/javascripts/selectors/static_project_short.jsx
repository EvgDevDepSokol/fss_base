// selector to be used for booleans

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'ProjectShortSelector',

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
     { value: 90        , label: 'ПМТ Смоленск-2'}, 
     { value: 87        , label: 'ПМТ СмАЭС-3'},
     { value: 83        , label: 'Курск-2'},
     { value: 80000001  , label: 'ПМТ КуАЭС-4'},
     { value: 88        , label: 'ПМТ БалАЭС-1'  }] 

    return (
      React.createElement(Select, {name: "Project",
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
