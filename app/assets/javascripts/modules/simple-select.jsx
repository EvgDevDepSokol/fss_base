var React = require('react');

var _ = require('underscore');

class SimpleSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: props.value
    };
    this.onChange = this.onChange.bind(this);
  }

  onChange(event) {
    // this.setState({value: event.target.value});
    this.props.onChange(event.target.value);
  }

  render() {

    var options = this.props.options.map(function(option) {
      return (
        <option value={option.value}>{option.label}</option>
      );
    });
    options.unshift(
      <option value="">Не выбрано</option>
    );
    return (
      <select value={this.state.value} onChange={this.onChange}>
        {options}
      </select>
    );
  }
};
module.exports = SimpleSelect.bind(this);
