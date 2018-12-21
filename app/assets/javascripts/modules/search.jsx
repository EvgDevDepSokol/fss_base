'use strict';

var isNumber = require('lodash').isNumber;
var isString = require('lodash').isString;

module.exports.search = function(search, columns, data) {
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

  return data.filter(function(row) {
    return columns.filter(isColumnVisible.bind(this, row)).length > 0;
  });

  function isColumnVisible(row, col) {
    var property = col.property;
    var value = row[property];
    var formatter =
      col.search ||
      function(val) {
        return val;
      };
    var editor = col.editor;

    function labelFromSelectorList(array, value) {
      var tmp = array.filter(function(obj) {
        if (obj.value === value) {
          return true;
        }
      });
      return tmp[0] ? tmp[0].label : '';
    }

    if (editor) {
      if (
        editor.displayName == 'BooleanNumbSelector' &&
        typeof value == 'number'
      ) {
        value = value == 0 ? 'нет' : 'да';
      }
      if (editor.displayName == 'ValveTypeSelector') {
        value = labelFromSelectorList(editor.options, value);
      }
      if (editor.displayName == 'BooleanSelector') {
        value = value ? 'да' : 'нет';
      }
      if (editor.displayName == 'BooleanNumbSelector') {
        value = labelFromSelectorList(editor.options, value);
      }
      if (editor.displayName == 'UserRightsSelector') {
        value = labelFromSelectorList(editor.options, value);
      }
      if (editor.displayName == 'SystemDocSelector') {
        value = row[property]['extra_label'];
      }
    }

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

    if (!formattedValue && isNaN(formattedValue)) {
      return false;
    }

    if (isNumber(formattedValue)) {
      formattedValue = formattedValue.toString();
    } else if (!isString(formattedValue)) {
      formattedValue = '';
    }

    var query_arr = query.toLowerCase().split('*');
    var searchText = formattedValue.toLowerCase();
    var currentPosition = 0;
    var lpass = true;
    for (var x = 0; x < query_arr.length; x++) {
      currentPosition = searchText.indexOf(query_arr[x]);
      searchText = searchText.slice(currentPosition + query_arr[x].length);
      if (x == 0 && query_arr[0] !== '') {
        lpass = lpass && currentPosition === 0;
      } else {
        lpass = lpass && currentPosition !== -1;
      }
    }
    return lpass;
  }
};

module.exports.matches = (column, value, query, options) => {
  if (!query) {
    return {};
  }

  var query_arr = query.toLowerCase().split('*');
  var searchText = value.toLowerCase();
  var currentPosition = 0;
  var matches = [
    {
      startIndex: null,
      length: 0
    }
  ];
  var lpass = true;
  var ilength = 0;

  for (var i = 0; i < query_arr.length; i++) {
    currentPosition = searchText.indexOf(query_arr[i]);
    ilength += currentPosition + query_arr[i].length;
    searchText = searchText.slice(currentPosition + query_arr[i].length);
    if (i == 0 && query_arr[0] !== '') {
      lpass = lpass && currentPosition === 0;
    } else {
      lpass = lpass && currentPosition !== -1;
    }
    if (matches[0].startIndex == null && query_arr[i] !== '') {
      matches[0].startIndex = currentPosition;
    }
    matches[0].length = ilength - matches[0].startIndex;
  }
  if (!lpass)
    matches = [
      {
        startIndex: 0,
        length: 0
      }
    ];
  return matches;
};
