import React from 'react';
import PropTypes from 'prop-types';
import Modal from 'react-modal';
import XLSX from 'xlsx'

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
    this.compare_kursks = this.compare_kursks.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  afterOpenModal() {
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

  compare_kursks() {
    $.ajax(
    {
      url: '/compare_kursks',
      dataType: 'json',
      type: 'PUT',
      success: function (responce)
      {
        debugger
        var bookname = 'kursk_evolution.xls';
        var wb = XLSX.utils.book_new();
        var ws;
        //function arr_to_json(arr) {
        //  return arr.map(function(ref){
        //    return {ref: ref}
        //  })
        //};   
        debugger
        ws = XLSX.utils.json_to_sheet(responce.pag1);   
        XLSX.utils.book_append_sheet(wb,ws,'Курск')
        ws = XLSX.utils.json_to_sheet(responce.pag2);   
        XLSX.utils.book_append_sheet(wb,ws,'Курск 2014')
        ws = XLSX.utils.json_to_sheet(responce.pag3);   
        XLSX.utils.book_append_sheet(wb,ws,'Совпадающие ref')
        XLSX.writeFile(wb,bookname,{ bookType:'biff8'});
      },
      error: function (xhr, status, err)
      {
        debugger
      },
      async: true
    });
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

          <h4 ref="subtitle">Экспорт производится с учетом активных фильтров.</h4>
          <h3 ref="subtitle">Свойства экспорта в файл:</h3>
          <div className='export-radio-group'>
            <input type='radio' name='export-prop' value='0' checked={this.state.exportIndex === 0} onChange={this.onRadioChange}/>
             Экспортировать все: {cnt_all} записей;<br/>
            <input type='radio' name='export-prop' value='1' checked={this.state.exportIndex === 1} onChange={this.onRadioChange}/>
             Экспортировать отмеченные: {cnt_chk} записей.<br/>
          </div>
          <h3></h3>
          <h3></h3>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.onExport}>Экспорт</button>
          <h3></h3>
          <h3></h3>
          <div>
            <button onClick={this.compare_kursks}>Различие курских проектов</button>
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = ExportXlsxModal;
