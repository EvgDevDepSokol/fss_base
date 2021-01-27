// selector to be used for systems for all projects
'use strict';
import React from 'react';
var createReactClass = require('create-react-class');
import PropTypes from 'prop-types';
import Select from 'react-select';

var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;
var path = '/selectors/pds_sys_descriptions';

module.exports = class extends React.Component {
  static displayName = 'SystemDocSelector';
  static propTypes = { label: PropTypes.string };

  state = {
    value: this.props.id,
    disabled: this.props.disabled
  };

  setValue = (value) => {
    this.setState({ value });
    var h = {};
    h['extra_data'] = value;
    this.props.onValue(h);
  };

  render() {
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

    return (
      <Select.Async
        name="System"
        loadOptions={getOptions}
        onChange={this.setValue}
        value={this.state.value}
        simpleValue={true}
        multi={true}
        disabled={this.props.disabled}
        clearable={false}
        closeOnSelect={false} />
    );
  }
};
module.exports.options = function() {
  var options = getSelectorOptions(
    path,
    { pds_project_id: project.ProjectID },
    this
  );
  return options;
};
