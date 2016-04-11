'use strict';

var React = require('react');
var ReactDOM = require('react-dom');
var Table = require('reactabular').Table;
var _ = require('underscore');

var Paginator = require('react-pagify').default;

var sortColumn = require('reactabular').sortColumn;
var findIndex = require('lodash').findIndex;
var orderBy = require('lodash').orderBy;

var cells = require('reactabular').cells;
var editors = require('reactabular').editors;
var ColumnNames = require('reactabular').ColumnNames;
var segmentize = require('segmentize');
var formatters = require('reactabular').formatters;
var highlight = formatters.highlight;


var titleCase = require('title-case');

// form here
//var Form = require('plexus-form');
//var validate = require('plexus-validate');
//var SkyLight = require('react-skylight').default;

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

// modules
var Search = require('../modules/search.jsx');
//var Search = require('reactabular').Search;
var Replace = require('../modules/replace.jsx');
var ColumnFilters = require('../modules/column_filters.jsx');

//var TextEditor = editors.input();
var stringEditor =  require('../inputs/input.jsx')();
var dateEditor =  require('../inputs/input.jsx')();
var TextEditor =  require('../inputs/text_editor.jsx')();
//var BooleanEditor = require('../inputs/boolean.jsx')();


var TableContainer = React.createClass({
  displayName: 'VniiaesFullTable',


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
      return highlight(function (value) {
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

      var editor = options.editor; // || editors.input();
      var attribute = options.attribute;
      var context = this;
      var nested = options.nested;

      return function(value, data, rowIndex, property) {
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
          value = value ? "ДА" : "НЕТ";
        }
        if(value==null) value = '';

        if (editor) {
          if ((editor == BooleanNumbSelector) && (typeof(value) == "number")){
            value = (value == 0) ? "НЕТ" : "ДА";
          }
        }

        var editedRow = context.state["editedRow"];
        if (editedRow === rowIndex) {
          return {
            value: React.createElement(editor, {
              value: value,
              attribute: attribute || property,
              onValue: function (valueHash) {
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({lockRow: true, sendData: sendData});
              },
              onCancel: function(){
                context.setState({ editedRow: null, lockRow: false, sendData: {} });
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

        if(tempVal==null) tempVal = '';
        return {value: tempVal};
      }
    }.bind(this);

    var columns = this.props.columns.map(function(column){
      var h = column; //  {property: column.property, header: column.header, };
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
          header: 'Кнопки',
          style: {width: '100px'},
          classes: 'buttons-col',
          cell: function(value, celldata, rowIndex, property){
            var url = window.location.href;
            var newRow = celldata[rowIndex].newRow;
            var itemId = celldata[rowIndex].id;
            var idx = findIndex(this.state.data, {id: itemId});

            var remove = function() {
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
                var d = {};
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
      formatters: formatters,
      showFilters: false,
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
          sortColumn(
            this.state.columns,
            column,
//            this.state.data,
            this.setState.bind(this),
//            myDefaultSorter
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

  columnFilters() {
    var headerConfig = this.state.header;
    var columns = this.state.columns;
    // if you don't want an header, just return;
    return (
      <thead>
        <ColumnNames config={headerConfig} columns={columns} />
        <ColumnFilters
          columns={columns}
          onUserInput={this.handleUserInput}
          />
      </thead>
    );
  },  

  handleUserInput: function(columns) {
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

    pagination.perPage = parseInt(e.target.value, 10);

    this.setState({
      pagination: pagination
    });
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


  onHeaderClick: function(column){
    // reset edits
    this.setState({
      editedCell: null
    });

    sortColumn(
      this.state.columns,
      column,
//      this.state.data,
      this.setState.bind(this),
      myDefaultSorter
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
    var idx = (p.page-1) * p.perPage;

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
    exportData(this.props.data, this.props.columns);
  },

  onSystemSelectorChange: function(valueHash){
    var val = valueHash.system;
    var column = _.find(this.state.columns, function(c){ return c.property == 'system.System'; });
    if(!column)
      return;

    if(val){
      if(val == -1 ){
        // we reset data
        this.setState({data: this.props.data});
      } else {
        var data = _.filter(this.props.data, function(row){ return row.system && row.system.id == val; });
        this.setState({data: data});
      }
    }else{
      // we reset data
      this.setState({data: this.props.data});
    }

    var system = valueHash.system;
    //console.log(system);
  },

  render: function() {
    var data = this.state.data || [];
    var pagination = this.state.pagination || {};
    var header = this.state.header;
    var columns = this.state.columns;

    columns.forEach(function(column){
      if (column.filter){
        var cfilter = {};
        cfilter['query'] = column.filter;
        cfilter['column'] = column.property;
        data = Search.search(cfilter, columns, data);
      }
    });
    if (this.state.search.query) {
      // apply search to data
      // alternatively you could hit backend `onChange`
      // or push this part elsewhere depending on your needs
      data = Search.search(this.state.search, this.state.columns, data)
      //data = Search.search(data,columns,this.state.search.column,this.state.search.query);
    }

    data = sortColumn.sort(data, this.state.sortingColumn, orderBy); 
    
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
                <SystemFilterSelector attribute="system" onValue={this.onSystemSelectorChange} />
                <p>cистема</p>
              </div>
              <div className='per-page-container'>
                <input type='text' defaultValue={pagination.perPage} onChange={this.onPerPage}></input>
                <p>строк</p>
              </div>
              <div className='page-container'>
                <input type='text' defaultValue={pagination.page} onChange={this.onPage}></input>
                <p>cтр.</p>
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
                Скрыть/ Показать поля
              </div>
              <div className="export-to-excel" onClick={this.onExportClick}>
                Экспорт в Excel
              </div>
            </div>

          </div>
        </div>
        <div className="table-filters" key={"table-filters"}>
          <div className="left">
            <div className="add-row" onClick={this.onAddRowClick} />

            <div className='search-container'>
              Поиск <Search columns={this.state.columns} data={this.state.data} onChange={this.onSearch} />
            </div>

            <div className="replace-container">
              Replace
              <Replace columns={this.state.columns} />

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

        <div className='table-container' key={"table-container"}>

          <Table 
            className='table table-bordered'
            columnNames={this.columnFilters}
            columns={this.state.columns}
            data={paginated.data}
            selectedRow={this.state.editedRow}/>
        </div>
        <div id="panel-sticker" onClick={this.onHideTreeViewClick}>
          <p></p> 
        </div>    
      </div>
    );
  }
});

$(document).ready(function () {

  ReactDOM.render(
    <TableContainer columns={columns} data={data}
      objectType={model_name} title={title}/>,
    document.getElementById('general_table')
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
//function attachIds(arr) {
//    return arr.map((o, i) => {
//        o.id = i;
//
//        return o;
//    });
//}
function getNestedKey(obj, keys) {
  var tempVal = obj;

  keys.split(".").forEach(function(key){
    if(tempVal){
      tempVal = tempVal[key];
    }
  });
  return tempVal;
}
