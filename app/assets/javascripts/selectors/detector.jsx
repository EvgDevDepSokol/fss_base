// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

module.exports = React.createClass({
  displayName: 'DetectorSelector',

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
          '/api/pds_detectors',
          {pds_project_id:project.ProjectID},
          this
        );
        options = $.map(options , function(el){ return {value: el.id, label: el.tag} } )

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };


    return (
      React.createElement(Select.Async, {name: "Detector",
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
