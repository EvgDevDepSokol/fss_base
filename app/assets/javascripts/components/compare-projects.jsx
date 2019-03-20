/* global $ */
import React from 'react';
import Modal from 'react-modal';
import XLSX from 'xlsx';

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

class CompareProjects extends React.Component {
  state = {
    modalIsOpen: false,
    exportIndex: 0
  };

  openModal = () => {
    this.setState({ modalIsOpen: true });
  };

  afterOpenModal = () => {
    this.refs.subtitle.style.color = '#0081c2';
  };

  closeModal = () => {
    this.setState({ modalIsOpen: false });
  };

  compare_balakovo = () => {
    this.compare_projects(80000004, 88, 'balakovo_diff.xls');
  };

  compare_kursk2 = () => {
    this.compare_projects(83, 80000002, 'kursk2_diff.xls');
  };

  compare_kursk4 = () => {
    this.compare_projects(80000001, 80000003, 'kursk4_diff.xls');
  };

  compare_smolensk2 = () => {
    this.compare_projects(80000005, 90, 'smolensk2_diff.xls');
  };

  compare_projects = (project_old_id, project_new_id, bookname) => {
    var data = {
      project_old_id: project_old_id,
      project_new_id: project_new_id
    };
    $.ajax({
      url: '/compare_projects',
      dataType: 'json',
      data: data,
      type: 'PUT',
      success: function(responce) {
        var wb = XLSX.utils.book_new();
        var ws;
        ws = XLSX.utils.json_to_sheet(responce.pag1);
        XLSX.utils.book_append_sheet(wb, ws, 'Удалено');
        ws = XLSX.utils.json_to_sheet(responce.pag2);
        XLSX.utils.book_append_sheet(wb, ws, 'Добавлено');
        ws = XLSX.utils.json_to_sheet(responce.pag3);
        XLSX.utils.book_append_sheet(wb, ws, 'Изменено');
        XLSX.writeFile(wb, bookname, { bookType: 'biff8' });
      },
      error: function(xhr, status, err) {},
      async: true
    });
  };

  render() {
    return (
      <div className="compare-projects">
        <a onClick={this.openModal}>
          <div className="header-icon" />
          Сравнение
        </a>

        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Различия проектов"
        >
          <h4 ref="subtitle">Сравнить проекты</h4>
          <div className="compare-projects-inner">
            <h3 />
            <h3 />
            <div>
              <button onClick={this.compare_smolensk2}>ПМТ Смоленск-2</button>
            </div>
            <h3 />
            <h3 />
            <h3 />
            <div>
              <button onClick={this.compare_kursk2}>Курск-2</button>
            </div>
            <h3 />
            <h3 />
            <div>
              <button onClick={this.compare_kursk4}>ПМТ КуАЭС-4</button>
            </div>
            <h3 />
            <h3 />
            <div>
              <button onClick={this.compare_balakovo}>ПМТ БалАЭС-1</button>
            </div>
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = CompareProjects;
