// selector to be used for systems

'use strict';

var React = require('react');
var Select = require('react-select');


module.exports = React.createClass({
  displayName: 'PdsSectionAssemblerSelector',

  getInitialState() {
    return {
      value: this.props.value
    };
  },

  onChange(value, object) {
    if(object.length > 0) this.setState({value: object[0].label});
    var h = {};
    h[this.props.attribute] = value;
    this.props.onValue(h);
  },

  render: function() {

    var getOptions = function(input, callback) {
      setTimeout(function() {

        var options = [];
        $.ajax({
          url: '/api/pds_section_assemblers',
          dataType: 'json',
          type: 'GET',
          data:{pds_project_id:project.ProjectID},
          success: function(data) {
            options = data;
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
            options = [];
          }.bind(this),
          async: false
        });

        options = $.map(options , function(el){
          return {value: el.id, label: el.section_name}
        });

        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
          complete: true
        });
      }, 500);
    };


    return (
      React.createElement(Select, {name: "section_name",
        asyncOptions: getOptions,
        onChange: this.onChange,
        clearable: false,
        value: this.state.value
        })
    );
  }
});


//module.exports.options = function(){
//  var options = [];
//  $.ajax({
//    url: '/api/pds_section_assemblers',
//    dataType: 'json',
//    type: 'GET',
//    data:{pds_project_id:project.ProjectID},
//    success: function(data) {
//      options = data;
//    }.bind(this),
//    error: function(xhr, status, err) {
//      console.error(this.props.url, status, err.toString());
//      options = [];
//    }.bind(this),
//    async: false
//  });
//
//  options = $.map(options , function(el){
//    return {value: el.id, label: el.section_name}
//  });
//  return options;
//};
