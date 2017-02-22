'use strict';

var _ = require('lodash');

var React = require('react');
var ReactDOM = require('react-dom');

module.exports = React.createClass({
  displayName: 'ColumnFilters',

  propTypes: {
    ChangeFilter: React.PropTypes.func,
    columns: React.PropTypes.array,
    //    disabled: React.PropTypes.boolean
  },

  getInitialState() {
    return {columns: this.props.columns, disabled: this.props.disabled};
  },

  ChangeFilter: function(e) {
    debugger
    var columns = this.props.columns;
    columns[e.target.id].filter = e.target.value;
    this.props.onUserInput(columns);
  },

  // this is just an example of a possible custom header component...
  // inputs does nothing right now (but we can implement filtering or insertion here)
  render() {
    var columns = this.props.columns;
    return (
      <tr>
        {columns.map((column, i) => {
          return (
            <td key={i + '-custom-header'}>
              {column.property
                ? <input className="header-input" placeholder={'Фильтр...'} onChange={this.ChangeFilter} id={i} name={column.property} autoComplete="on" disabled={this.props.disabled}/>
                : ''}
            </td>
          );
        })}
      </tr>
    );
  }

});
