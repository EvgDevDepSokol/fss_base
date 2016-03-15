'use strict';

var isString = require('lodash').isString;
var React = require('react');

var formatters = require('reactabular').formatters;
var predicates = require('reactabular').predicates;

module.exports = React.createClass({
  displayName: 'Search',

  propTypes: {
    onChange: React.PropTypes.func,
    columns: React.PropTypes.array
  },

  render:function() {
    var columns = this.props.columns || [];
    var options = [{
      value: 'all',
      name: 'All'
    }].concat(columns.map(function(column)  {
        if(column.property && column.header) {
          return {
            value: column.property,
            name: column.header
          };
        }
      }).filter(id));

    return (
      React.createElement("span", {className: "search"},
        React.createElement("select", {ref: "column", onChange: this.change}, options.map(function(option)
            {return React.createElement("option", {key: option.value + '-option', value: option.value}, option.name);}
          )
        ),
        React.createElement("input", {ref: "query", onChange: this.change})
      )
    );
  },

  change:function() {
    (this.props.onChange || noop)({
      search: {
        query: this.refs.query.getDOMNode().value,
        column: this.refs.column.getDOMNode().value
      }
    });
  }
});


module.exports.search = function(search, columns, data) {
  var query = search.query;
  var column = search.column;
  debugger
  if(!query) {
    return data;
  }

  if(column !== 'all') {
    columns = columns.filter(function(col)
      {return col.property === column;}
    );
  }

  return data.filter(function(row)
    {
      //debugger;
      return columns.filter(isColumnVisible.bind(this, row)).length > 0;
//    }.bind(this)
    }
  );

  function isColumnVisible(row, col) {
    var property = col.property;
    var value = row[property];
    var formatter = col.search || formatters.identity;

    if(col.nested)
    {
      var keys = property.split(".");
      var tempVal = row;
      keys.forEach(function(key){
        if(tempVal){
          tempVal = tempVal[key];
        }
      });
      value = tempVal;
    }

    var formattedValue = formatter(value);

    if (!formattedValue) {
      return false;
    }

    if(!isString(formattedValue)) {
      formattedValue = formattedValue.toString();
    }

    // TODO: allow strategy to be passed, now just defaulting to prefix
//    var predicate = predicates.prefix(query.toLowerCase());
//    return predicate.matches(formattedValue.toLowerCase());

    var predicate = predicates.infix(query.toLowerCase());
    return predicate.evaluate(formattedValue.toLowerCase());
  }
};

function id(a) {
  return a;
}

function noop() {}
