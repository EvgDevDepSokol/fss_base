// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

module.exports = React.createClass({
  displayName: 'PdsSectionAssemblerSelector',

  getInitialState() {
    return {
      value: this.props.id
    };
  },

  setValue(value) {
    onChange(value,this)
  },

  render: function() {

    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = getSelectorOptions(
          '/api/pds_man_equips',
          {},
          this
        );
        options = $.map(options , function(el){ return {value: el.id, label: el.Type} });

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };

    return (
      React.createElement(Select.Async, {name: "PdsSectionAssembler",
        loadOptions: getOptions,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        clearable: false
      })
    );
  }
});
