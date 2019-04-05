'use strict';

import React, { Component } from 'react';
import PropTypes from 'prop-types';
var ReactDOM = require('react-dom');
import ReactToPrint from 'react-to-print';

var createReactClass = require('create-react-class');
var _ = require('underscore');
import { DRSTATUS } from './drs/dr_data.jsx';
import { DRPRIORITY } from './drs/dr_data.jsx';
import { prepareRow } from './drs/dr_data.jsx';
import { ColumnNames } from 'reactabular';
import { sortColumn } from 'reactabular';
import { formatters } from 'reactabular';
import { Table } from 'reactabular';
import { Paginator } from '../helpers';
import { paginate } from '../helpers';

var LocalStorageMixin = require('react-localstorage');
var findIndex = require('lodash').findIndex;
var orderBy = require('lodash').orderBy;
var titleCase = require('title-case');
var SystemFilterSelector = require('../selectors/system_filter.jsx');
var ProjectSelector = require('../selectors/project.jsx');
var Search = require('../modules/search.jsx');
var ColumnFilters = require('../modules/column_filters.jsx');
var DrView = require('./drs/dr_view.jsx');

import Modal from 'react-modal';

var ExportXlsxModal = require('../components/xlsx-export.jsx');
var DrStatisticsModal = require('../components/drs/dr_statistics.jsx');

var TableContainer = createReactClass({
  displayName: 'VniiaesFullTable',

  propTypes: {
    data: PropTypes.array,
    columns: PropTypes.array,
    title: PropTypes.string,
    dr_details: PropTypes.object,
    onCommentSave: PropTypes.func,
    onDrCancel: PropTypes.func,
    is_dr_new: PropTypes.bool
  },

  mixins: [LocalStorageMixin],

  getDefaultProps: function() {
    return { stateFilterKeys: ['systemFilter'] };
  },

  componentDidMount: function() {
    //window.addEventListener('scroll', this.handleScroll);
  },

  componentWillUnmount: function() {
    //window.removeEventListener('scroll', this.handleScroll);
  },

  handleScroll: function(event) {
    if (event.target.localName == 'div') {
      var translate =
        'translatez(1000px) translate(0,' + event.target.scrollTop + 'px)';
      event.target.firstElementChild.firstElementChild.style.transform = translate;
      event.target.firstElementChild.firstElementChild.style['top'] =
        event.target.scrollTop + 'px';
      //event.target.firstElementChild.firstElementChild.style['position'] =
      //  'relative';
      event.target.firstElementChild.firstElementChild.style['z-index'] =
        '9999';
    }
  },

  getInitialState: function() {
    var _this = this;

    var highlighter = function(column) {
      return formatters.highlight(function(value) {
        var columns = _this.props.columns;
        var query = null;
        columns.forEach(function(col) {
          if (col.property == column) {
            if (col.filter) {
              query = col.filter;
            }
          }
        });
        if (query == null) query = '';
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
          if (obj.value === value) {
            return true;
          }
        });
        return tmp[0] ? tmp[0].label : '';
      }
      return function(value, data, rowIndex, property) {
        var id;
        if (nested) {
          var keys = property.split('.');
          var tempVal = data[rowIndex];

          if (tempVal[keys[0]]) id = tempVal[keys[0]].id;
          keys.forEach(function(key) {
            if (tempVal) {
              tempVal = tempVal[key];
            }
          });
          value = tempVal;
        }

        if (value == null) value = '';

        if (editor) {
          if (editor == BooleanNumbSelector && typeof value == 'number') {
            value = value == 0 ? 'нет' : 'да';
          }
          if (editor == ValveTypeSelector) {
            value = labelFromSelectorList(editor.options, value);
          }
          if (editor == BooleanSelector) {
            value = value ? 'да' : 'нет';
          }
          if (editor == BooleanNumbSelector) {
            value = labelFromSelectorList(editor.options, value);
          }
          if (editor == UserRightsSelector) {
            value = labelFromSelectorList(editor.options, value);
          }
          if (editor == SystemDocSelector) {
            id = [];
            value = [];
            if (data[rowIndex][property]) {
              if (data[rowIndex][property]['extra_data']) {
                if (data[rowIndex][property]['extra_data'][0]) {
                  id = data[rowIndex][property]['extra_data'][0];
                  value = data[rowIndex][property]['extra_data'][1];
                }
              }
            }
          }
        }

        var editedRow = context.state['editedRow'];
        if (editedRow === rowIndex) {
          return {
            value: React.createElement(editor, {
              value: value,
              id: id,
              attribute: attribute || property,
              onValue: function(valueHash) {
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({ lockRow: true, sendData: sendData });
              },
              onCancel: function() {
                var celldata = data[rowIndex];
                if (celldata.newRow) {
                  var idx = findIndex(context.state.data, {
                    _id: celldata._id
                  });

                  context.state.data.splice(idx, 1);
                  context.setState({
                    data: context.state.data,
                    editedRow: null,
                    lockRow: false,
                    sendData: {}
                  });
                } else {
                  context.setState({
                    editedRow: null,
                    lockRow: false,
                    sendData: {}
                  });
                }
              },
              onSave: function(valueHash) {
                var celldata = data[rowIndex];
                var sendData = $.extend(context.state.sendData, valueHash);
                context.setState({ lockRow: true, sendData: sendData });
                context.onSaveClick(celldata);
              }
            })
          };
        }
        return {
          value: value,
          onClick: function() {
            if (!context.state.lockRow) {
              if (current_user.user_rights >= 1) {
                context.setState({
                  editedRow: rowIndex,
                  lockRow: true,
                  editedDr: data[rowIndex]
                });
              } else {
                alert('У Вас недостаточно прав для редактирования записи!');
              }
            }
          }
        };
      };
    }.bind(this);

    var nestedValue = function(options) {
      return function(value, data, rowIndex, property) {
        var keys = property.split('.');
        var tempVal = data[rowIndex];

        keys.forEach(function(key) {
          if (tempVal) {
            tempVal = tempVal[key];
          }
        });

        if (tempVal == null) tempVal = '';
        return { value: tempVal };
      };
    }.bind(this);

    var columns = this.props.columns.map(function(column) {
      var h = column; //  {property: column.property, header: column.header, };
      if (column.headerClassStyle) {
        //do nothing
      } else if (column.editor == 'TextEditor') {
        column.headerClassStyle = 'header-text-col';
      } else if (column.editor == 'WideTextEditor') {
        column.headerClassStyle = 'header-wide_text-col';
      } else if (column.property == 'system.System') {
        column.headerClassStyle = 'header-sys_sys-col';
      } else if (!column.nested) {
        column.headerClassStyle = 'header-' + column.property + '-col';
      } else {
        var keys = column.property.split('.');
        column.headerClassStyle = 'header-' + keys[keys.length - 1] + '-col';
      }
      if (column.editor) {
        column['editor'] = eval(column.editor);
        h['cell'] = [editableField(column), highlighter(h.property)];
      } else if (column.nested) {
        h['cell'] = [nestedValue(column), highlighter(h.property)];
      } else {
        h['cell'] = [highlighter(h.property)];
      }
      return h;
    });

    // remove hidden elements
    columns = columns.filter(function(e) {
      return e.hidden != true;
    });

    var clickMainCheckboxY = function() {
      this.setState({ mainCheckbox_new: true, mainCheckbox_old: false });
    };

    var clickMainCheckboxN = function() {
      this.setState({ mainCheckbox_new: false, mainCheckbox_old: true });
    };

    var mainCheckbox = (
      <div className="two-checkboxes">
        <input
          title="Выделить все записи для замены/экспорта"
          type="checkbox"
          onChange={clickMainCheckboxY.bind(this)}
          checked={true}
        />
        <input
          title="Снять выделение со всех записей"
          type="checkbox"
          onChange={clickMainCheckboxN.bind(this)}
          checked={false}
        />
      </div>
    );

    var column_x = [
      {
        header: <div>{mainCheckbox}</div>,
        headerClassStyle: 'header-checkbox-col',
        classes: 'checkbox-col',
        cell: function(value, celldata, rowIndex, property) {
          var itemId = celldata[rowIndex].id;
          var idx = findIndex(this.state.data, { id: itemId });
          var clickCheckBox = function() {
            var data = this.state.data;
            data[idx].checked = !this.state.data[idx].checked;
            this.setState({ data });
          };
          var checkBox;

          if (idx > -1) {
            checkBox = (
              <div className="checkbox">
                <input
                  type="checkbox"
                  onChange={clickCheckBox.bind(this)}
                  checked={
                    this.state.data[idx].checked
                      ? this.state.data[idx].checked
                      : false
                  }
                />
              </div>
            );
          } else {
            checkBox = (
              <span className="checkbox">
                <input type="checkbox" />
              </span>
            );
          }

          return {
            value: (
              <span
                style={{
                  width: '30px'
                }}
              >
                {checkBox}
              </span>
            )
          };
        }.bind(this)
      }
    ];

    columns = column_x.concat(columns);
    column_x = null;

    columns.map(function(column) {
      column.label = column.header;
    });

    return {
      editedRow: null,
      editedDr: null,
      lockRow: false,
      sendData: {},
      data: this.props.data,
      columns: columns,
      formatters: formatters,
      showFilters: false,
      showReplace: false,
      mainCheckbox_new: false,
      mainCheckbox_old: false,
      exportIndex: 0,
      is_dr_new: false,
      systemFilter: null,
      show_hidden_columns: false,
      pagination: {
        page: 1,
        perPage: 20
      },
      search: {
        query: '',
        column: ''
      },
      header: {
        onClick: function(column) {
          if (
            !(
              column.classes == 'buttons-col' ||
              column.classes == 'checkbox-col' ||
              this.state.lockRow
            )
          ) {
            sortColumn(this.state.columns, column, this.setState.bind(this));
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

  onClickRow: function(rowIndex, rowData) {
    this.setState({
      editedRow: rowIndex,
      editedDr: rowData,
      is_dr_new: false
    });
  },

  columnFilters() {
    var headerConfig = this.state.header;
    var show_hidden_columns = this.state.show_hidden_columns;
    var columns = this.state.columns;
    columns = columns.filter(function(e) {
      return !e.show_on_request || (e.show_on_request && show_hidden_columns);
    });

    columns.map(function(column, i) {
      var className = 'editableColumn';
      var header = column.header;
      if (!header.props) {
        column.header = (
          <span className={className} key={'col' + i}>
            {header}
          </span>
        );
      }
      return column;
    });

    // if you don't want an header, just return;
    return this.state.showFilters ? (
      <thead>
        <ColumnNames config={headerConfig} columns={columns} />
        <ColumnFilters
          columns={columns}
          onUserInput={this.onFilterInput}
          disabled={this.state.lockRow}
        />
      </thead>
    ) : (
      <thead>
        <ColumnNames config={headerConfig} columns={columns} />
      </thead>
    );
  },

  none: function() {},

  onShowHidden: function() {
    this.setState({
      show_hidden_columns: !this.state.show_hidden_columns
    });
  },

  onFilterInput: function(columns) {
    this.setState({ columns: columns });
  },

  // handlers
  onSelect: function(page) {
    if (this.state.lockRow) return;
    var pagination = this.state.pagination || {};
    var pages = Math.ceil(this.state.data.length / pagination.perPage);

    pagination.page = Math.min(Math.max(page, 1), pages);

    this.setState({ pagination: pagination });
  },

  onPerPage: function(e) {
    var pagination = this.state.pagination || {};
    if (parseInt(e.target.value, 10) > 200) e.target.value = '200';
    var PerPage = parseInt(e.target.value, 10);
    if (pagination.perPage !== PerPage) {
      pagination.perPage = PerPage;
      this.setState({ pagination: pagination });
    }
  },

  onPage: function(e) {
    var pagination = this.state.pagination;
    var pages = Math.ceil(this.state.data.length / pagination.perPage);
    var page = parseInt(e.target.value, 10);
    if (isNaN(page)) page = 1;
    pagination.page = Math.min(Math.max(page, 1), pages);

    this.setState({ pagination: pagination });
  },

  onAddRowClick: function() {
    this.setState({
      is_dr_new: true
    });
  },
  onDrCancel: function() {
    this.setState({
      is_dr_new: false
    });
  },

  onExportToPdfClick: function() {},

  onIconFilterClick: function() {
    var showFilters = !this.state.showFilters;
    var columns = this.state.columns;
    if (!showFilters)
      columns.forEach(function(col) {
        col.filter = null;
      });
    this.setState({ showFilters: showFilters, columns: columns });
  },

  getDuplicatedRowsendData: function(row) {
    var sendData = {};
    _.each(Object.keys(columns), function(columnKey) {
      var col = columns[columnKey];

      if ('id' == col.property) return;
      if (!col.nested)
        sendData[col.property] =
          row[col.property] !== null ? row[col.property] : null;

      //sendData[col.property] = row[col.property];
      if (col.attribute) {
        // мы берем первую часть property, и ищем там id
        var prop = col.property.split('.')[0];
        sendData[col.attribute] = row[prop] ? row[prop].id : null;
      }
    });
    return sendData;
  },

  onSystemSelectorChange: function(value) {
    this.setState({ systemFilter: value.system });
  },

  onDrInsert: function(pds_dr, comment, is_new) {
    var url = '/create_dr_and_comment';
    var d = {};
    d['pds_dr'] = pds_dr;
    d['pds_dr_comment'] = comment;
    d['is_new'] = is_new;
    $.ajax({
      url: url,
      dataType: 'json',
      contentType: 'application/json; charset=UTF-8',
      type: 'PUT',
      data: JSON.stringify(d),
      success: function(response) {
        var data = this.state.data;
        var editedDr = response.data[0];
        if (is_new) {
          data.push(editedDr);
        } else {
          var idx = findIndex(this.state.data, { id: editedDr.id });
          data[idx] = editedDr;
        }
        this.setState({
          data,
          editedDr
        });
      }.bind(this),
      error: function(xhr, status, err) {
        var jtmp = xhr.responseJSON['errors'];
        var result = 'Не удалось сохранить запись. Причина:\n\n';
        alert(result);
      }.bind(this)
    });
  },

  onCommentSave: function(comment) {
    var url = window.location.href.replace('pds_drs', 'pds_dr_comments');
    var idx = findIndex(this.state.data, { id: comment.pds_dr_id });
    var d = {};
    d['pds_dr_comment'] = comment;
    $.ajax({
      url: url,
      dataType: 'json',
      contentType: 'application/json; charset=UTF-8',
      type: 'POST',
      data: JSON.stringify(d),
      success: function(response) {
        var data = this.state.data;
        data[idx]['comments'].push(response.data);
        data[idx]['status'] = response.data.status;
        this.setState({
          data: this.state.data
        });
      }.bind(this),
      error: function(xhr, status, err) {
        var jtmp = xhr.responseJSON['errors'];
        var result = 'Не удалось сохранить запись. Причина:\n\n';
        alert(result);
      }.bind(this)
    });
  },
  onBeforePrint: function() {
    return <div ref={el => (this.componentRef = el)}>test</div>;
  },
  render: function() {
    var data = this.state.data || [];
    var pagination = this.state.pagination || {};
    var header = this.state.header;
    var columns = this.state.columns;
    var systemFilter = this.state.systemFilter;
    var show_hidden_columns = this.state.show_hidden_columns;
    columns = columns.filter(function(e) {
      return !e.show_on_request || (e.show_on_request && show_hidden_columns);
    });
    var columns2 = columns;
    var cols = [];
    columns.forEach(function(column) {
      var col = {
        header: { label: column['header'] },
        property: column['property']
        //cell: { transforms: [column['editor']] }
      };

      cols.push(col);
    });

    columns.forEach(function(column) {
      if (
        !column.headerClass ||
        column.headerClass.indexOf(column.headerClassStyle) == -1
      ) {
        column.headerClass = column.headerClassStyle + ' ' + column.headerClass;
      }
    });

    var date_now = new Date(Date.now());
    data.forEach(function(row) {
      prepareRow(row, date_now);
    });

    if (systemFilter && systemFilter != -1) {
      if (data[0]) {
        var firstRow = data[0];
        if (firstRow.system) {
          data = _.filter(data, function(row) {
            return row.system && row.system.id == systemFilter;
          });
        } else if (firstRow.doc_arr) {
          data = _.filter(data, function(row) {
            return (
              !!row.doc_arr &&
              !!row.doc_arr.extra_data &&
              !!row.doc_arr.extra_data[0] &&
              row.doc_arr.extra_data[0].includes(systemFilter)
            );
          });
        }
      }
    }
    if (this.state.showFilters) {
      columns.forEach(function(column) {
        if (column.filter) {
          var cfilter = {};
          cfilter['query'] = column.filter;
          cfilter['column'] = column.property;
          data = Search.search(cfilter, columns, data);
        }
      });
    }
    var mainCheckbox_new = this.state.mainCheckbox_new;
    if (mainCheckbox_new !== this.state.mainCheckbox_old) {
      data.forEach(function(row) {
        row.checked = mainCheckbox_new;
      });
      this.setState({ mainCheckbox_old: mainCheckbox_new });
    }

    var sortingColumn = this.state.sortingColumn;
    if (sortingColumn) {
      data = data.map(function(row) {
        var h = row;
        if (row[sortingColumn.property] === null) {
          h[sortingColumn.property] = '';
        }
        return h;
      });
    }
    if (sortingColumn && sortingColumn.property == 'time_left') {
      data = orderBy(data, 'time_left_val', sortingColumn.sort);
    } else {
      data = sortColumn.sort(data, sortingColumn, orderBy);
    }

    const paginated = paginate(pagination)(data);
    var pages = paginated.amount;
    var editedRow = null;
    var editedDr = this.state.editedDr;
    if (editedDr) {
      paginated.rows.forEach(function(item, i) {
        if (editedDr.id == item.id) {
          editedRow = i;
        }
      });
    }
    var dr_details = editedDr ? editedDr : data[0];
    var is_dr_new = this.state.is_dr_new;
    if (data.length == 0) {
      is_dr_new = true;
    }

    return (
      <div>
        <div className="col main-container dr_table">
          <div className="main-container-inner" key={'main-table'}>
            <div className="table-info" key={'table-info'}>
              <div className="title">{this.props.title}</div>
              <div className="info">
                <div className="left">
                  <div className="left-left">
                    <div className="total">
                      <p>Записей -</p>
                      <p>{data.length}</p>
                      <p>{'на ' + pages + ' стр.'}</p>
                    </div>
                    <div className="system-selector">
                      <SystemFilterSelector
                        attribute="system"
                        onValue={this.onSystemSelectorChange}
                        disabled={this.state.lockRow}
                        value={this.state.systemFilter}
                      />
                      <p>cистема</p>
                    </div>
                    <div className="per-page-container">
                      <input
                        type="number"
                        min="1"
                        max="200"
                        defaultValue={pagination.perPage}
                        onChange={this.onPerPage}
                        disabled={this.state.lockRow}
                      />
                      <p>строк</p>
                    </div>
                    <div className="page-container">
                      <input
                        type="number"
                        min="1"
                        value={this.state.pagination.page}
                        onChange={this.onPage}
                        disabled={this.state.lockRow}
                      />
                      <p>cтр.</p>
                    </div>
                  </div>
                  <div className="left-right">
                    <div
                      className={
                        this.state.showFilters
                          ? 'icon-filter info-buttons border-inset'
                          : 'icon-filter info-buttons'
                      }
                      onClick={this.onIconFilterClick}
                    >
                      Фильтр
                    </div>
                    <div
                      className={'add-row info-buttons'}
                      onClick={this.onAddRowClick}
                    >
                      Добавить DR
                    </div>
                    <DrStatisticsModal
                      data={this.state.data}
                      onExport={this.onExportClick}
                    />
                    <ReactToPrint
                      trigger={() => (
                        <div className={'dr-print info-buttons'}>Печать</div>
                      )}
                      content={() => this.componentRef}
                      onBeforePrint={() => this.onBeforePrint}
                    />
                  </div>
                </div>
              </div>
            </div>
            <div
              className={
                this.state.showReplace
                  ? 'table-filters'
                  : 'table-filters hidden-element'
              }
              key={'table-filters'}
            />

            <div className="controls">
              <Paginator
                pagination={pagination}
                pages={paginated.amount}
                onSelect={this.onSelect}
              />
            </div>

            <div
              className={
                this.state.showReplace
                  ? 'table-container table-container-replace-show'
                  : 'table-container table-container-replace-hide'
              }
              id={'table_container'}
              onScroll={this.handleScroll}
            >
              <Table
                className="table table-bordered"
                columnNames={this.columnFilters}
                /*columnNames={this.none}*/
                data={paginated.rows}
                columns={columns2}
                row={(d, rowIndex) => {
                  //var rowClass = rowIndex % 2 ? 'odd-row' : 'even-row';
                  var rowClass = 'dr_table-row';
                  if (rowIndex == editedRow)
                    rowClass = 'dr_table-row edited-row';
                  return {
                    className: rowClass,
                    onClick: () =>
                      this.onClickRow(rowIndex, paginated.rows[rowIndex])
                  };
                }}
                rowKey="id"
              />
            </div>
          </div>
        </div>
        <div className="col main-container dr_view">
          <DrView
            className="dr-view"
            project={project}
            dr_details={dr_details}
            onCommentSave={this.onCommentSave}
            onDrInsert={this.onDrInsert}
            is_dr_new={is_dr_new}
            onDrCancel={this.onDrCancel}
          />
        </div>
      </div>
    );
  }
});

$(document).ready(function() {
  var appElement = document.getElementById('dr_table');
  if (appElement) {
    Modal.setAppElement(appElement);
    ReactDOM.render(
      <TableContainer
        columns={columns}
        data={data}
        objectType={model_name}
        title={title}
        project={project}
      />,
      appElement
    );
  }
});

function augmentWithTitles(o) {
  for (var property in o) {
    o[property].title = titleCase(property);
  }

  return o;
}
