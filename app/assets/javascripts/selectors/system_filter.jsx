// selector to be used for systems for all projects

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;
var path = '/api/pds_sys_descriptions';

module.exports = React.createClass({
  displayName: 'SystemSelector',

  getInitialState() {
    debugger
    return {
      value: this.props.value,
      disabled: this.props.disabled,
    };
  },

  setValue(value) {
    this.state.value=value.system;
    onChange(value,this)
  },

  render: function() {
    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = getSelectorOptions(
          path,
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
        value: this.props.value,
        simpleValue:true,
        multi: false,
        clearable: false,
        disabled: this.props.disabled,
        cache: false
        })
    );
  }
});
module.exports.options = function(){
  var options = getSelectorOptions(
    path,
    {pds_project_id:project.ProjectID},
    this
  );
  options = $.map(options , function(el){ return {value: el.id, label: el.System} } )
  return options;
};
