'use strict';

//var React = require('react/addons');
//var React = require('react-addons-{addon}');
var React = require('react');


module.exports = function()  {
  return React.createClass({
    displayName: 'TextEditor',

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
        React.createElement("textarea", {
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
      if(e.keyCode === 13) {
        this.done();
      }
    },

    done:function() {
      var h = {};
      h[this.props.attribute] = this.getDOMNode().value
      this.props.onValue(h);
    }
  });
}.bind(this);
