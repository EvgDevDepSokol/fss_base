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
    return (
      <div className="import-from-excel-3">
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={this.props.style}
        >
          <h2>Processing</h2>
          <div>Ваш файл обрабатывается</div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile} />
          <button onClick={this.closeModal}>close</button>
          <button onClick={this.openModalStep2}>Next</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep3;
