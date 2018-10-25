'use strict';

//var React = require('react/addons');
//var React = require('react-addons-{addon}');
var React = require('react');
var ReactDOM = require('react-dom');
import PropTypes from 'prop-types';

module.exports = function() {
  return React.createClass({
    displayName: 'WideTextEditor',

    propTypes: {
      value: React.PropTypes.string,
      onValue: React.PropTypes.func
    },

    getInitialState: function() {
      return { value: this.props.value };
    },

    render: function() {
      return React.createElement('textarea', {
        className: 'wide-text',
        value: this.state.value,
        onChange: this.onChange,
        onKeyUp: this.keyUp,
        onBlur: this.done
      });
    },

    onChange: function(e) {
      this.setState({ value: e.target.value });
    },

    keyUp: function(e) {
      if (e.keyCode == 13) {
        // Enter pressed
        this.done();
      }
      if (e.keyCode == 27) {
        // ESC pressed
        this.cancel();
      }
      if (e.ctrlKey && e.keyCode == 13) {
        // Ctrl-Enter pressed
        this.save();
      }
    },

    done: function() {
      var h = {};
      h[this.props.attribute] = ReactDOM.findDOMNode(this).value;
      this.props.onValue(h);
    },
    cancel: function() {
      this.props.onCancel();
    },
    save: function() {
      var h = {};
      h[this.props.attribute] = ReactDOM.findDOMNode(this).value;
      this.props.onSave(h);
    }
  });
}.bind(this);
