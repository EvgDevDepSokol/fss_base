'use strict';

var React = require('react');
import PropTypes from 'prop-types';

module.exports = React.createClass({
  displayName: 'SelectRows',

  propTypes: {
    onChange: React.PropTypes.func,
    columns: React.PropTypes.array
  },

  onChange: function() {},

  render: function() {
    return (
      <span />

    //React.createElement("span", {className: "replace"},
    //  React.createElement("input", {type: "checkbox", onChange: this.onChange})
    //)
    );
  }
});

module.exports.addSelectColumn = function() {
  return {
    header: 'select',
    style: {
      width: '25px'
    },
    classes: 'select-rows-col',
    cell: function(value, celldata, rowIndex, property) {}
  };
};

module.exports.getRows = function(search, columns, data) {
  var query = search.query;
  var column = search.column;

  if (!query) {
    return data;
  }

  if (column !== 'all') {
    columns = columns.filter(function(col) {
      return col.property === column;
    });
  }

  return data.filter(
    function(row) {
      //debugger;
      return columns.filter(isColumnVisible.bind(this, row)).length > 0;
    }.bind(this)
  );

  function isColumnVisible(row, col) {
    var property = col.property;
    var value = row[property];
    var formatter = col.search || formatters.identity;

    if (col.nested) {
      var keys = property.split('.');
      var tempVal = row;
      keys.forEach(function(key) {
        if (tempVal) {
          tempVal = tempVal[key];
        }
      });
      value = tempVal;
    }

    var formattedValue = formatter(value);

    if (!formattedValue) {
      return false;
    }

    if (!isString(formattedValue)) {
      formattedValue = formattedValue.toString();
    }

    // TODO: allow strategy to be passed, now just defaulting to prefix
    var predicate = predicates.prefix(query.toLowerCase());

    return predicate.matches(formattedValue.toLowerCase());
  }
};
