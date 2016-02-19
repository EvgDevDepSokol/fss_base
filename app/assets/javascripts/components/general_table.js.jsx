var React = require('react');
var Table = require('reactabular').Table;
var _ = require('underscore');

var Paginator = require('react-pagify');

var sortColumn = require('reactabular').sortColumn;
var findIndex = require('lodash/array/findIndex');

var cells = require('reactabular').cells;
var editors = require('reactabular').editors;


var titleCase = require('title-case');

// form here
//var Form = require('plexus-form');
//var validate = require('plexus-validate');
//var SkyLight = require('react-skylight');

var SystemSelector = require('../selectors/system.jsx');
var HwIcSelector = require('../selectors/hw_ic.jsx');
var DetectorSelector = require('../selectors/detector.jsx');
var PdsManEquipSelector = require('../selectors/pds_man_equips.jsx');
var PdsSectionAssemblerSelector = require('../selectors/pds_section_assembler.jsx');
var HwPedSelector = require('../selectors/hw_ped.jsx');
var PdsPanelSelector = require('../selectors/pds_panels.jsx');
var HwDevTypesSelector = require('../selectors/hw_dev_types.jsx');

var PdsMotorTypeSelector = require('../selectors/pds_motor_types.jsx');
var BooleanSelector = require('../selectors/boolean.jsx');

// todo: fix
var SdSelector = require('../selectors/pds_sds.jsx');
var UnitSelector = require('../selectors/pds_project_units.jsx');
//var DocumentationSelector = require('../selectors/pds_man_equips.jsx');

var PdsEngineersSelector = require('../selectors/pds_engineers.jsx');
var PdsDocumentationsSelector = require('../selectors/pds_documentation.jsx');
var PdsValvesSelector = require('../selectors/pds_valves.jsx');

// modules
var Search = require('../modules/search.jsx');
var Replace = require('../modules/replace.jsx');


//var TextEditor = editors.input();
var stringEditor =  require('../inputs/input.jsx')();
var dateEditor =  require('../inputs/input.jsx')();
var TextEditor =  require('../inputs/text_editor.jsx')();
//var BooleanEditor = require('../inputs/boolean.jsx')();

//var ImportXlsxModal = require('./xlsx-import.js.jsx');

var TableContainer = React.createClass({
  displayName: 'djetFullTable',

  getInitialState: function() {
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

      //this.state.data[idx][property] = value;

      this.setState({
        data: data
      });
    }.bind(this));

    var editableField = function(options) {
      //debugger;

      var editor = options.editor; // || editors.input();
      var attribute = options.attribute;
      var context = this;
      var nested = options.nested;

      return function(value, data, rowIndex, property) {
        //debugger;
        if(nested)
        {
          var keys = property.split(".");
          var tempVal = data[rowIndex];

          keys.forEach(function(key){
            if(tempVal){
              tempVal = tempVal[key];
            }
          });
          value = tempVal;
        }

        if(typeof(value) == "boolean"){
          value = value ? "TRUE" : "FALSE";
        }

        var editedRow = context.state["editedRow"];
        if (editedRow === rowIndex) {
          return {
            value: React.createElement(editor, {
              value: value,
              attribute: attribute || property,
              onValue: function (valueHash) {
                //debugger;
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({lockRow: true, sendData: sendData});
              }
            })
          };
        }
        if (editor) {
          return {
            value: value,
            props: {
              onDoubleClick: function () {
                if(!context.state.lockRow){
                  context.setState({editedRow: rowIndex});
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

        return {value: tempVal};
      }
    }.bind(this);

    var columns = this.props.columns.map(function(column){
      var h = column; //  {property: column.property, header: column.header, };
      if(column.editor) {
        column['editor'] = eval(column.editor);
        h["cell"] = editableField(column)
      }else if(column.nested) {
        h["cell"] = nestedValue(column);
      }
      return (h);
    });

    // attach filter to headers
    //context = this;
    columns = columns.filter(function(e){return e.hidden != true});
    //.map(function(col){
    //  var filter = null;
    //  if(context.state.showFilters)
    //    filter = (<p>  </p>);
    //  col.header = (<div><p>{col.header}</p>{filter}</div>);
    //  return col;
    //});

    // remove hidden elements and add buttons
    columns = columns.concat([
        {
          header: 'buttons',
          style: {width: '100px'},
          classes: 'buttons-col',
          cell: function(value, celldata, rowIndex, property){

            var url = window.location.href;
            var newRow = celldata[rowIndex].newRow;
            var itemId = celldata[rowIndex].id;
            var idx = findIndex(this.state.data, {id: itemId});

            var remove = function() {
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
                $.ajax({
                  url: url + '/' + itemId,
                  dataType: 'json',
                  type: 'DELETE',
                  success: function(data) {
                    //debugger;
                    this.state.data.splice(idx, 1);
                    this.setState({
                      data: this.state.data,
                      editedRow: null
                    });
                  }.bind(this),
                  error: function(xhr, status, err) {
                    //debugger;
                    console.error(this.props.url, status, err.toString());
                  }.bind(this)
                });
              }

              // this could go through flux etc.

            }.bind(this);

            var copy = function() {
              this.onAddRowClick(celldata[rowIndex]);
            }.bind(this);

            var editClick = function() {
              this.setState({editedRow: rowIndex});
            }.bind(this);

            var cancelClick = function() {
              this.setState({ editedRow: null, lockRow: false, sendData: {} });
            }.bind(this);

            var saveClick = function() {
              if(!$.isEmptyObject(this.state.sendData))
              {
                d = {};
                d[this.props.objectType] = this.state.sendData;
                if(newRow){
                  idx = findIndex(this.state.data, {_id: celldata[rowIndex]._id});
                  d[this.props.objectType].Project = project.id;
                  $.ajax({
                    url: url,
                    dataType: 'json',
                    type: 'POST',
                    data: d,
                    success: function(response) {
                      //debugger;
                      this.state.data[idx] = response.data;
                      this.setState({
                        data: this.state.data,
                        lockRow: false,
                        sendData: {},
                        editedRow: null
                      });
                    }.bind(this),
                    error: function(xhr, status, err) {
                      console.error(this.props.url, status, err.toString());
                    }.bind(this)
                  });
                }else{
                  $.ajax({
                    url: url + '/' + itemId,
                    dataType: 'json',
                    type: 'PUT',
                    data: d,
                    success: function(response) {
                      //debugger;
                      this.state.data[idx] = response.data;
                      this.setState({
                        data: this.state.data,
                        lockRow: false,
                        sendData: {},
                        editedRow: null
                      });
                    }.bind(this),
                    error: function(xhr, status, err) {
                      //debugger;
                      console.error(this.props.url, status, err.toString());
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
            }.bind(this);

            var editButton = <span className='edit btn btn-xs btn-default' onClick={editClick.bind(this)} style={{cursor: 'pointer'}}>
                <i className="fa fa-pencil"></i>
              </span>;

            var saveButton = <span className='edit btn btn-xs btn-default' onClick={saveClick.bind(this)} style={{cursor: 'pointer'}}>
                <i className="fa fa-check"></i>
            </span>;

            if(!newRow){
              var cancelButton = <span className='edit btn btn-xs btn-default' onClick={cancelClick.bind(this)} style={{cursor: 'pointer'}}>
                <i className="fa fa-undo"></i>
              </span>;
            }

            var deleteButton = <span className='remove btn btn-xs btn-danger' onClick={remove.bind(this)} style={{cursor: 'pointer'}}>
                <i className="fa fa-times"></i>
              </span>;

            var copyButton = <span className='remove btn btn-xs btn-default' onClick={copy.bind(this)} style={{cursor: 'pointer'}}>
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
      showFilters: false,
      pagination: {
        page: 0,
        perPage: 20
      },
      search: {
        query: '',
        column: ''
      },
      header: {
        onClick: function(column){
          sortColumn(
            this.state.columns,
            column,
            this.state.data,
            this.setState.bind(this),
            myDefaultSorter
          );
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

// handlers
  onSelect: function(page) {
    if(this.state.lockRow)
      return;
    var pagination = this.state.pagination || {};

    pagination.page = page;

    this.setState({
      pagination: pagination
    });
  },

  onPerPage: function(e) {
    var pagination = this.state.pagination || {};

    pagination.perPage = parseInt(event.target.value, 10);

    this.setState({
      pagination: pagination
    });
  },

  onHeaderClick: function(column){
    // reset edits
    this.setState({
      editedCell: null
    });

    sortColumn(
      this.state.columns,
      column,
      this.state.data,
      this.setState.bind(this)
    );
  },

/*  onRemoveClick: function() {
    // this could go through flux etc.
    var idx = findIndex(this.state.data, {
      id: celldata[rowIndex].id
    });

    this.state.data.splice(idx, 1);

    this.setState({
      data: this.state.data
    });
  },*/

  onAddRowClick: function(copyRow){
    if(this.state.lockRow)
      return;

    var copyRow  = copyRow || {};
    var data = this.state.data;

    // чтобы добавить строку в начало, находим индекс первой строки
    var p = this.state.pagination;
    var idx = p.page * p.perPage;

    //data.unshift({newRow: true, id: "new-" +  Date.now()});
    delete copyRow['id'];
    var sendData = copyRow;
    copyRow['newRow'] = true;
    copyRow['_id'] = "new-" +  Date.now();
    data.splice(idx, 0, copyRow);
    this.setState({
      data: data,
      editedRow: 0,
      lockRow: true,
      sendData: this.getDuplicatedRowsendData(copyRow)});
  },

  getDuplicatedRowsendData: function(row){
    var sendData = {};
    _.each(Object.keys(columns), function (columnKey) {
      var col = columns[columnKey];

      if('id' == col.property)
        return;
      if( !col.nested )
        sendData[col.property] = row[col.property];
      if( col.attribute ){
        // мы берем первую часть property, и ищем там id
        var prop = col.property.split('.')[0];
        sendData[col.attribute] = row[prop] ? row[prop].id : null;
      }

    });
    return sendData;
  },

  onExportClick: function(){
    exportData(this.props.data, this.props.columns);
  },

  onSystemSelectorChange: function(valueHash){
    var val = valueHash.system;
    var column = _.find(this.state.columns, function(c){ return c.property == 'system.System'; });
    if(!column)
      return;

    if(val){
      var data = _.filter(this.props.data, function(row){ return row.system && row.system.id == val; });
      this.setState({data: data});
    }else{
      // we reset data
      this.setState({data: this.props.data});
    }

    var system = valueHash.system;
    console.log(system);
  },

  render: function() {
    var data = this.state.data || [];
    var pagination = this.state.pagination || {};
    var header = this.state.header;

    if (this.state.search.query) {
      // apply search to data
      // alternatively you could hit backend `onChange`
      // or push this part elsewhere depending on your needs
      data = Search.search(this.state.search, this.state.columns, data);
    }

    var paginated = Paginator.paginate(data, pagination);
    var totalPages = Math.ceil(data.length / pagination.perPage);

    return (
      <div className="main-container-inner" key={"main-table"}>
        <div className="table-info" key={"table-info"}>
          <div className="title">
            {this.props.title}
          </div>
          <div className="info">
            <div className="left">
              <div className='total'>
                {"Всего записей " + data.length + " на " + totalPages + " стр."}
              </div>
              <div className='icon'></div>
              <div className='system-selector'>
                <SystemSelector attribute="system" onValue={this.onSystemSelectorChange} />
                <p>система</p>
              </div>
              <div className='per-page-container'>
                <input type='text' defaultValue={pagination.perPage} onChange={this.onPerPage}></input>
                <p>Кол-во записей</p>
              </div>
              <div className='page-container'>
                <input type='text' defaultValue={pagination.page} onChange={this.onPerPage}></input>
                <p>страница</p>
              </div>
              <div className='icon-filter'>
                Фильтр
              </div>
              <div className='icon-replace' >
                Замена
              </div>

              <div>
              </div>
            </div>
            <div className="right">
              <div className="show-filters">
                Скрыть / Показать поля
              </div>
              <div className="export-to-excel" onClick={this.onExportClick}>
                Експорт в Excel
              </div>
            </div>

          </div>
        </div>
        <div className="table-filters" key={"table-filters"}>
          <div className="left">
            <div className="add-row" onClick={this.onAddRowClick} />

            <div className='search-container'>
              Search <Search columns={this.state.columns} data={this.state.data} onChange={this.onSearch} />
            </div>

            <div className="replace-container">
              Replace
              <Replace columns={this.state.columns} />

            </div>

          </div>
        </div>

      <div className='table-container' key={"table-container"}>

        <Table header={header} columns={this.state.columns} data={paginated.data}
          className='table table-bordered' selectedRow={this.state.editedRow} />

        <div className='pagination'>
          <Paginator
            page={paginated.page}
            pages={paginated.amount}
            beginPages={3}
            endPages={3}
            onSelect={this.onSelect}></Paginator>
        </div>

      </div>
      </div>
    );
  }
});

$(document).ready(function () {

  React.render(
    <TableContainer columns={columns} data={data}
      objectType={model_name} title={title}/>,
    document.getElementById('general_table')
  );

});

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
