// selector to be used for projects
'use strict';
var createReactClass = require('create-react-class');
import PropTypes from 'prop-types';

var React = require('react');
var Select = require('react-select');

module.exports = class extends React.Component {
  static displayName = 'ProjectSelector';
  static propTypes = { label: PropTypes.string };

  state = {
    value: this.props.value
  };

  onChange = (value, object) => {
    if (object.length > 0) this.setState({ value: object[0].label });
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  };

  render() {
    var getOptions = function(input, callback) {
      setTimeout(function() {
        var options = [];
        $.ajax({
          url: '/pds_projects',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            options = data;
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
            options = [];
          }.bind(this),
          async: false
        });

        options = $.map(options, function(el) {
          return { value: el.id, label: el.Project };
        });

        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
          complete: true
        });
      }, 5);
    };

    return (
      <Select
        name="Project"
        asyncOptions={getOptions}
        onChange={this.onChange}
        value={this.state.value}
        clearable={false}
        cache={false} />
    );
  }
};
