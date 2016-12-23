'use strict';

var React = require('react');
var ReactDOM = require('react-dom');
var _ = require('underscore');

var Paginator = require('react-pagify').default;

import {Table,ColumnNames,sortColumn,formatters,cells,editors} from 'reactabular';

var LocalStorageMixin = require('react-localstorage');
var segmentize = require('segmentize');

var findIndex = require('lodash').findIndex;
var orderBy = require('lodash').orderBy;

var titleCase = require('title-case');

var SystemSelector = require('../selectors/system.jsx');
var SystemAllSelector = require('../selectors/system_all.jsx');
var SystemFilterSelector = require('../selectors/system_filter.jsx');

var HwIcSelector = require('../selectors/hw_ic.jsx');
var DetectorSelector = require('../selectors/detector.jsx');
var PdsManEquipSelector = require('../selectors/pds_man_equips.jsx');
var PdsSectionAssemblerSelector = require('../selectors/pds_section_assembler.jsx');
var HwPedSelector = require('../selectors/hw_ped.jsx');
var HwIosignaldefSelector = require('../selectors/hw_iosignaldef.jsx');
var PdsPanelSelector = require('../selectors/pds_panels.jsx');
var HwDevTypesSelector = require('../selectors/hw_dev_types.jsx');
var PdsEquipSelector = require('../selectors/pds_equip.jsx');

//some static selectors
var PdsMotorTypeSelector = require('../selectors/pds_motor_types.jsx');
var ProjectSelector = require('../selectors/project.jsx');

var MalfunctionTypeSelector = require('../selectors/static_selectors.jsx').MalfunctionTypeSelector;
var RFTypeSelector = require('../selectors/static_selectors.jsx').RFTypeSelector;
var ValveTypeSelector = require('../selectors/static_selectors.jsx').ValveTypeSelector;
var BooleanSelector = require('../selectors/static_selectors.jsx').BooleanSelector;
var BooleanYNSelector = require('../selectors/static_selectors.jsx').BooleanYNSelector;
var BooleanNumbSelector = require('../selectors/static_selectors.jsx').BooleanNumbSelector;
var MotorZmnSelector = require('../selectors/static_selectors.jsx').MotorZmnSelector;
var UserRightsSelector = require('../selectors/static_selectors.jsx').UserRightsSelector;
var RegidityUnitSelector = require('../selectors/static_selectors.jsx').RegidityUnitSelector;
var AnnounciatorTypeSelector = require('../selectors/static_selectors.jsx').AnnounciatorTypeSelector;
var AnnounciatorSignSelector = require('../selectors/static_selectors.jsx').AnnounciatorSignSelector;

// todo: fix
var SdSelector = require('../selectors/pds_sds.jsx');
var UnitSelector = require('../selectors/pds_project_units.jsx');
var UnitAllSelector = require('../selectors/pds_units.jsx');
var PdsEngineersSelector = require('../selectors/pds_engineers.jsx');
var PdsDocumentationsSelector = require('../selectors/pds_documentation.jsx');
var PdsValvesSelector = require('../selectors/pds_valves.jsx');

// modules
var Search = require('../modules/search.jsx');
var Replace = require('../modules/replace.jsx');
var ColumnFilters = require('../modules/column_filters.jsx');

var stringEditor =  require('../inputs/input.jsx')();
var dateEditor =  require('../inputs/input.jsx')();
var TextEditor =  require('../inputs/text_editor.jsx')();
var WideTextEditor =  require('../inputs/wide_text_editor.jsx')();

var Modal = require('react-modal');
const DATA_VALVE_TYPES = require('../selectors/data/valve_types.js')
const DATA_RF_TYPES = require('../selectors/data/rf_types.js')
const DATA_MALFUNCTION_TYPES = require('../selectors/data/malfunction_types.js')
const DATA_BOOLEAN = require('../selectors/data/boolean.js')
const DATA_BOOLEANYN = require('../selectors/data/booleanyn.js')
const DATA_BOOLEANNUMB = require('../selectors/data/booleannumb.js')
const DATA_USER_RIGHTS = require('../selectors/data/user_rights.js')
const DATA_ANNOUNCIATOR_TYPE = require('../selectors/data/announciator_type.js')
const DATA_ANNOUNCIATOR_SIGN = require('../selectors/data/announciator_sign.js')

var TableContainer = React.createClass({
  displayName: 'VniiaesFullTable',

  mixins: [LocalStorageMixin],

  getDefaultProps: function() {
    return {
      stateFilterKeys: ['systemFilter']
    };
  },


  getInitialState: function() {
    var _this=this;


    var properties = augmentWithTitles({
      TEquipID: {
        type: 'number'
      },
      typeE: {
        type: 'string'
      }
    });

    var editable = cells.edit.bind(this, 'editedCell',
        function(value, celldata, rowIndex, property)  {
      var idx = findIndex(this.state.data, {
        tEquipID: celldata[rowIndex].tEquipID
      });

      this.state.data[idx][property] = value;

      this.setState({
        data: data
      });
    }.bind(this));

    var highlighter = function (column) {
      return formatters.highlight(function (value) {
      var columns = _this.props.columns;
      var query = null;
      columns.forEach(function (col) {
        if (col.property == column) {
          if (col.filter) {
            query = col.filter;
          }
        }
      });
      if(query==null) query='';
        return Search.matches(column, value, query);
      });
    };    

    var editableField = function(options) {

      var editor = options.editor; 
      var attribute = options.attribute;
      var context = this;
      var nested = options.nested;
      function labelFromSelectorList(array, value) {
        var tmp = array.filter(function(obj) {
          if ( obj.value === value ) {
            return true
          }
        });
        return tmp[0] ? tmp[0].label : '';
      }        
      return function(value, data, rowIndex, property) {
        var id;
        if(nested)
        {
          var keys = property.split(".");
          var tempVal = data[rowIndex];

          if (tempVal[keys[0]]) id = tempVal[keys[0]].id
          keys.forEach(function(key){
            if(tempVal){
              tempVal = tempVal[key];
            };
          });
          value = tempVal;
        }

        if(value==null) value = '';

        if (editor) {
          if ((editor == BooleanNumbSelector) && (typeof(value) == "number")){
            value = (value == 0) ? "нет" : "да";
          }
          if (editor == ValveTypeSelector){
            value = labelFromSelectorList(DATA_VALVE_TYPES, value) 
          }
          if (editor == BooleanSelector){
            value = value ? "да" : "нет";
          }
          if (editor == BooleanNumbSelector){
            value = labelFromSelectorList(DATA_BOOLEANNUMB, value) 
          }
          if (editor == UserRightsSelector){
            value = labelFromSelectorList(DATA_USER_RIGHTS, value) 
          }
        }

        var editedRow = context.state["editedRow"];
        if (editedRow === rowIndex) {
          return {
            value: React.createElement(editor, {
              value: value,
              id: id,
              attribute: attribute || property,
              onValue: function (valueHash) {
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({lockRow: true, sendData: sendData});
              },
              onCancel: function(){
                var celldata = data[rowIndex];
                if(celldata.newRow){
                 var idx = findIndex(context.state.data, {_id: celldata._id});

                 context.state.data.splice(idx, 1);
                 context.setState({
                   data: context.state.data,
                   editedRow: null,
                   lockRow: false,
                   sendData: {}
                 });
                } else {
                  context.setState({ editedRow: null, lockRow: false, sendData: {} });
                }
              },
              onSave: function (valueHash) {
                var celldata = data[rowIndex];
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({lockRow: true, sendData: sendData});
                context.onSaveClick(celldata);
              },
            })
          };
        }
        if (editor) {
          return {
            value: value,
            props: {
              onDoubleClick: function () {
                if(!context.state.lockRow){
                  if (current_user.user_rights >= 1){
                    context.setState({editedRow: rowIndex, lockRow: true});
                  } else {
                    alert('У Вас недостаточно прав для редактирования записи!');
                  }
                }
              }
            }
          };
        };
      }
    }.bind(this);

    var nestedValue = function(options) {
      return function(value, data, rowIndex, property) {
        var keys = property.split(".");
        var tempVal = data[rowIndex];

        keys.forEach(function(key){
          if(tempVal){
            tempVal = tempVal[key];
          }
        });

        if(tempVal==null) tempVal = '';
        return {value: tempVal};
      }
    }.bind(this);

    var columns = this.props.columns.map(function(column){
      var h = column; //  {property: column.property, header: column.header, };
      if (column.editor=='TextEditor') {
        column.headerClassStyle = 'header-text-col'
      } else if (column.editor=='WideTextEditor') {
        column.headerClassStyle = 'header-wide_text-col'
      } else if (column.property=='system.System') {
        column.headerClassStyle = 'header-sys_sys-col'
      } else if (!column.nested){
        column.headerClassStyle = 'header-'+column.property+'-col'
      } else {
        var keys = column.property.split(".");
        column.headerClassStyle = 'header-'+keys[keys.length-1]+'-col'
      }
      if(column.editor) {
        column['editor'] = eval(column.editor);
        h["cell"] = [editableField(column),highlighter(h.property)]
        //h["cell"] = [editableField(column)]
      }else if(column.nested) {
        h["cell"] = [nestedValue(column),highlighter(h.property)];
        //h["cell"] = [nestedValue(column)];
      }
      return (h);
    });

    // remove hidden elements
    columns = columns.filter(function(e){return e.hidden != true});


    // add buttons
    columns = columns.concat([
      {
        header:
        <div className = 'buttons-col'>
          Кнопки
        </div>,
        headerClassStyle: 'header-buttons-col',
        cell: function(value, celldata, rowIndex, property){
          var url = window.location.href;
          var newRow = celldata[rowIndex].newRow;
          var itemId = celldata[rowIndex].id;
          var idx = findIndex(this.state.data, {id: itemId});

          var remove = function() {
            debugger
            if (this.props.objectType=='pds_malfunction_dim') return;
            if (current_user.user_rights >= 2){
              var res = confirm("Вы действительно желаете удалить запись?"); 
              if(!res) return;
              if(newRow){
                var idx = findIndex(this.state.data, {_id: celldata[rowIndex]._id});

                this.state.data.splice(idx, 1);
                this.setState({
                  data: this.state.data,
                  editedRow: null,
                  lockRow: false,
                  sendData: {}
                });
              }else{
                var idx = findIndex(this.state.data, {id: itemId});
                $.ajax({
                  url: url + '/' + itemId,
                  dataType: 'json',
                  type: 'DELETE',
                  success: function(data) {
                    this.state.data.splice(idx, 1);
                    this.setState({
                      data: this.state.data,
                      editedRow: null
                    });
                  }.bind(this),
                  error: function(xhr, status, err) {
                    var jtmp = xhr.responseJSON['errors'];
                    var result="Не удалось удалить запись. Причина:\n\n";
                    for( key in jtmp){
                      result+= jtmp[key]+'\n';
                    }
                    alert(result);
                  }.bind(this)
                });
              }
            } else {
              alert('У Вас недостаточно прав для удаления записи!');
            }

          }.bind(this);

          var copy = function() {
            if (current_user.user_rights >= 2 ){
              this.onAddRowClick(celldata[rowIndex]);
            } else {
              alert('У Вас недостаточно прав для дублирования записи!');
            }
          }.bind(this);

          var editClick = function() {
            if (current_user.user_rights >= 1 ){
              this.setState({editedRow: rowIndex});
            } else {
              alert('У Вас недостаточно прав для редактирования записи!');
            }
          }.bind(this);

          var cancelClick = function() {
            this.setState({ editedRow: null, lockRow: false, sendData: {} });
          }.bind(this);

          var saveClick = function() {
            this.onSaveClick(celldata[rowIndex]);
          }.bind(this);


          var editButton = <span className='edit btn btn-xs btn-default' onClick={editClick.bind(this)} style={{cursor: 'pointer'}} title='Редактировать запись'>
              <i className="fa fa-pencil"></i>
            </span>;

          var saveButton = <span className='edit btn btn-xs btn-default' onClick={saveClick.bind(this)} style={{cursor: 'pointer'}} title='Сохранить изменения'>
              <i className="fa fa-check"></i>
          </span>;

          if(!newRow){
            var cancelButton = <span className='edit btn btn-xs btn-default' onClick={cancelClick.bind(this)} style={{cursor: 'pointer'}} title='Отменить изменения'>
              <i className="fa fa-undo"></i>
            </span>;
          }

          var deleteButton = <span className='remove btn btn-xs btn-danger' onClick={remove.bind(this)} style={{cursor: 'pointer'}} title='Удалить запись'>
              <i className="fa fa-times"></i>
            </span>;

          var copyButton = <span className='remove btn btn-xs btn-default' onClick={copy.bind(this)} style={{cursor: 'pointer'}} title='Дублировать запись'>
            <i className="fa fa-files-o"></i>
          </span>;
          return {
            value: (

              <span style={ {width: '100px'} } >
                { this.state["editedRow"] === rowIndex ? [ saveButton, cancelButton ] : [editButton, copyButton] }
                {deleteButton}
              </span>
            )
          };
        }.bind(this)
      }
    ]);

    var clickMainCheckboxY = function(e){
      this.state.mainCheckbox_new = true
      this.setState({
        mainCheckbox_new: true,
        mainCheckbox_old: false
      });
    }

    var clickMainCheckboxN = function(e){
      this.state.mainCheckbox_new = false
      this.setState({
        mainCheckbox_new: false,
        mainCheckbox_old: true
      });
    }

    var mainCheckbox =
      <div className = "two-checkboxes">
        <input
          type="checkbox"
          onChange={clickMainCheckboxY.bind(this)}
          checked = {true}/>
        <input
          type="checkbox"
          onChange={clickMainCheckboxN.bind(this)}
          checked = {false}/>
      </div>;

    var column_x = ([
      {
        header:
          <div>
            {mainCheckbox} 
          </div>,
        headerClassStyle: 'header-checkbox-col',
        classes: 'checkbox-col',
        cell: function(value, celldata, rowIndex, property){
          var itemId = celldata[rowIndex].id;
          var idx = findIndex(this.state.data, {id: itemId});
          var clickCheckBox = function(){
              this.state.data[idx].checked = !this.state.data[idx].checked;
              this.setState({
                data: this.state.data,
              });
          }
 
          if (idx > -1){
          var checkBox = <span className = 'checkbox'>
            <input
              type = "checkbox"
              onChange = {clickCheckBox.bind(this)}
              checked = {this.state.data[idx].checked? this.state.data[idx].checked : false}
            />            
          </span>;
          } else {
          var checkBox = <span className = 'checkbox'>
            <input
              type = "checkbox"
            />            
          </span>;
 
          }

          return {
            value: (
              <span style={ {width: '30px'} } >
                {checkBox}
              </span>
            )
          };

        }.bind(this)
      }
    ]);

    columns = column_x.concat(columns);
    column_x = null;

    columns.map(function(column){
      column.label = column.header
    });
    var myDefaultSorter = function (data, column) {
      var property = column.property;
  
      data.sort(function(a, b)  {
        var p1 = getNestedKey(a, property) || '';
        var p2 = getNestedKey(b, property) || '';
  
        if(p1.localeCompare) {
          return p1.localeCompare(p2) * column.sort;
        }
  
        return (p1 - p2) * column.sort;
      });
    };

    return {
      editedRow: null,
      lockRow: false,
      sendData: {},
      data: this.props.data,
      columns: columns,
      formatters: formatters,
      showFilters: false,
      showReplace: false,
      mainCheckbox_new: false,
      mainCheckbox_old: false,
      systemFilter: null,
      pagination: {
        page: 1,
        perPage: 20
      },
      search: {
        query: '',
        column: ''
      },
      header: {
        onClick: function(column){
          if (!((column.classes == 'buttons-col')||(column.classes == 'checkbox-col')||(this.state.lockRow))){
            sortColumn(
              this.state.columns,
              column,
              this.setState.bind(this),
            );
          }
        }.bind(this)
      },
      modal: {
        title: 'title',
        content: 'content'
      }
    };
  },

  onSearch: function(search) {
    this.setState(search);
  },

  columnFilters() {
    var headerConfig = this.state.header;
    
    var columns = this.state.columns;

    var isEditableColumn = function(column) {
      var className = column.editor ? 'editableColumn' : 'notEditableColumn';
      var header = column.header;
      if (!header.props){
        column.header = <span className = {className}>
          {header}
        </span>
      }
      return column
    }
    columns.every(isEditableColumn);

    // if you don't want an header, just return;
    return (
        this.state.showFilters ?
      <thead>
        <ColumnNames
          config={headerConfig}
          columns={columns}
        />
        <ColumnFilters
          columns={columns}
          onUserInput={this.onFilterInput}
          disabled={this.state.lockRow}
          />
      </thead> :
      <thead>
        <ColumnNames
          config={headerConfig}
          columns={columns}
        />
      </thead> 


    );
  },  

  onFilterInput: function(columns) {
    this.setState({
      columns: columns,
    });
  },

// handlers
  onSelect: function(page) {
    if(this.state.lockRow)
      return;
    var pagination = this.state.pagination || {};
    var pages = Math.ceil(this.state.data.length / pagination.perPage);

    pagination.page = Math.min(Math.max(page, 1), pages);

    this.setState({
      pagination: pagination
    });
  },

  onPerPage: function(e) {
    var pagination = this.state.pagination || {};
    if ( parseInt(e.target.value, 10)> 200) e.target.value = '200';
    var PerPage = parseInt(e.target.value, 10);
    if (pagination.perPage !== PerPage){
      pagination.perPage = PerPage;
      this.setState({
        pagination: pagination
      });
    }
  },

  onPage: function(e) {
    var pagination = this.state.pagination || {};
    var pages = Math.ceil(this.state.data.length / pagination.perPage);
    var page = parseInt(e.target.value, 10);
    if (isNaN(page)) page=1;
    pagination.page = Math.min(Math.max(page, 1), pages);

    this.setState({
      pagination: pagination
    });
  },

  onSaveClick: function(celldata) {
    if(!$.isEmptyObject(this.state.sendData))
    {
      var newRow = celldata.newRow;
      var url = window.location.href;
      var itemId = celldata.id;
      var idx = findIndex(this.state.data, {id: itemId});
      var d = {};
      d[this.props.objectType] = this.state.sendData;
      if(newRow){
        idx = findIndex(this.state.data, {_id: celldata._id});
        d[this.props.objectType].Project = project.id;
        debugger
        $.ajax({
          url: url,
          dataType: 'json',
          contentType: 'application/json; charset=UTF-8',
          type: 'POST',
          data: JSON.stringify(d),
          success: function(response) {
            this.state.data[idx] = response.data;
            this.setState({
              data: this.state.data,
              lockRow: false,
              sendData: {},
              editedRow: null
            });
          }.bind(this),
          error: function(xhr, status, err) {
            var jtmp = xhr.responseJSON['errors'];
            var result="Не удалось сохранить запись. Причина:\n\n";
            for( key in jtmp){
              result+= jtmp[key]+'\n';
            }
            alert(result);
          }.bind(this)
        });
      }else{
        $.ajax({
          url: url + '/' + itemId,
          dataType: 'json',
          type: 'PUT',
          data: d,
          success: function(response) {
            if (response.data.MalfunctDimID){
              response.data.system=response.data.pds_malfunction.system
            }
            this.state.data[idx] = response.data;
            this.setState({
              data: this.state.data,
              lockRow: false,
              sendData: {},
              editedRow: null
            });
          }.bind(this),
          error: function(xhr, status, err) {
            var jtmp = xhr.responseJSON['errors'];
            var result="Не удалось сохранить запись. Причина:\n\n";
            for( key in jtmp){
              result+= jtmp[key]+'\n';
            }
            alert(result);
          }.bind(this)
        });
      }
    }else
    {
      this.setState({
        lockRow: false,
        sendData: {},
        editedRow: null
      });
    }
  },

  onAddRowClick: function(copiedRow){
    if (this.state.lockRow) return;
    if (this.props.objectType=='pds_malfunction_dim') return;
    if (current_user.user_rights >= 2 ){
      var copyRow = {};
      if (copiedRow.id) {
        copyRow = $.extend({}, copiedRow);
      } else if (this.state.showFilters){
        alert('Добавить запись при работающих фильтрах можно только дублированием одной из записей. Либо нужно отключить фильтры.');
        return;
      } else {
        var columns=this.state.columns;
        columns.forEach(function (col) {
          col.sort = null;
        }); 
        this.setState({
          columns: columns,
          sortingColumn:null
        })
      };
      // var copyRow  = newRow || {};
      var data = this.state.data;

      // чтобы добавить строку в начало, находим индекс первой строки
      var p = this.state.pagination;
      var idx = (p.page-1) * p.perPage;

      //data.unshift({newRow: true, id: "new-" +  Date.now()});
      delete copyRow['id'];
      copyRow.system = {};
      if (this.state.systemFilter != -1) copyRow.system.id = this.state.systemFilter;
      var sendData = copyRow;
      copyRow['newRow'] = true;
      copyRow['_id'] = "new-" +  Date.now();
      data.splice(idx, 0, copyRow);
      this.setState({
        data: data,
        editedRow: 0,
        lockRow: true,
        sendData: this.getDuplicatedRowsendData(copyRow)});
    } else {
      alert('У Вас недостаточно прав для добавления записи!');
    }
  },

  onIconFilterClick: function(){
    var showFilters = !this.state.showFilters;
    var columns = this.state.columns;
    if (!showFilters) columns.forEach(function (col) {
      col.filter=null;
    }); 
    this.setState({
      showFilters:showFilters,
      columns: columns
    });
  },
  onIconReplaceClick: function(){
    if (current_user.user_rights >= 1 ){
      var showReplace = !this.state.showReplace;
      this.setState({
        showReplace:showReplace
      });
    } else {
      alert('У Вас недостаточно прав для редактирования записей!');
    }
  },

  getDuplicatedRowsendData: function(row){
    var sendData = {};
    _.each(Object.keys(columns), function (columnKey) {
      var col = columns[columnKey];

      if('id' == col.property)
        return;
      if( !col.nested )
        sendData[col.property] = row[col.property] ? row[col.property] : null;
        //sendData[col.property] = row[col.property];
      if( col.attribute ){
        // мы берем первую часть property, и ищем там id
        var prop = col.property.split('.')[0];
        sendData[col.attribute] = row[prop] ? row[prop].id : null;
      }

    });
    return sendData;
  },

  onHideTreeViewClick: function(){
    var left_menu =$('#left_menu');
    var main_table =$('#main_table');
    var panel_sticker =$('#panel-sticker'); 
    var navbar_text_header =$('#navbar-text-header'); 
    var navbar_middle_container =$('#navbar-middle-container'); 
    if (left_menu[0].hidden==false) {
      left_menu[0].hidden=true;
      main_table[0].style.left='0px';
      panel_sticker[0].style.backgroundPosition = 'right';
      navbar_text_header[0].hidden=true;
      navbar_middle_container[0].style.left='380px';
    } else {
      left_menu[0].hidden=false;
      main_table[0].style.left='245px';
      panel_sticker[0].style.backgroundPosition = 'left';
      navbar_text_header[0].hidden=false;
      navbar_middle_container[0].style.left='520px';
    } 
  },

  onExportClick: function(){
    var bookname = model_name + '_' + project.id.toString() + '.xlsx';
      exportData(this.state.dataxls, this.props.columns, bookname);
  },

  onReplaceDone: function(data){
    this.setState({data: data})
  },

  onSystemSelectorChange: function(value){
    this.setState({systemFilter: value.system});
//    var val = valueHash.system;
//    var column = _.find(this.state.columns, function(c){ return c.property == 'system.System'; });
//    if(!column) {column = _.find(this.state.columns, function(c){ return c.property == 'pds_malfunction.system.System'; });};
//    if(!column) return;
//
//    if(val){
//      if(val == -1 ){
//        // we reset data
//        this.setState({data: this.props.data});
//      } else {
//        var data = _.filter(this.props.data, function(row){ return row.system && row.system.id == val; });
//        this.setState({data: data});
//      }
//    }else{
//      // we reset data
//      this.setState({data: this.props.data});
//    }
//
//    var system = valueHash.system;
  },

  render: function() {
    var data = this.state.data || [];
    var pagination = this.state.pagination || {};
    var header = this.state.header;
    var columns = this.state.columns;
    var systemFilter = this.state.systemFilter;

    columns.forEach(function(column){
      if(!column.headerClass||column.headerClass.indexOf(column.headerClassStyle)==-1){
        column.headerClass=column.headerClassStyle+' '+column.headerClass
      } 
    });

    if (systemFilter && systemFilter!=-1) {
      data = _.filter(data, function(row){ return row.system && row.system.id == systemFilter; });
    };
    if (this.state.showFilters){
      columns.forEach(function(column){
        if (column.filter){
          var cfilter = {};
          cfilter['query'] = column.filter;
          cfilter['column'] = column.property;
          data = Search.search(cfilter, columns, data);
        }
      })
    };
    if (this.state.search.query) {
      data = Search.search(this.state.search, this.state.columns, data)
    }
    var mainCheckbox_new = this.state.mainCheckbox_new;
    if(mainCheckbox_new !== this.state.mainCheckbox_old) {
      data.forEach(function(row){
        row.checked = mainCheckbox_new;
      });        
      this.state.mainCheckbox_old = mainCheckbox_new;
    };
    
    data = sortColumn.sort(data, this.state.sortingColumn, orderBy);
    this.state.dataxls = data; 
    
    var paginated = paginate(data, pagination);
    var pages = Math.ceil(data.length / Math.max(
      isNaN(pagination.perPage) ? 1 : pagination.perPage, 1)
    );
    
    return (
      <div className="main-container-inner" key={"main-table"}>
        <div className="table-info" key={"table-info"}>
          <div className="title">
            {this.props.title}
          </div>
          <div className="info">
            <div className="left">
              <div className='total'>
                <p>Записей -</p>
                <p>{data.length}</p>
                <p>{"на " + pages + " стр."}</p>
              </div>
              <div className='system-selector'>
                <SystemFilterSelector attribute="system" onValue={this.onSystemSelectorChange} disabled={this.state.lockRow} value={this.state.systemFilter}/>
                <p>cистема</p>
              </div>
              <div className='per-page-container'>
                <input type='number' min='1' max='200' defaultValue={pagination.perPage} onChange={this.onPerPage} disabled={this.state.lockRow}></input>
                <p>строк</p>
              </div>
              <div className='page-container'>
                <input type='number' defaultValue={pagination.page} onChange={this.onPage} disabled={this.state.lockRow}></input>
                <p>cтр.</p>
              </div>
              <div className={this.state.showFilters ? 'icon-filter info-buttons border-inset' : 'icon-filter info-buttons'} onClick={this.onIconFilterClick}>
                Фильтр
              </div>
              <div className={this.state.showReplace ? 'icon-replace info-buttons border-inset' : 'icon-replace info-buttons'} onClick={this.onIconReplaceClick}>
                Замена
              </div>
              <div className={false ? 'add-row info-buttons border-inset' : 'add-row info-buttons'} onClick={this.onAddRowClick}>
                Добавить запись
              </div>
            </div>
            <div className="right">
              <div className="show-filters">
                Скрыть/ Показать поля
              </div>
              <div className="export-to-excel" onClick={this.onExportClick}>
                Экспорт в Excel
              </div>
            </div>

          </div>
        </div>
        <div className={this.state.showReplace ? 'table-filters':'table-filters hidden-element'} key={"table-filters"}>
          <div className="left">

            <div className="replace-container">
              <Replace columns={this.state.columns} data={this.state.data} onReplaceDone={this.onReplaceDone} disabled={this.state.lockRow}/>

            </div>

          </div>
        </div>

        <div className='pagination'>
          <Paginator.Context className="pagify-pagination"
            segments={segmentize({
                  page: pagination.page,
                  pages: pages,
                  beginPages: 3,
                  endPages: 3,
                  sidePages: 2
              })} onSelect={this.onSelect}>
                  <Paginator.Button page={pagination.page - 1}>Предыдущая</Paginator.Button>
                  <Paginator.Segment field="beginPages" />
                  <Paginator.Ellipsis className="ellipsis"
                    previousField="beginPages" nextField="previousPages" />
                  <Paginator.Segment field="previousPages" />
                  <Paginator.Segment field="centerPage" className="selected" />
                  <Paginator.Segment field="nextPages" />
                  <Paginator.Ellipsis className="ellipsis"
                    previousField="nextPages" nextField="endPages" />
                  <Paginator.Segment field="endPages" />
                  <Paginator.Button page={pagination.page + 1}>Следующая</Paginator.Button>
          </Paginator.Context>
        </div>

        <div className={this.state.showReplace ?'table-container table-container-replace-show' : 'table-container table-container-replace-hide'} key={"table-container"}>

          <Table 
            className='table table-bordered'
            columnNames={this.columnFilters}
            data={paginated.data}
            columns={this.state.columns}
            row={(d, rowIndex) => {
              var rowClass = rowIndex % 2 ? 'odd-row' : 'even-row';
              if (rowIndex == this.state.editedRow)  rowClass = 'edited-row';
                return {
                   // className: rowIndex == this.state.editedRow ? 'edited-row' : '',
                    className: rowClass,
                };
            }}           
            rowKey="id" 
            />
        </div>
        <div id="panel-sticker" onClick={this.onHideTreeViewClick}>
          <p></p> 
        </div>    
      </div>
    );
  }
});

          //  <div className='search-container'>
          //    Поиск <Search columns={this.state.columns} data={this.state.data} onChange={this.onSearch} />
          //  </div>
$(document).ready(function () {
  var appElement = document.getElementById('general_table');
  Modal.setAppElement(appElement);
  ReactDOM.render(
    <TableContainer columns={columns} data={data}
      objectType={model_name} title={title} project={project}/>, appElement
  );
});

function paginate(data, o) {
    data = data || [];

    // adapt to zero indexed logic
    var page = o.page - 1 || 0;
    var perPage = o.perPage;

    var amountOfPages = Math.ceil(data.length / perPage);
    var startPage = page < amountOfPages? page: 0;

    return {
        amount: amountOfPages,
        data: data.slice(startPage * perPage, startPage * perPage + perPage),
        page: startPage
    };
}

function augmentWithTitles(o) {
  for (var property in o) {
    o[property].title = titleCase(property);
  }

  return o;
}

function getNestedKey(obj, keys) {
  var tempVal = obj;

  keys.split(".").forEach(function(key){
    if(tempVal){
      tempVal = tempVal[key];
    }
  });
  return tempVal;
}
