'use strict';

var isNumber = require('lodash').isNumber;
var isString = require('lodash').isString;
var React = require('react');
var ReactDOM = require('react-dom');

var formatters = require('reactabular').formatters;
var predicates = require('reactabular').predicates;

module.exports = React.createClass({
  displayName: 'Search',

  propTypes: {
    onChange: React.PropTypes.func,
    data: React.PropTypes.array,
    columns: React.PropTypes.array
  },

  render:function() {
    var columns = this.props.columns || [];
    var options = [{
      value: 'all',
      name: 'Везде'
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
        query: ReactDOM.findDOMNode(this.refs.query).value,
        column: ReactDOM.findDOMNode(this.refs.column).value
      }
    });
  }
});


module.exports.search = function(search, columns, data) {
  var query = search.query;
  var column = search.column;
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

    if (!formattedValue && isNaN(formattedValue)) {
        return false;
    }

    if (isNumber(formattedValue)) {
        formattedValue = formattedValue.toString();
    }
    else if (!isString(formattedValue)) {
        formattedValue = '';
    }

    // TODO: allow strategy to be passed, now just defaulting to prefix
//    var predicate = predicates.prefix(query.toLowerCase());
//    return predicate.matches(formattedValue.toLowerCase());
    var query_arr = query.toLowerCase().split('*');
    var searchText = formattedValue.toLowerCase();
    var currentPosition = 0;
    var lpass = true;
    debugger
    for (var x = 0; x < query_arr.length; x++) {
      currentPosition = searchText.indexOf(query_arr[x]);
      searchText = searchText.slice(currentPosition+query_arr[x].length)
      if (x == 0 && query_arr[0] !== '') {
        lpass = lpass && (currentPosition === 0);
      } else {
        lpass = lpass && (currentPosition !== -1);
      }
    }  
    return lpass
//   var predicate = predicates.infix(query.toLowerCase());
//   return predicate.evaluate(formattedValue.toLowerCase());
  }
};

module.exports.matches = (column, value, query, options) => {
    if(!query) {
        return {};
    }

    options = options || {
        strategy: predicates.infix,
        transform: formatters.lowercase
    };

    var predicate = options.strategy(options.transform(query));

    return predicate.matches(options.transform(value));
};

function id(a) {
  return a;
}

function noop() {}
