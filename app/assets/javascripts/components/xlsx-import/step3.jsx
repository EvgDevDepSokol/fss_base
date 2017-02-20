var React = require('react');
var Modal = require('react-modal');

// preview results
var ImportStep3 = React.createClass({
  displayName: 'ImportStep3',

  getInitialState: function() {
    return {
      modalIsOpen: false
    };
  },

  openModal: function() {
    this.setState({modalIsOpen: true});
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    this.props.onNextModal();
  },

  render: function() {
    var importColumns = this.props.columns;
    debugger
    var headersTo = Object.keys(importColumns).map(function(key, i)  {
      return (
        <th key={i + '-header'} className={"select-header"} >
          {importColumns[key].selector}
        </th>
      );
    });
    return (
      <div className="import-from-excel-3">
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={this.props.style}
        >
          <h2>Processing</h2>

          <div>Выберите ключевое поле</div>
          <div>
            {headersTo}
          </div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile} />
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.nextModal}>Далее</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep3;
