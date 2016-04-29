'use strict';

var React = require('react');
var ReactDOM = require('react-dom');

module.exports = React.createClass({
  displayName: 'Replace',

  propTypes: {
    onChange: React.PropTypes.func,
    columns: React.PropTypes.array
  },

  onSubmit: function(){
    $.ajax({
      url: '/api/mass_operations/update_all',
      dataType: 'json',
      data: {
        pds_project_id: project ? project.id : null,
        model: model_name,
        column: ReactDOM.findDOMNode(this.refs.column).value,
        from: ReactDOM.findDOMNode(this.refs.from).value,
        to: ReactDOM.findDOMNode(this.refs.to).value
      },
      type: 'PUT',
      success: function() {
        debugger;
        location.reload();
      }.bind(this),
      error: function(xhr, status, err) {
        debugger;
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render:function() {
    var columns = this.props.columns || [];
    var options = [{
     // value: 'all',
     // name: 'Везде'
    }].concat(columns.map(function(column)  {
      if(column.property && column.label) {
        if (column.editor){
          if (column.editor.displayName == 'stringEditor' || column.editor.displayName == 'textEditor'){
          return {
            value: column.property,
            name: column.label
        }}};
      }
    }).filter(id));

    return (
//        <span />
      React.createElement("span", {className: "replace"},
        React.createElement("select", {ref: "column"}, options.map(function(option)
            {return React.createElement("option", {key: option.value + '-option', value: option.value}, option.name);}
          )
        ),
        [
          React.createElement("input", {ref: "from"}),
          React.createElement("input", {ref: "to"}),
          React.createElement("button", {onClick: this.onSubmit, className: "btn btn-xs btn-default"}, "Replace")
        ]
      )
    );
  }
});

function id(a) {
  return a;
}


