// selector to be used for systems

'use strict';

var React = require('react');
//import React, { Component } from 'react'
import VirtualizedSelect from 'react-virtualized-select';
//import Select from 'react-select';
//var Select = require('react-select');
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

        callback(null, {
          options: options
        });
      }, 0);
    };

    return (
      React.createElement(VirtualizedSelect, {name: "PdsDetector",
        async: true,
        loadOptions: getOptions,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        disabled: this.props.disabled,
        clearable: false,
        cache: false
        })
    );
  }
});
