'use strict';

//var React = require('react/addons');
//var React = require('react-addons-{addon}');
var React = require('react');
var ReactDOM = require('react-dom');

module.exports = function()  {
  return React.createClass({
    displayName: 'stringEditor',

    propTypes: {
      value: React.PropTypes.string,
      onValue: React.PropTypes.func
    },

    getInitialState:function() {
      return {
        value: ''
      };
    },

    render:function() {
      return (
        React.createElement("input", {
            value: this.state.value || this.props.value,
            onChange: this.onChange,
            onKeyUp: this.keyUp,
            onBlur: this.done}
        )
      );
    },

    onChange:function(e) {
      this.setState({
        value: e.target.value
      });
    },

    keyUp:function(e) {
      if(e.keyCode == 13) {
        this.done();
      }
      if(e.keyCode == 27) {
        this.cancel();
      }
    },

    done:function() {
      var h = {};
      h[this.props.attribute] = ReactDOM.findDOMNode(this).value
      this.props.onValue(h);
    },
    cancel:function() {
      this.props.onCancel();
    }
  });
}.bind(this);
