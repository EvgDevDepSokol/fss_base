// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

module.exports = React.createClass({
  displayName: 'PdsDetectorSelector',

  getInitialState() {
    return {
      value: this.props.id,
      disabled: this.props.disabled
    };
  },

  setValue(value) {
    onChange(value,this)
  },

  render: function() {

    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = getSelectorOptions(
          '/selectors/pds_detectors',
          {pds_project_id:project.ProjectID},
          this
        );
       // options = $.map(options , function(el){ return {value: el.value, label: el.label} } )

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };


    return (
      React.createElement(Select.Async, {name: "PdsDetector",
        loadOptions: getOptions,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        disabled: this.props.disabled,
        clearable: false
        })
    );
  }
});
