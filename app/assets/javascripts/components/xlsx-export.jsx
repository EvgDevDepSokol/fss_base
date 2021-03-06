import React from 'react';
import Modal from 'react-modal';
import PropTypes from 'prop-types';

const customStyles = {
  content: {
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)'
  }
};

class ExportXlsxModal extends React.Component {
  state = {
    modalIsOpen: false,
    exportIndex: 0
  };
  static propTypes = { onExport: PropTypes.func, data: PropTypes.array };

  openModal = () => {
    this.setState({ modalIsOpen: true });
  };

  closeModal = () => {
    this.setState({ modalIsOpen: false });
  };

  onRadioChange = e => {
    var exportIndex = parseInt(e.target.value, 10);
    this.setState({ exportIndex: exportIndex });
  };

  onExport = () => {
    var exportIndex = this.state.exportIndex;
    this.props.onExport(exportIndex, this.props.data);
    this.setState({ modalIsOpen: false });
  };

  render() {
    var data = this.props.data;
    var cnt_all = data.length;
    var cnt_chk = data.filter(function(elem) {
      return elem.checked;
    }).length;
    return (
      <div className="export-to-excel" onClick={this.openModal}>
        Экспорт в Excel
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Свойства экспорта в файл"
        >
          <h4>Экспорт производится с учетом активных фильтров.</h4>
          <h3>Свойства экспорта в файл:</h3>
          <div className="export-radio-group">
            <input
              type="radio"
              name="export-prop"
              value="0"
              checked={this.state.exportIndex === 0}
              onChange={this.onRadioChange}
            />
            Экспортировать все: {cnt_all} записей;
            <br />
            <input
              type="radio"
              name="export-prop"
              value="1"
              checked={this.state.exportIndex === 1}
              onChange={this.onRadioChange}
            />
            Экспортировать отмеченные: {cnt_chk} записей.
            <br />
          </div>
          <h3 />
          <h3 />
          <button onClick={this.onExport}>Экспорт</button>
          <button onClick={this.closeModal}>Отмена</button>
        </Modal>
      </div>
    );
  }
}

module.exports = ExportXlsxModal;
