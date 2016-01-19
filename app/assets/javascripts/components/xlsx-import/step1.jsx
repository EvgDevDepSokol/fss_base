var React = require('react');
var SimpleSelect = require('../../modules/simple-select.jsx');
var Modal = require('react-modal');

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

  onImportFile: function(e) {
  

    var files = e.target.files;


    if(files.length > 0){
      var file = files[0];
      this.setState({file: file});
    }

    this.processFile(file);

/*    var reader = new FileReader();
    this.setState({fileName: file.name});
    reader.onload = function(e) {

      debugger;
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
     

      context = this;
      var selectProps = {options: options};
      Object.keys(importHeaders).forEach(function(key) {
        //selectProps['name'] = 'select' + key;
        selectProps['onChange'] = onSelectChange(key);
        selectProps['value'] = null;
        selectProps['selected'] = key;

       var toColumnSelector = React.createElement(SimpleSelect, selectProps);

        importHeaders[key] = {selector: toColumnSelector, to: selectProps['value']};
        if(selectProps['value'] != null)
          importHeaders[key]['toColumn'] = context.findColumnData(selectProps['value']);
      });

    }*/

  }, 

  processFile: function(file){
    debugger;
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

    //debugger;
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


      var context = this;
      var selectProps = {options: options};
      Object.keys(importHeaders).forEach(function(key) {
        //selectProps['name'] = 'select' + key;
        selectProps['onChange'] = onSelectChange(key);
        selectProps['value'] = null;
        selectProps['selected'] = key;

       var toColumnSelector = React.createElement(SimpleSelect, selectProps);

        importHeaders[key] = {selector: toColumnSelector, to: selectProps['value']};
        if(selectProps['value'] != null)
          importHeaders[key]['toColumn'] = context.findColumnData(selectProps['value']);
      });

      //debugger;
      this.setState({
        importData: importJson,
        columns: importHeaders,
//        step: 2
      });
      /* DO SOMETHING WITH workbook HERE */
    }.bind(this);

    reader.readAsBinaryString(file);
    //this.setState({step: 2});
  },

  render: function() {
    return (
      <div>
        <Modal
          isOpen={this.props.isOpen}
          onRequestClose={this.closeModal}
        >
          <h2>Step 1. Select a file</h2>
          <div>Выберите файл для продолжения</div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile} />
          <button onClick={this.closeModal}>close</button>
          <button onClick={this.nextModal}>Next</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep1;
