var React = require('react');
var Modal = require('react-modal');

// preview results
var ImportStep3 = React.createClass({
  displayName: 'ImportStep3',

  getInitialState: function() {
    return {
      modalIsOpen: false,
      options:[]
    };
  },

  afterOpenModal() {
    var options = [];
    var importHeaders = this.props.columns; 
    Object.keys(importHeaders).forEach(function(key) {
      if (importHeaders[key]['to']) {
        options.push({value: importHeaders[key]['to'], label: importHeaders[key]['toColumn']['label']})
      }
    });
    this.setState({options:options});
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
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel} onAfterOpen={this.afterOpenModal}>
          <h2>Шаг 3. Выберите ключевое поле</h2>

          <div>Выберите ключевое поле</div>

          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.prevModal}>Назад</button>
          <button onClick={this.nextModal}>Далее</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep3;
