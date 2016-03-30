// selector to be used for systems for all projects

'use strict';

var React = require('react');
var Select = require('react-select');
//var update = require('react-addons-update');
//var onChange = require('./selectors.jsx').onChange;

module.exports = React.createClass({
  displayName: 'SystemSelector',

  getInitialState() {
    return {
      //label: 'Везде'
      //value: -1
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
          url: '/api/pds_sys_descriptions',
          dataType: 'json',
          type: 'GET',
          data:{pds_project_id:project.ProjectID},
          success: function(data) {
            options = data;
          }.bind(this),
          error: function(xhr, status, err) {
            //debugger;
            console.error(this.props.url, status, err.toString());
            options = [];
          }.bind(this),
          async: false
        });
        debugger
        options = $.map(options , function(el){ return {value: el.id, label: el.System} } )
        options.sort(function(a, b){
          var nameA=a.label.toLowerCase(), nameB=b.label.toLowerCase()
          if (nameA < nameB) //sort string ascending
            return -1 
          if (nameA > nameB)
            return 1
          return 0 //default return value (no sorting)
        })
        var i;
        for (i = options.length-1;i>=0; --i) {
              options[i+1]=options[i];
        }
        options[0] = {value: -1, label: 'Везде'};
        callback(null, {
          options: options,
          // CAREFUL! Only set this to true when there are no more options,
          // or more specific queries will not be sent to the server.
          complete: true,
        });
      }, 0);
    };


    return (
      React.createElement(Select, {name: "System",
        asyncOptions: getOptions,
        onChange: this.onChange,
        //onChange: onChange,
        value: this.state.value,
        clearable: false,
        placeholder: 'Везде'
        })
    );
  }
});
