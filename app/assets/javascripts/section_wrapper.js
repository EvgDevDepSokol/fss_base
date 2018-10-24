'use strict';

var React = require('react');


module.exports = React.createClass({
  displayName: 'SectionWrapper',

  propTypes: {
    errors: React.PropTypes.array,
    path: React.PropTypes.array,
    classes: React.PropTypes.array,
    description: React.PropTypes.string,
    key: React.PropTypes.string,
    title: React.PropTypes.string
  },

  render:function() {
    var errors = (this.props.errors || []).join('\n');
    var level = this.props.path.length;
    var classes = [].concat(errors ? 'error' : [],
      'form-section',
      (level > 0 ? 'form-subsection' : []),
      this.props.classes || []);
    var helpClasses = 'form-help' + (this.props.description ? '' : ' hidden');
    var errorClasses = 'form-error' + (errors ? '' : ' hidden');

    return (
      React.createElement('fieldset', {className: classes.join(' '), key: this.props.key},
        React.createElement('legend', {className: 'form-section-title'},
          this.props.title,
          React.createElement('span', {className: helpClasses, title: this.props.description}, '?'),
          React.createElement('span', {className: errorClasses, title: errors}, '!')
        ),
        this.props.children
      )
    );
  }
});
