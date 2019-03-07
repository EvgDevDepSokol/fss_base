import React from 'react';
import Modal from 'react-modal';
import PropTypes from 'prop-types';
import { prepareRow } from './dr_data.jsx';
const HEADERS = {
  opn: 'Открытых',
  cls: 'Закрытых',
  rdy: 'Готовых к проверке',
  ovd: 'Просроченных',
  tot: 'Всего'
};

const customStyles = {
  content: {
    height: '90%',
    width: '80%',
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    marginBottom: '-50%',
    transform: 'translate(-50%, -50%)'
  }
};

class DrStatisticsModal extends React.Component {
  static displayName = 'DrStatisticsModal';
  state = {
    modalIsOpen: false,
    exportIndex: 0
  };

  static propTypes = { data: PropTypes.array };

  openModal = () => {
    this.setState({ modalIsOpen: true });
  };

  afterOpenModal = () => {
    var data = this.props.data;
    var stat_sys = {};
    var stat_eng = {};
    var sys_id;
    var this_ = this;
    Object.keys(sys_eng_list).forEach(function(key) {
      stat_sys[key] = {
        opn: 0,
        cls: 0,
        rdy: 0,
        ovd: 0,
        tot: 0
      };
    });
    var date_now = new Date(Date.now());
    data.forEach(function(row) {
      row = prepareRow(row, date_now);
      sys_id = row.system.id;
      if (stat_sys[sys_id]) {
        stat_sys[sys_id]['tot']++;
      } else {
        stat_sys[sys_id] = {
          opn: 0,
          cls: 0,
          rdy: 0,
          ovd: 0,
          tot: 1
        };
      }
      var last_status = row['comments'].slice(-1)[0].status;
      if (last_status == 4) {
        stat_sys[sys_id]['cls']++;
      } else {
        stat_sys[sys_id]['opn']++;
        if (last_status == 3) stat_sys[sys_id]['rdy']++;
        if (row['time_left_val'] < 0) stat_sys[sys_id]['ovd']++;
      }
    });

    var stat_eng_table = [];
    Object.keys(eng_sys_list).forEach(function(eng_id) {
      var eng_name = eng_sys_list[eng_id]['eng_name'];
      var eng_table = [];
      eng_sys_list[eng_id]['systems'].forEach(function(system, i) {
        var key;
        if (stat_eng[eng_id]) {
          for (key in stat_sys[system.sys_id])
            stat_eng[eng_id][key] += stat_sys[system.sys_id][key];
        } else {
          stat_eng[eng_id] = {};
          for (key in stat_sys[system.sys_id])
            stat_eng[eng_id][key] = stat_sys[system.sys_id][key];
        }
      });
      Object.keys(HEADERS).forEach(function(header) {
        eng_table.push(stat_eng[eng_id][header]);
      });
      var row = [eng_name].concat(eng_table);
      stat_eng_table.push(row);
    });

    var stat_sys_table = [];

    Object.keys(sys_eng_list).forEach(function(sys_id) {
      var sys_name = sys_eng_list[sys_id]['sys_name'];
      var sys_table = [];
      Object.keys(HEADERS).forEach(function(header) {
        sys_table.push(stat_sys[sys_id][header]);
      });
      var row = [sys_name].concat(sys_table);
      stat_sys_table.push(row);
    });
    stat_sys_table = stat_sys_table.sort(this.sortList);
    var last_row = ['Всего', 0, 0, 0, 0, 0];
    stat_sys_table.forEach(function(row) {
      for (var i = 1; i < 6; i++) {
        last_row[i] += row[i];
      }
    });
    stat_sys_table.push(last_row);

    this.setState({ stat_sys_table, stat_eng_table, data });
  };

  closeModal = () => {
    this.setState({
      modalIsOpen: false,
      stat_eng_table: null,
      stat_sys_table: null,
      data: null
    });
  };

  //onRadioChange = e => {
  //  var exportIndex = parseInt(e.target.value, 10);
  //  this.setState({ exportIndex: exportIndex });
  //};

  //onExport = () => {
  //  var exportIndex = this.state.exportIndex;
  //  this.props.onExport(exportIndex);
  //  this.setState({ modalIsOpen: false });
  //};
  sortList = (a, b) => {
    if (a[0] < b[0]) return -1;
    if (a[0] > b[0]) return 1;
    return 0;
  };

  render() {
    var data = this.state.data;
    var stat_sys_table = this.state.stat_sys_table;
    var stat_eng_table = this.state.stat_eng_table;
    var table_sys = null;
    var table_eng = null;
    if (this.state.modalIsOpen && stat_sys_table) {
      var stat_sys_header = (
        <tr className="stat_sys_header">
          <td>Система</td>
          <td>Открытых</td>
          <td>Закрытых</td>
          <td>Готовых к проверке</td>
          <td>Просроченных</td>
          <td>Всего</td>
        </tr>
      );
      stat_sys_table = stat_sys_table.map(function(row, i) {
        row = row.map(function(col, j) {
          return <td key={'td-' + j}>{col}</td>;
        });
        return <tr key={'row-' + i}>{row}</tr>;
      });
      table_sys = (
        <div>
          <table>
            <thead>{stat_sys_header}</thead>
            <tbody>{stat_sys_table}</tbody>
          </table>
        </div>
      );
    }
    if (this.state.modalIsOpen && stat_eng_table) {
      var stat_eng_header = (
        <tr className="stat_eng_header">
          <td>Инженер</td>
          <td>Открытых</td>
          <td>Закрытых</td>
          <td>Готовых к проверке</td>
          <td>Просроченных</td>
          <td>Всего</td>
        </tr>
      );
      stat_eng_table = stat_eng_table.map(function(row, i) {
        row = row.map(function(col, j) {
          return <td key={'td-' + j}>{col}</td>;
        });
        return <tr key={'row-' + i}>{row}</tr>;
      });
      table_eng = (
        <div>
          <table>
            <thead>{stat_eng_header}</thead>
            <tbody>{stat_eng_table}</tbody>
          </table>
        </div>
      );
    }

    return (
      <div
        className="dr-statistics-modal info-buttons"
        onClick={this.openModal}
      >
        Статистика
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Статистика рассогласований"
        >
          <button
            className="modal-close-button"
            data-close
            aria-label="Close modal"
            type="button"
            onClick={this.closeModal}
            /*disabled={this.state.isProcessing}*/
            title="Закрыть"
          >
            <span aria-hidden="true">&times;</span>
          </button>
          <div className="dr-statistics">
            <h4>Статистика рассогласований</h4>
            {table_sys}
            {table_eng}
            {/*<button onClick={this.onExport}>Экспорт</button>*/}
            {/*<button onClick={this.closeModal}>Отмена</button>*/}
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = DrStatisticsModal;
