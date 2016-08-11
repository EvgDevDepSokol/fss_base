// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

//function pad(str, max) {
//  str = str.toString();
//  return str.length < max ? pad("0" + str, max) : str;
//}

module.exports = React.createClass({
  displayName: 'SdSelector',

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
          //'/api/pds_sds',
          '/selectors/sd_sys_numbs',
          {pds_project_id:project.ProjectID},
          this
        );
        debugger
        options = $.map(options , function(el){
          //return {value: el.id, label: el.System + pad(el.Numb,2)}
          return {value: el.id, label: el.sd_link}
        });

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };

    return (
      React.createElement(Select.Async, {name: "SdSelector",
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
