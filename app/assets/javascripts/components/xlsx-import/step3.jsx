var React = require('react');
var Modal = require('react-modal');

// preview results
var ImportStep3 = React.createClass({
  displayName: 'ImportStep3',

  getInitialState: function() {
    return {modalIsOpen: false};
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    this.props.onNextModal();
  },

  prevModal: function() {
    this.props.onPrevModal();
  },

  render: function() {
    var importColumns = this.props.columns;
    return (
      <div className="import-from-excel-3">
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel}>
          <h2>Шаг 3. Выберите ключевое поле</h2>

          <div>Выберите ключевое поле</div>

          <input type="file" name="xlfile" id="xlf" ref="fileImport" onChange={this.onImportFile}/>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.prevModal}>Назад</button>
          <button onClick={this.nextModal}>Далее</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep3;
