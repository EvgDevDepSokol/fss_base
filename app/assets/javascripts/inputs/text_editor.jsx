'use strict';

var React = require('react');
import PropTypes from 'prop-types';
var createReactClass = require('create-react-class');

module.exports = function() {
  return class extends React.Component {
    static displayName = 'TextEditor';

    static propTypes = {
      value: PropTypes.string,
      attribute: PropTypes.string,
      onValue: PropTypes.func,
      onCancel: PropTypes.func,
      onSave: PropTypes.func
    };

    state = { value: this.props.value };

    render() {
      return (
        <textarea
          className="normal-text"
          value={this.state.value}
          onChange={this.onChange}
          onKeyUp={this.keyUp}
          onBlur={this.done}
        />
      );
    }

    onChange = (e) => {
      this.setState({ value: e.target.value });
    };

    keyUp = (e) => {
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
    };

    done = () => {
      var h = {};
      h[this.props.attribute] = this.state.value;
      this.props.onValue(h);
    };

    cancel = () => {
      this.props.onCancel();
    };

    save = () => {
      var h = {};
      h[this.props.attribute] = this.state.value;
      this.props.onSave(h);
    };
  };
}.bind(this);
