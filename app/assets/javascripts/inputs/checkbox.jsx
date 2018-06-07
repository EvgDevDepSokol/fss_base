'use strict';

var React = require('react');
var ReactDOM = require('react-dom');
import PropTypes from 'prop-types';

module.exports = function() {
  return React.createClass({
    displayName: 'checkbox',

    propTypes: {
      value: React.PropTypes.boolean,
      onValue: React.PropTypes.func
    },

    getInitialState: function() {
      return {value: this.props.value};
    },

    render: function() {
      return (
        <span classname='checkbox'>
          <input type="checkbox" onClick={clickCheckBox()}/>
        </span>
      )
    },

    onChange: function(e) {
      this.setState({value: e.target.value});
    },

    done: function() {
      var h = {};
      h[this.props.attribute] = ReactDOM.findDOMNode(this).value
      this.props.onValue(h);
    }
  });
}.bind(this);
