module.row_editor = function(editProperty, onValue, o) {
  onValue = onValue || noop;

  var context = this;
  var editor = o.editor;

  return function(value, data, rowIndex, property)  {
    var idx = rowIndex.toString() + '-' + property;
    var editedCell = context.state[editProperty];

    if(editedCell === idx) {
      return {
        value: React.createElement(editor, {
          value: value,
          onValue: function(value)  {
            var o = {};

            o[editProperty] = null;

            context.setState(o);

            onValue(value, data, rowIndex, property);
          }
        }),
      };
    }

    if(editor) {
      return {
        value: value,
        props: {
          onClick: function()  {
            var o = {};

            o[editProperty] = idx;

            context.setState(o);
          },
        }
      };
    }

    return value;
  };
};
