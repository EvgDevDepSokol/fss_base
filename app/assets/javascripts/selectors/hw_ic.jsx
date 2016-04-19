// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

module.exports = React.createClass({
  displayName: 'HwIcSelector',

  getInitialState() {
    debugger
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
          '/api/hw_ics',
          {pds_project_id:project.ProjectID},
          this
        );
        options = $.map(options , function(el){ return {value: el.id, label: el.ref} } )

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };

    return (
      React.createElement(Select.Async, {name: "IC",
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
