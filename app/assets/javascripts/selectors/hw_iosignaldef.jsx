// selector to be used for systems
'use strict';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;
var path = '/selectors/hw_iosignaldefs';

module.exports = React.createClass({
  displayName: 'HwIosignaldefSelector',

  propTypes: { label: PropTypes.string },

  getInitialState() {
    return {
      value: this.props.id,
      disabled: this.props.disabled
    };
  },

  setValue(value) {
    onChange(value, this);
  },

  render: function() {
    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = getSelectorOptions(
          path,
          { pds_project_id: project.ProjectID },
          this
        );

        callback(null, {
          options: options,
          complete: true
        });
      }, 0);
    };

    return React.createElement(Select.Async, {
      name: 'HwPed',
      loadOptions: getOptions,
      onChange: this.setValue,
      value: this.state.value,
      simpleValue: true,
      multi: false,
      disabled: this.props.disabled,
      clearable: false,
      cache: false
    });
  }
});
module.exports.options = function() {
  var options = getSelectorOptions(
    path,
    { pds_project_id: project.ProjectID },
    this
  );
  return options;
};
