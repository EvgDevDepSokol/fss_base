var React = require('react');
import Modal from 'react-modal';
var SimpleSelect = require('../../modules/simple-select.jsx');
var XlsxImport = require('../xlsx-import.jsx');
var _ = require('underscore');

var ImportStep2 = React.createClass({
      displayName: 'ImportStep2',

      getInitialState: function () {
        return {
          message: [],
          options: [],
          options3: []
        };
      },

      closeModal: function () {
        this
          .props
          .onCloseModal();
      },

      nextModal: function () {
        var importHeaders = this.props.columns;
        var options = [];
        var message = [];
        Object.keys(importHeaders).forEach(function (key) {
          if(importHeaders[key]['to']) {
            options.push({
              label: importHeaders[key]['toColumn']['label'],
              key: key
            })
          }
        });

        if(options.length <= 0) {
          message.push('Выберите столбцы для импорта. Сейчас выбрано 0 столбцов.');
        } else {
          var n = {};
          for(var i = 0; i < options.length; i++) {
            if(!n[options[i].label]) {
              n[options[i].label] = {
                cnt: 1,
                col: '\'' + options[i].key + '\''
              };
            } else {
              n[options[i].label].cnt++;
              n[options[i].label].col = n[options[i].label].col + ', \'' + options[i].key + '\'';
            }
          }
          Object
            .keys(n)
            .forEach(function (key) {
              if(n[key].cnt > 1) {
                message.push('Поле импорта \'' + key + '\' выбрано несколько раз. Проверьте столбцы: ' + n[key].col + '.');
              }
            });
        };

        if(message > '') {
          this.setState({
            message: message
          });
        } else {
          this.setState({
            message: []
          });
          this
            .props
            .rememberColumns(importHeaders);
          this.checkKeyColumn();
        };
      },

      findColumnData: function (colProperty) {
        return _.find(columns, function (col) {
          return col.property == colProperty;
        });
      },

      afterOpenModal() {
        var isEmptyObj = function (obj) {
          return Object
            .keys(obj)
            .length === 0 && obj.constructor === Object;
        };
        var options = [];
        columns.forEach(function (col) {
          var label = col.label;
          var property = col.property;
          if(property == 'id') {
            label = 'id';
          }
          if(col.nested) {
            if(col.attribute)
              options.push({
                value: property,
                label: label
              });
          } else {
            options.push({
              value: property,
              label: label
            });
          }
        });

        var importHeaders = this.props.columns;
        var context = this;
        Object
          .keys(importHeaders)
          .forEach(function (key) {
            var selectVal = '';
            options.forEach(function (opt) {
              if(opt['label'] == key)
                selectVal = opt['value'];
            });

            importHeaders[key] = {
              to: selectVal
            };
            if(selectVal != null)
              importHeaders[key]['toColumn'] = context.findColumnData(selectVal);
          });

        this.setState({
          options: options,
          message: []
        });
        this
          .props
          .rememberColumns(importHeaders);
        this.refreshKeyColumnSelector();
      },

      refreshKeyColumnSelector() {
        var options3 = [];
        var importHeaders = this.props.columns;
        Object
          .keys(importHeaders)
          .forEach(function (key) {
            if(importHeaders[key]['to']) {
              options3.push({
                value: importHeaders[key]['toColumn']['attribute'] ?
                  importHeaders[key]['toColumn']['attribute'] : importHeaders[key]['to'],
                label: importHeaders[key]['toColumn']['label'] ?
                  importHeaders[key]['toColumn']['label'] : importHeaders[key]['to']
              })
            }
          });
        this.setState({
          options3: options3
        });
      },

      prevModal: function () {
        this
          .props
          .onPrevModal();
      },

      onKeyColumnChange: function (value) {
        this
          .props
          .rememberKeyColumn(value);
      },

      checkKeyColumn: function () {
        var keyColumn = this.props.keyColumn;
        var importHeaders = this.props.columns;
        var importData = this.props.importData;
        var keyImport = '';
        var message = [];
        if(keyColumn) {
          Object
            .keys(importHeaders)
            .forEach(function (key) {
              if(importHeaders[key]['to']) {
                if((importHeaders[key]['to'] == keyColumn) || (importHeaders[key]['toColumn']['attribute'] == keyColumn)) {
                  keyImport = key;
                }
              }
            });
          var n = {},
            r = '';
          for(var i = 0; i < importData.length; i++) {
            r = importData[i][keyImport];
            if(!r)
              r = 'undefined';
            if(!n[r]) {
              n[r] = {
                cnt: 1,
                col: '\'' + (i + 1) + '\''
              };
            } else {
              n[r].cnt++;
              n[r].col = n[r].col + ', \'' + (i + 1) + '\'';
            }
          };

          if(n['undefined']) {
            message.push('В некоторых записях файла ключевое поле является пустым.')
            message.push(' Проверьте записи: ' + n['undefined'].col + '.');
          };

          Object
            .keys(n)
            .forEach(function (key) {
              if((n[key].cnt > 1) && (key !== 'undefined')) {
                message.push('В файле встречаются записи с одинаковым ключом: \'' + key + '\'.')
                message.push(' Проверьте записи: ' + n[key].col + '.');
              }
            });
        } else {
          message.push('Выберите ключевое поле импорта. Сейчас поле не выбрано.');
        };

        if(message > '') {
          this.setState({
            message: message
          });
        } else {
          this.setState({
            options3: [],
            message: [],
            options: []
          });
          this
            .props
            .onNextModal();
        };
      },

      render: function () {
        var importHeaders = this.props.columns;
        var options = this.state.options;
        var context = this;
        var message = this.state.message;

        var options3 = this.state.options3;
        if(this.props.isOpen) {
          var message = $.map(message, function (m, i) {
              return( < p key = {
                  i + '-message'
                } > {
                  m
                } < /p>)
              });

            if(options3) {
              var keyColumnSelector = < SimpleSelect 
                onSelectChange = {this.onKeyColumnChange}
                value = {this.props.keyColumn}
                options = {options3} />}

              Object
                .keys(importHeaders)
                .forEach(function (key) {
                  var selectVal = context.props.columns[key]['to'];
                  var toColumnSelector = React.createElement(SimpleSelect, {
                    onSelectChange: function (value) {
                      var importHeaders = context.props.columns;
                      var findColumnData = context.findColumnData;
                      var columnKey = this.columnKey;
                      importHeaders[columnKey]['to'] = value;
                      importHeaders[columnKey]['toColumn'] = context.findColumnData(value);
                      context
                        .props
                        .rememberColumns(importHeaders);
                      context.refreshKeyColumnSelector();
                    },
                    value: selectVal,
                    options: options,
                    columnKey: key
                  });

                  importHeaders[key] = {
                    selector: toColumnSelector,
                    to: selectVal
                  };
                  if(selectVal != null)
                    importHeaders[key]['toColumn'] = context.findColumnData(selectVal);
                });

              if(importHeaders != null) {
                var headersFrom = Object.keys(importHeaders).map(function (key, i) {
                  var className = importHeaders[key]['to'] ?
                    "static-header" :
                    "static-header not-editable";
                  return(<th key = {i + '-header'} className = {className}>{key}</th>);
                });
                var headersTo = Object.keys(importHeaders).map(function (key, i) {
                  return(<th key = {i + '-header'} className = {"select-header"}>{importHeaders[key].selector}</th>);
                });

                var rows = null;
                if(this.props.importData.length > 0) {
                  rows = this.props.importData.slice(0, 20).map(function (row, i) {
                    var cells = Object.keys(importHeaders).map(function (key, j) {
                      return(<td key = {i + '-' + j + '-cell'}>{row[key]}</td>);
                    });

                    return(<tr key = {i + '-row'}>{cells}</tr>);
                  });
                }
                var message = $.map(message, function (m, i) {
                  return(<p key = {i + '-message'}>{m}</p>)
                });
              }
              return( <div className = "import-from-excel-2" >
                <Modal isOpen = {
                  this.props.isOpen
                }
                onRequestClose = {
                  this.closeModal
                }
                style = {
                  this.props.style
                }
                contentLabel = {
                  this.props.contentLabel
                }
                onAfterOpen = {
                  this.afterOpenModal
                } >
                < h1 > Импорт в таблицу: {title} < /h1>
                < h2 > Шаг 2. Выберите столбцы < /h2 > < div className = "modal-table-container" key = {
                "modal-table"
              } > < table className = {"table table-bordered table-striped table-hover"} >
                    <thead>
                      <tr>{headersFrom}</tr><tr className = "selector-header">{headersTo}</tr>
                    </thead>
                    < tbody >{rows}< /tbody >
                  < /table > < /div > < p > Всего {this.props.importData.length} строк данных. < /p > < div > Укажите соответствия импорта колонок. < /div >
                  < h2 > Шаг 3. Выберите ключевое поле < /h2 >
                  < div > Выберите ключевое поле, по которому запись будет искаться в базе. < /div >
                  < div > Значение поля для каждой записи из импортируемого файла должно быть уникальным и не должно быть пустым. < /div >
                  < div > При возникновении сообщения об ошибке, внесите исправления в импортруемый файл и начните импорт заново. < /div >
                  < div >
                    {keyColumnSelector}
                  < /div >
                  < button onClick = {this.closeModal} > Отмена < /button >
                  < button onClick = {this.nextModal } > Далее < /button >
                  < p > В файле должны содержаться данные для текущей таблицы текущего проекта. < /p >
                  < div className = {'modal-warning'} >
                    {message}
                  < /div >
                < /Modal >
              < /div >);
          }
          else {
            return( < div / > );
          }
        }
      });

    module.exports = ImportStep2;
