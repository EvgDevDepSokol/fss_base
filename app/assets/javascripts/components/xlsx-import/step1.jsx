var React = require('react');
var SimpleSelect = require('../../modules/simple-select.jsx');
var Modal = require('react-modal');
var _ = require('underscore');

var ImportStep1 = React.createClass({
  displayName: 'ImportStep1',

  getInitialState: function() {
    return {
      file: null
    };
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    if(this.state.file != null){
      this.props.onNextModal(this.state.file);
    }else
      this.closeModal();
  },

  processFile: function(file){
    var findColumnData = function(colProperty){
      return _.find(columns, function(col){
//        return col.property == colProperty;
        //return col.header == colProperty;
        return col.label == colProperty;
      });
    };

    // перенести в step 2
    var onSelectChange = function(columnKey){
      var context = this;
      return function(value){
        var impColumns = context.state.columns;
        impColumns[columnKey]['to'] = value;
        impColumns[columnKey]['toColumn'] = context.findColumnData(value);
        context.setState({columns: impColumns});
      }
    }.bind(this);
//    };

    var reader = new FileReader();
    this.setState({fileName: file.name});
    reader.onload = function(e) {
      var importData = e.target.result;
      var workbook = XLSX.read(importData, {type: 'binary'});

      var importJson = workbook_to_json(workbook);
      var importHeaders = {};
      importJson[0].data.forEach(function(row){
        Object.keys(row).forEach(function(key){
          if(importHeaders[key] == null)
          {
            importHeaders[key] = {};
          }
        });
      });

      var options = [];
      columns.forEach(function(col){
        var label = col.header;
        if(col.property == 'id'){
          label = col.header + ' (key)';
        }
        if(col.nested){
          if(col.attribute)
            options.push({value: col.property, label: label });
        }else{
          options.push({value: col.property, label: label });
        }
      });

      var selectProps = {options: options};
      Object.keys(importHeaders).forEach(function(key) {
        //selectProps['name'] = 'select' + key;
        selectProps['onChange'] = onSelectChange(key);
//        selectProps['value'] = null;
        selectProps['value'] = key;
        selectProps['selected'] = key;

        var toColumnSelector = React.createElement(SimpleSelect, selectProps);
        importHeaders[key] = {selector: toColumnSelector, to: selectProps['value']};
        if(selectProps['value'] != null)
          importHeaders[key]['toColumn'] = findColumnData(selectProps['value']);
      });

      var a = [];
      a.push(importJson);
      a.push(importHeaders);

      this.props.rememberData(a);
    }.bind(this);

    reader.readAsBinaryString(file);

  },

  onImportFile: function(e) {
    var files = e.target.files;
    if(files.length > 0){
      var file = files[0];
      this.setState({file: file});
    }
    this.processFile(file);
  }, 

  render: function() {
    return (
      <div className="import-from-excel-1">
        <Modal
          isOpen={this.props.isOpen}
          onRequestClose={this.closeModal}
          style={this.props.style}
        >
          <h2>Step 1. Select a file</h2>
          <div>Выберите файл для продолжения</div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile} />
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.nextModal}>Далее</button>

          <div></div>
          <div>В файле должны содержаться данные для текущей таблицы текущего проекта</div>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep1;
