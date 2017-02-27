var React = require('react');
var Modal = require('react-modal');

var ImportStep1 = React.createClass({
  displayName: 'ImportStep1',

  getInitialState: function() {
    return {file: null};
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    if (this.state.file != null) {
      this.props.onNextModal(this.state.file);
    } else {
      this.closeModal();
    }
  },

  processFile: function(file) {

    var reader = new FileReader();
    this.setState({fileName: file.name});
    reader.onload = function(e) {
      var importData = e.target.result;
      var workbook = XLSX.read(importData, {type: 'binary'});

      var importJson = workbook_to_json(workbook);
      var importHeaders = {};
      importJson[0].data.forEach(function(row) {
        Object.keys(row).forEach(function(key) {
          if (importHeaders[key] == null) {
            importHeaders[key] = {};
          }
        });
      });

      this.props.rememberData(importJson);
      this.props.rememberColumns(importHeaders);
    }.bind(this);

    reader.readAsBinaryString(file);

  },

  onImportFile: function(e) {
    var files = e.target.files;
    if (files.length > 0) {
      var file = files[0];
      this.setState({file: file});
    }
    this.processFile(file);
  },

  render: function() {
    return (
      <div className="import-from-excel-1">
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel}>
          <h2>Step 1. Select a file</h2>
          <div>Выберите файл для продолжения</div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile}/>
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
