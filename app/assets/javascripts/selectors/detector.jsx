// selector to be used for systems

'use strict';

var React = require('react');
import VirtualizedSelect from 'react-virtualized-select';
//import Select from 'react-select';
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;
var path = '/selectors/pds_detectors';

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
          path,
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

module.exports.options = function(){
  var options = getSelectorOptions(
    path,
    {pds_project_id:project.ProjectID},
    this
  );
};
