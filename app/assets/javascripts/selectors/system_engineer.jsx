// selector to be used for systems for all projects
'use strict';
import PropTypes from 'prop-types';

var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;
var path = '/selectors/pds_sys_engs';

module.exports = class extends React.Component {
  static displayName = 'SystemEngineerSelector';

  static propTypes = {
    label: PropTypes.string,
    value: PropTypes.number,
    disabled: PropTypes.bool
  };

  state = {
    value: this.props.value,
    disabled: this.props.disabled
  };

  setValue = value => {
    this.setState({ value: value.system });
    onChange(value, this);
  };

  render() {
    var getOptions = function(input, callback) {
      var options = getSelectorOptions(
        path,
        { pds_project_id: project.ProjectID },
        this
      );
      callback(null, {
        options: options,
        complete: true
      });
    };

    return (
      <Select.Async
        name="System"
        loadOptions={getOptions}
        onChange={this.setValue}
        value={this.props.value}
        simpleValue={true}
        multi={false}
        clearable={false}
        disabled={this.props.disabled}
        cache={false}
      />
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
