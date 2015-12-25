var React = require('react');
var Form = require('plexus-form');
var validate = require('plexus-validate');
var FieldWrapper = require('../field_wrapper.js');
var SectionWrapper = require('../section_wrapper.js');

var Select = require('react-select');

var SystemSelector = require('../selectors/system.jsx');


var schema = {
  title      : "My pretty form",
  description: "Declarative pure data DSLs are the best.",
  type       : "object",
  properties : {
    comment: {
      title      : "Your comment",
      description: "Type something here.",
      type       : "string",
      minLength  : 1
    }
  }
};


var schema = {

  properties: {
    TEquipID: {
      type: 'number'
    },
    typeE: {
      type: 'string'
    },
    System: {
      "x-hints" : {
        form: {
          inputComponent: "system_select"
        }
      }
    }
  },
  type: 'object'
};

var Uploader = React.createClass({
  componentDidMount: function() {
    var input = document.createElement('input');
    input.type = 'file';
    input.multiple = false;
    input.addEventListener('change', this.loadFile);
    this._input = input;
  },

  loadFile: function(event) {
    var files = event.target.files;
    var handleData = this.handleData;
    var file = files[0];
    var reader = new FileReader();

    reader.onload = function(event) {
      handleData(file, event.target.result);
    };

    reader.readAsText(file);
  },

  handleData: function(file, data) {
    this.props.onChange({
      name: file.name,
      type: file.type,
      size: file.size,
      data: data.slice(0, 1000) // truncate data in this demo
    });
  },

  openSelector: function() {
    this._input.click();
  },

  handleKeyPress: function(event) {
    this.props.onKeyPress(event);
  },

  render: function() {
    return (
      <button onClick = { this.openSelector }>
        Select a file
      </button>
    );
  }
});

var onSubmit = function(data, buttonValue, errors) {
  alert('Data  : '+JSON.stringify(data)+'\n'+
  'Button: '+buttonValue+'\n'+
  'Errors: '+JSON.stringify(errors));
};

var handlers = {
  select: SystemSelector,
  system_select: SystemSelector
};

/*
$(document).ready(function () {
  React.render(<Form
      buttons  = {[]}
      schema   = {schema}
      validate = {validate}
      fieldWrapper = {FieldWrapper}
      sectionWrapper = {SectionWrapper}
      handlers = {handlers}
      onSubmit = {onSubmit}
      submitOnChange = {true}
    />,
    document.getElementById('select_examplerr'));
});*/
