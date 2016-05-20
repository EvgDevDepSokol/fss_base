'use strict';

var React = require('react');
var ReactDOM = require('react-dom');

var SystemSelector = require('../selectors/system.jsx');
var SystemAllSelector = require('../selectors/system_all.jsx');
var SystemFilterSelector = require('../selectors/system_filter.jsx');

var HwIcSelector = require('../selectors/hw_ic.jsx');
var DetectorSelector = require('../selectors/detector.jsx');
var PdsManEquipSelector = require('../selectors/pds_man_equips.jsx');
var PdsSectionAssemblerSelector = require('../selectors/pds_section_assembler.jsx');
var HwPedSelector = require('../selectors/hw_ped.jsx');
var PdsPanelSelector = require('../selectors/pds_panels.jsx');
var HwDevTypesSelector = require('../selectors/hw_dev_types.jsx');

var PdsMotorTypeSelector = require('../selectors/pds_motor_types.jsx');
var BooleanSelector = require('../selectors/boolean.jsx');
var BooleanYNSelector = require('../selectors/booleanyn.jsx');
var BooleanNumbSelector = require('../selectors/booleannumb.jsx');
var ProjectSelector = require('../selectors/project.jsx');
var ValveTypeSelector = require('../selectors/static_valve_types.jsx');
var MalfunctionTypeSelector = require('../selectors/static_malfunction_types.jsx');

// todo: fix
var SdSelector = require('../selectors/pds_sds.jsx');
var UnitSelector = require('../selectors/pds_project_units.jsx');
//var DocumentationSelector = require('../selectors/pds_man_equips.jsx');

var PdsEngineersSelector = require('../selectors/pds_engineers.jsx');
var PdsDocumentationsSelector = require('../selectors/pds_documentation.jsx');
var PdsValvesSelector = require('../selectors/pds_valves.jsx');

var CustomInput = React.createClass({
  displayName: 'CustomInput',

  propTypes: {
    editor: React.PropTypes.func,
    attribute: React.PropTypes.string
  },

  getInitialState:function(){
    return {
      editor: this.props.editor,
      attribute: this.props.attribute
    }
  },

  render: function() {
    var attribute = this.props.attribute;
    if (attribute) {
      var editor = eval(this.props.editor.displayName);
      debugger
      return (
        <div className = 'replace-selector'>
        {React.createElement(editor,{onValue:function(){}})} 
        </div>
      );
    }else{
      return (<input />);
    }
  }
});

module.exports = React.createClass({
  displayName: 'Replace',

  propTypes: {
    onChange: React.PropTypes.func,
    columns: React.PropTypes.array,
    data: React.PropTypes.array
  },

  getInitialState:function(){
    return {
      editor: null,
      attribute: null
    }
  },


  onSubmit: function(){
    var data = this.props.data;
    var attribute = this.state.attribute;
    if (attribute) {
      var column = attribute;
      var from = ReactDOM.findDOMNode(this.refs.from).firstChild.childNodes[0].defaultValue;
      var to = ReactDOM.findDOMNode(this.refs.to).firstChild.childNodes[0].defaultValue;
    } else {
      var column = ReactDOM.findDOMNode(this.refs.column).value;
      var from = ReactDOM.findDOMNode(this.refs.from).value;
      var to = ReactDOM.findDOMNode(this.refs.to).value;
    } 
    debugger
    var ids = [];

    if (column.length > 0) {
      data.forEach(function(row){
        if(row.checked) {
          ids.push(row.id);
        }
      });       
      
      if (ids.length > 0) { 
        $.ajax({
          url: '/api/mass_operations/update_all',
          dataType: 'json',
          data: {
            pds_project_id: project ? project.id : null,
            model: model_name,
            column: column,
            from: from,
            to: to,
            ids: ids
          },
          type: 'PUT',
          success: function() {
            location.reload();
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
          }.bind(this)
        });
      } else {
        alert("Поставьте галочки в строках, в которых желаете произвести замену!")
      }
    } else {
      alert("Выберите колонку, в которой будет производиться замена!")
    }

  },

  onChangeColumn: function(e){
    var tmp = e.target.value;
    var columns = this.props.columns;
    var context = this;
    debugger
    columns.forEach(function (col) {
      if (col.property == tmp) {
        context.setState({
          attribute: col.attribute,
          editor: col.editor
        });
      }
    });
  },

  render:function() {
    var columns = this.props.columns || [];
    var options = [{
    }].concat(columns.map(function(column)  {
      if(column.property && column.label) {
        if (column.editor){
          return {
            value: column.property,
            name: column.label
          }
        };
      }
    }).filter(id));

    return (
      React.createElement("span", {className: "replace"},
        React.createElement("select", {ref: "column", onChange: this.onChangeColumn}, options.map(function(option)
            {return React.createElement("option", {key: option.name, value: option.value}, option.name);}
          )
        ),
        [
          <CustomInput
            ref="from"
            editor = {this.state.editor}
            attribute = {this.state.attribute}
          />,
          <CustomInput
            ref="to"
            editor = {this.state.editor}
            attribute = {this.state.attribute}
          />,
          <button  onClick = {this.onSubmit} className = "btn btn-xs btn-default">
             Replace
          </button>,
        ]
      )
    );
  }
});

function id(a) {
  return a;
}


