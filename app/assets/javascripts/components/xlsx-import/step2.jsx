var React = require('react');
var Modal = require('react-modal');
var SimpleSelect = require('../../modules/simple-select.jsx');
var XlsxImport = require('../xlsx-import.jsx');
var _ = require('underscore');

// preview data
var ImportStep2 = React.createClass({
  displayName: 'ImportStep2',

  getInitialState: function() {
    return {
      modalIsOpen: false,
      importHeaders: this.props.columns,
      options:[]
    };
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    var importHeaders = this.state.importHeaders;

    this.props.rememberColumns(importHeaders);
    this.props.onNextModal();
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
      if (col.property == 'id') {
        label = 'id';
      }
      if (col.nested) {
        if (col.attribute)
          options.push({value: col.property, label: label});
        }
      else {
        options.push({value: col.property, label: label});
      }
    });

    var importHeaders = (isEmptyObj(this.state.importHeaders))? this.props.columns : this.state.importHeaders; 
    var context=this;
    Object.keys(importHeaders).forEach(function(key) {
      if (isEmptyObj(context.state.importHeaders)) {
        var selectVal = '';
        options.forEach(function(opt) {
          if (opt['label'] == key)
            selectVal = opt['value'];
          }
        );
      } else {
        var selectVal = context.state.importHeaders[key]['to'];
      };      

      importHeaders[key] = {
        to: selectVal
      };
      if (selectVal != null)
        importHeaders[key]['toColumn'] = context.findColumnData(selectVal);
    });

    this.setState({
      importHeaders: importHeaders,
      options:options
    });
  },  

  render: function() {
    var importHeaders = this.state.importHeaders; 
    var options = this.state.options;
    var context=this;
    Object.keys(importHeaders).forEach(function(key) {
      var selectVal = context.state.importHeaders[key]['to'];
      var toColumnSelector = React.createElement(SimpleSelect, {
        onSelectChange: function(value) {
          //var importHeaders = (isEmptyObj(context.state.importHeaders))? context.props.columns : context.state.importHeaders; 
          var importHeaders =  context.state.importHeaders; 
          var findColumnData = context.findColumnData;
          var columnKey = this.columnKey;
          importHeaders[columnKey]['to'] = value;
          importHeaders[columnKey]['toColumn'] = context.findColumnData(value);
          context.setState({importHeaders: importHeaders})
          //context.props.rememberColumns(importHeaders);
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
            <p>Всего {this.props.importData.length}
              строк данных</p>
            <div>Укажите соответствия импорта колонок</div>

            <button onClick={this.closeModal}>Отмена</button>
            <button onClick={this.nextModal}>Далее</button>
            <div></div>
            <div>В файле должны содержаться данные для текущей таблицы текущего проекта</div>
          </Modal>
        </div>
      );
    } else {
      return (<div/>);
    }
  }
});

module.exports = ImportStep2;
