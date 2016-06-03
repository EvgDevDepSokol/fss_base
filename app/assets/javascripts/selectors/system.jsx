// selector to be used for systems for all projects

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

module.exports = React.createClass({
  displayName: 'SystemSelector',

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
          '/api/pds_sys_descriptions',
          {pds_project_id:project.ProjectID},
          this
        );
        options = $.map(options , function(el){ return {value: el.id, label: el.System} } )
        options.sort(function(a, b){
          var nameA=a.label.toLowerCase(), nameB=b.label.toLowerCase()
          if (nameA < nameB) //sort string ascending
            return -1 
          if (nameA > nameB)
            return 1
          return 0 //default return value (no sorting)
        })

        callback(null, {
          options: options,
          complete: true,
        });
      }, 0);
    };

    return (
      React.createElement(Select.Async, {name: "System",
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
