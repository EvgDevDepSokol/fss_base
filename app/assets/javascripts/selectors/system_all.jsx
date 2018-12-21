// selector to be used for systems for all projects
'use strict';

var createReactClass = require('create-react-class');
import PropTypes from 'prop-types';
var React = require('react');
var Select = require('react-select');
var onChange = require('../selectors/selectors.jsx').onChange;
var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;
var path = '/selectors/pds_syslists';

module.exports = class extends React.Component {
  static displayName = 'SystemAllSelector';
  static propTypes = { label: PropTypes.string };

  state = {
    value: this.props.id,
    disabled: this.props.disabled
  };

  setValue = (value) => {
    onChange(value, this);
  };

  render() {
    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = getSelectorOptions(path, {}, this);
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
        multi={false}
        disabled={this.props.disabled}
        clearable={false}
        cache={false}
      />
    );
  }
};
module.exports.options = function() {
  var options = getSelectorOptions(path, {}, this);
  return options;
};
