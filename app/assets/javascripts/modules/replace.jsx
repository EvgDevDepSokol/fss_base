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

var findIndex = require('lodash').findIndex;

var CustomInput = React.createClass({
  displayName: 'CustomInput',

  propTypes: {
    editor: React.PropTypes.func,
    attribute: React.PropTypes.string,
  },

  getInitialState:function(){
    return {
      editor: this.props.editor,
      attribute: this.props.attribute,
      enabled: this.props.enabled
    }
  },

  render: function() {
    var attribute = this.props.attribute;
    var description = this.props.description;
    if (attribute) {
      var editor = eval(this.props.editor.displayName);
      return (
        <div className = 'replace-selector'>
          {React.createElement(editor,{onValue:function(){}, disabled:!this.props.enabled})}
        </div>
      );
    }else{
      return (
        <div className = 'replace-input-container'>
          <input className = 'replace-input' disabled = {!this.props.enabled}/>
        </div>
      );
    }
  }
});

module.exports = React.createClass({
  displayName: 'Replace',

  propTypes: {
    onChange: React.PropTypes.func,
    columns: React.PropTypes.array,
    data: React.PropTypes.array,
//    disabled: React.PropTypes.boolean
  },

  getInitialState:function(){
    return {
      editor: null,
      attribute: null,
      data: data,
      disabled: this.props.disabled,
      fromIndex: 0,
      toIndex: 0
    }
  },


  onSubmit: function(){
    var _this = this;
    var data = this.props.data;
    var attribute = this.state.attribute;
    var column = ReactDOM.findDOMNode(this.refs.column).value;
    if (attribute) {
      var from = ReactDOM.findDOMNode(this.refs.from).firstChild.childNodes[0].defaultValue;
      var to = ReactDOM.findDOMNode(this.refs.to).firstChild.childNodes[0].defaultValue;
    } else {
      var from = ReactDOM.findDOMNode(this.refs.from).children[0].value;
      var to = ReactDOM.findDOMNode(this.refs.to).children[0].value;
    } 
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
            column: attribute ? attribute : column,
            from: from,
            to: to,
            ids: ids,
            fromIndex: this.state.fromIndex,
            toIndex: this.state.toIndex
          },
          type: 'PUT',
          success: function(responce) {
            var new_data = JSON.parse(responce.new_data);

            if (new_data) {
              debugger
              
              var lsave = confirm('Количество измененнных записей: ' + new_data.length + '. Сохранить изменения?');
              if (lsave){
                $.ajax({
                  url: '/api/mass_operations/update_all_save',
                  dataType: 'json',
                  data: {
                    new_data: new_data,
                    column: attribute ? attribute : column,
                    model: model_name,
                  },
                  type: 'PUT',
                  success: function(responce) {
                    var cols = JSON.parse(responce.data);
                    var data = this.state.data;
                    var arr = column.split('.');
                    column = arr[0];
                    cols.forEach(function (col) {
                      var idx = findIndex(data, {id: col.id});
                      data[idx][column] = col[column];
                    });
                    this.props.onReplaceDone(data);
                  }.bind(_this),
                  error: function(xhr, status, err) {
                    console.error(this.props.url, status, err.toString());
                  }.bind(_this)
                });
              }
            }
          },
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
    columns.forEach(function (col) {
      if (col.property == tmp) {
        context.setState({
          attribute: col.attribute,
          editor: col.editor
        });
      }
    });
  },

  onRadioFromChange: function(e){
    var fromIndex = parseInt(e.target.value,10);
    var toIndex = this.state.toIndex;
    if (fromIndex!==2){
      toIndex = 0;
    };
    this.setState({fromIndex: fromIndex, toIndex: toIndex})
  },

  onRadioToChange: function(e){
    var toIndex = parseInt(e.target.value,10);
    this.setState({toIndex: toIndex})
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
      React.createElement('span', {className: 'replace'},
        <div>
          {React.createElement('select', {className: 'replace-column-selector', ref: 'column', onChange: this.onChangeColumn}, options.map(
                function(option){
                  return React.createElement('option', {key: option.name, value: option.value}, option.name);
                }
            )
          )}        
          <p>Где заменить</p>
        </div>,
        <div className='replace-from-radio-group'>
          <input type='radio' name='replace-from' value='0' checked={this.state.fromIndex===0} onChange={this.onRadioFromChange}/>
          <CustomInput
            ref='from'
            editor = {this.state.editor}
            attribute = {this.state.attribute}
            description = 'Что заменить'
            enabled = {this.state.fromIndex===0}
          /><br/>
          <input type='radio' name='replace-from' value='1' checked={this.state.fromIndex===1} onChange={this.onRadioFromChange}/> Заменить пустые<br/>
          <input type='radio' name='replace-from' value='2' checked={this.state.fromIndex===2} onChange={this.onRadioFromChange}/> Заменить все <br/>
        </div>,
        <div className='replace-to-radio-group'>
          <input type='radio' name='replace-to' value='0' checked={this.state.toIndex===0} onChange={this.onRadioToChange}/>
          <CustomInput
            ref='to'
            editor = {this.state.editor}
            attribute = {this.state.attribute}
            description = 'На что заменить'
            enabled = {this.state.toIndex===0}
          /><br/>
          <input type='radio' name='replace-to' value='1' checked={this.state.toIndex===1} onChange={this.onRadioToChange} disabled={this.state.fromIndex!==2}/> Заменить на пустые<br/>
        </div>,
        <button  onClick = {this.onSubmit} className = 'btn btn-xs btn-default' disabled={this.props.disabled}>
          Replace
        </button>
      )
    );
  }
});

function id(a) {
  return a;
}


