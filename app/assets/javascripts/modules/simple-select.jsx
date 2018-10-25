var React = require('react');

var _ = require('underscore');

class SimpleSelect extends React.Component {
  constructor(props) {
    super(props);
    this.onChange = this.onChange.bind(this);
  }

  onChange(event) {
    this.props.onSelectChange(event.target.value);
  }

  render() {
    var options = this.props.options.map(function(option, i) {
      return (
        <option key={i + '-opt'} value={option.value}>
          {option.label}
        </option>
      );
    });
    options.unshift(
      <option key={'no-opt'} value="">
        Не выбрано
      </option>
    );

    return (
      <select value={this.props.value} onChange={this.onChange}>
        {options}
      </select>
    );
  }
}
module.exports = SimpleSelect.bind(this);
