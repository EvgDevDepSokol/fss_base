'use strict';

var React = require('react/addons');


module.exports = function()  {
  return React.createClass({
    displayName: 'BooleanEditor',

    propTypes: {
      value: React.PropTypes.string,
      onClick: React.PropTypes.func,
      onValue: React.PropTypes.func
    },

    render:function() {
      return (
        React.createElement("span", null,
          React.createElement("button", {
              //disabled: this.props.value,
              onClick: this.onClickTrue
            }, "✓"
          ),
          React.createElement("button", {
              //disabled: !this.props.value,
              onClick: this.onClickFalse
            }, "✗"
          )
        )
      );
    },

    onClickTrue: function(){
      this.onClick(true);
    },

    onClickFalse: function(){
      this.onClick(false);
    },

    onClick:function(value) {
      var h = {};
      h[this.props.attribute] = value;
      this.props.onValue(h);
    }
  });
}.bind(this);
