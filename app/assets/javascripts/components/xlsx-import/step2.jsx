var React = require('react');
var Modal = require('react-modal');
var SimpleSelect = require('../../modules/simple-select.jsx');
var XlsxImport = require('../xlsx-import.jsx');
var _ = require('underscore');

var ImportStep2 = React.createClass({
  displayName: 'ImportStep2',

  getInitialState: function() {
    return {
      message:[],
      options:[]
    };
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    var importHeaders = this.props.columns;
    var options = [];
    var message = [];
    Object.keys(importHeaders).forEach(function(key) {
      if (importHeaders[key]['to']) {
        options.push({label: importHeaders[key]['toColumn']['label'], key: key})
      }
    });

    if (options.length <= 0) {
      message.push('Выберите столбцы для импорта. Сейчас выбрано 0 столбцов.');
    } else {  
      var n = {};
      for(var i = 0; i < options.length; i++) 
      {
        if (!n[options[i].label]) 
        {
          n[options[i].label] = {cnt:1, col:'\''+options[i].key+'\''};
        } else {
          n[options[i].label].cnt++; 
          n[options[i].label].col = n[options[i].label].col + ', \'' + options[i].key+'\''; 
        }
      }
      Object.keys(n).forEach(function(key) {
        if (n[key].cnt>1) {
          message.push('Поле импорта \''+key+'\' выбрано несколько раз. Проверьте столбцы: '+n[key].col+'.');
        }
      });
    };

    if (message > '') {
      this.setState({message:message});
    } else {
      this.setState({
        message:[],
        options:[]
      });
      this.props.rememberColumns(importHeaders);
      this.props.onNextModal();
    };
  },

  findColumnData: function(colProperty) {
    return _.find(columns, function(col) {
      return col.property == colProperty;
    });
  },

  afterOpenModal() {
    var isEmptyObj = function(obj){
      return Object.keys(obj).length === 0 && obj.constructor === Object;
    };
    var options = [];
    columns.forEach(function(col) {
      var label = col.label;
      var property = col.property;
      if (property == 'id') {
        label = 'id';
      }
      if (col.nested) {
        if (col.attribute)
          options.push({value: property, label: label});
        }
      else {
        options.push({value: property, label: label});
      }
    });

    var importHeaders = this.props.columns; 
    var context=this;
    Object.keys(importHeaders).forEach(function(key) {
      var selectVal = '';
      options.forEach(function(opt) {
        if (opt['label'] == key)
          selectVal = opt['value'];
        }
      );

      importHeaders[key] = {
        to: selectVal
      };
      if (selectVal != null)
        importHeaders[key]['toColumn'] = context.findColumnData(selectVal);
    });

    this.setState({
      options:options,
      message: []
    });
    this.props.rememberColumns(importHeaders);
  },  

  render: function() {
    var importHeaders = this.props.columns; 
    var options = this.state.options;
    var context=this;
    var message=this.state.message;
    Object.keys(importHeaders).forEach(function(key) {
      var selectVal = context.props.columns[key]['to'];
      var toColumnSelector = React.createElement(SimpleSelect, {
        onSelectChange: function(value) {
          var importHeaders =  context.props.columns; 
          var findColumnData = context.findColumnData;
          var columnKey = this.columnKey;
          importHeaders[columnKey]['to'] = value;
          importHeaders[columnKey]['toColumn'] = context.findColumnData(value);
          context.props.rememberColumns(importHeaders);
        },
        value: selectVal,
        options: options,
        columnKey: key
      });

      importHeaders[key] = {
        selector: toColumnSelector,
        to: selectVal
      };
      if (selectVal != null)
        importHeaders[key]['toColumn'] = context.findColumnData(selectVal);
    });

    if (importHeaders != null) {
      var headersFrom = Object.keys(importHeaders).map(function(key, i) {

        return (
          <th key={i + '-header'} className={"static-header"}>
            {key}
          </th>
        );
      });
      var headersTo = Object.keys(importHeaders).map(function(key, i) {
        return (
          <th key={i + '-header'} className={"select-header"}>
            {importHeaders[key].selector}
          </th>
        );
      });

      var rows = null;
      if (this.props.importData.length > 0) {
        rows = this.props.importData.slice(0, 10).map(function(row, i) {

          var cells = Object.keys(importHeaders).map(function(key, j) {
            return (
              <td key={i + '-' + j + '-cell'}>
                {row[key]}
              </td>
            );
          });

          return (
            <tr key={i + '-row'}>
              {cells}
            </tr>
          );
        });
      }
      var message = $.map(message,function(m,i){
        return(
          <p key={i+'-message'}>{m}</p>
        )
      });
      return (
        <div className="import-from-excel-2">
          <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel} onAfterOpen={this.afterOpenModal}>
            <h2>Шаг 2. Выберите столбцы</h2>
            <table className={"table table-bordered table-striped table-hover"}>
              <thead>
                <tr>
                  {headersFrom}
                </tr>
                <tr className="selector-header">
                  {headersTo}
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
            <p>Всего {this.props.importData.length} строк данных.</p>
            <div>Укажите соответствия импорта колонок.</div>

            <button onClick={this.closeModal}>Отмена</button>
            <button onClick={this.nextModal}>Далее</button>
            <p>В файле должны содержаться данные для текущей таблицы текущего проекта.</p>
            <div className={'modal-warning'}>{message}</div>
          </Modal>
        </div>
      );
    } else {
      return (<div/>);
    }
  }
});

module.exports = ImportStep2;
