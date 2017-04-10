import React from 'react';
import PropTypes from 'prop-types';
//import ReactDOM from 'react-dom';
import Modal from 'react-modal';
//
//
///*
//The app element allows you to specify the portion of your app that should be hidden (via aria-hidden)
//to prevent assistive technologies such as screenreaders from reading content outside of the content of
//your modal.  It can be specified in the following ways:
//
//* element
//Modal.setAppElement(appElement);
//
//* query selector - uses the first element found if you pass in a class.
//Modal.setAppElement('#your-app-element');
//
//*/
//const appElement1 = document.getElementById('export-to-excel');
//
//
//
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
//
//
class ExportXlsxModal extends React.Component {
  constructor() {
    super();

    this.state = {
      modalIsOpen: false,
      exportIndex: 0
    };

    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.onExport = this.onExport.bind(this);
    this.onRadioChange = this.onRadioChange.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.refs.subtitle.style.color = '#0081c2';
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  onRadioChange(e) {
    var exportIndex = parseInt(e.target.value, 10);
    this.setState({exportIndex: exportIndex})
  }

  onExport() {
    var exportIndex = this.state.exportIndex;
    this.props.onExport(exportIndex);
    this.setState({modalIsOpen: false});
  }

  render() {
    var data = this.props.data;
    var cnt_all = data.length;
    var cnt_chk = data.filter(function(elem) {
      return elem.checked
    }).length;
    return (
      <div className="export-to-excel" onClick={this.openModal}>
        Экспорт в Excel
        <Modal isOpen={this.state.modalIsOpen} onAfterOpen={this.afterOpenModal} onRequestClose={this.closeModal} style={customStyles} contentLabel="Свойства экспорта в файл">

          <h2 ref="subtitle">Свойства экспорта в файл</h2>
          <div className='export-radio-group'>
            <input type='radio' name='export-prop' value='0' checked={this.state.exportIndex === 0} onChange={this.onRadioChange}/>
            Экспортировать все: {cnt_all}
            записей<br/>
            <input type='radio' name='export-prop' value='1' checked={this.state.exportIndex === 1} onChange={this.onRadioChange}/>
            Экспортировать отмеченные: {cnt_chk}
            записей<br/>
          </div>
          <div></div>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.onExport}>Экспорт</button>
        </Modal>
      </div>
    );
  }
}

module.exports = ExportXlsxModal;
