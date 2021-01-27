// selector to be used for systems for all projects
'use strict';

var createReactClass = require('create-react-class');
import PropTypes from 'prop-types';
var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;
var path = '/selectors/pds_sys_descriptions';

module.exports = class extends React.Component {
  static displayName = 'SystemSelector';

  static propTypes = {
    label: PropTypes.string,
    value: PropTypes.string,
    id: PropTypes.number,
    attribute: PropTypes.string,
    clearable: PropTypes.bool,
    disabled: PropTypes.bool,
    displayName: PropTypes.string,
    name: PropTypes.string,
    options: PropTypes.array,
    onValue: PropTypes.func
  };

  state = {
    value: this.props.id,
    disabled: this.props.disabled
  };

  setValue = (value) => {
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
        value={this.state.value}
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
