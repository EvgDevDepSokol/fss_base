'use strict';
var React = require('react');
import PropTypes from 'prop-types';
var createReactClass = require('create-react-class');

module.exports = class extends React.Component {
  static displayName = 'ColumnFilters';

  static propTypes = {
    onUserInput: PropTypes.func,
    ChangeFilter: PropTypes.func,
    columns: PropTypes.array,
    disabled: PropTypes.bool
  };

  state = { columns: this.props.columns, disabled: this.props.disabled };

  ChangeFilter = (e) => {
    var columns = this.props.columns;
    columns[e.target.id].filter = e.target.value;
    this.props.onUserInput(columns);
  };

  // this is just an example of a possible custom header component...
  // inputs does nothing right now (but we can implement filtering or insertion here)
  render() {
    var columns = this.props.columns;
    return (
      <tr>
        {columns.map((column, i) => {
          return (
            <td key={i + '-custom-header'}>
              {column.property ? (
                <input
                  className="header-input"
                  placeholder={'Фильтр...'}
                  onChange={this.ChangeFilter}
                  id={i}
                  name={column.property}
                  autoComplete="on"
                  disabled={this.props.disabled}
                />
              ) : (
                ''
              )}
            </td>
          );
        })}
      </tr>
    );
  }
};
