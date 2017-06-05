// selector to be used for systems for all projects

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;
var path = '/selectors/pds_sys_descriptions';

module.exports = React.createClass({
  displayName: 'SystemSelector',

  getInitialState() {
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
        options.unshift({value: -1, label: 'Все'});
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
    {},
    this
  );
  return options;
};
