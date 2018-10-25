// selector to be used for systems
'use strict';

var onChange = function(value, context) {
  context.setState({ value: value });
  var h = {};
  h[context.props.attribute] = value;
  context.props.onValue(h);
};

var getSelectorOptions = function(url, data, context) {
  var options = [];
  $.ajax({
    url: url,
    dataType: 'json',
    type: 'GET',
    data: data,
    success: function(data) {
      options = data;
    }.bind(context),
    error: function(xhr, status, err) {
      console.error(context.props.url, status, err.toString());
      options = [];
    }.bind(context),
    async: false
  });
  return options;
};

module.exports.onChange = onChange;
module.exports.getSelectorOptions = getSelectorOptions;
