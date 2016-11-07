// selector to be used for systems for all projects

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;
var LocalStorageMixin = require('react-localstorage');

module.exports = React.createClass({
  displayName: 'SystemSelector',

  mixins: [LocalStorageMixin],

  getInitialState() {
    return {
      disabled: this.props.disabled,
      value_prev: ''
    };
  },

  setValue(value) {
    onChange(value,this)
    this.setState ({
      value_prev: this.state.value
    });
  },

  getDefaultProps: function() {
    return {
      stateFilterKeys: ['value']
    };
  },

  shouldComponentUpdate: function() {
    if(this.state.value_prev !== this.state.value) {
      this.setValue(this.state.value);
    };
    return true;
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
        var i;
        for (i = options.length-1;i>=0; --i) {
              options[i+1]=options[i];
        }
        options[0] = {value: -1, label: 'Все'};
        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
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
        clearable: false,
        disabled: this.props.disabled
        })
    );
  }
});

