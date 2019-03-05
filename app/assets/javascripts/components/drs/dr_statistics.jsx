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
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
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
        stat_sys[sys_id]['tot'] += 1;
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
    this.setState({ stat_sys, data });
  };

  closeModal = () => {
    this.setState({ modalIsOpen: false, stat_sys: null, data: null });
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

  render() {
    var data = this.state.data;
    var stat_sys = this.state.stat_sys;
    var table1 = null;
    if (this.state.modalIsOpen && stat_sys) {
      var stat_sys_table = [];
      var header = (
        <tr className="header">
          <td>Система</td>
          <td>Открытых</td>
          <td>Закрытых</td>
          <td>Готовых к проверке</td>
          <td>Просроченных</td>
          <td>Всего</td>
        </tr>
      );

      //Object.keys(stat_sys).forEach(function(key) {
      Object.keys(sys_eng_list).forEach(function(key) {
        //var sys_name = <td key="td-sys">{sys_eng_list[key]['sys_name']}</td>;
        var sys_name = sys_eng_list[key]['sys_name'];
        var sys_table = [];
        Object.keys(HEADERS).forEach(function(header, i) {
          sys_table.push(stat_sys[key][header]);
          //sys_table.push(<td key={'td-' + i}>{stat_sys[key][header]}</td>);
        });
        //var row = <tr key={'row' + key}>{[sys_name, sys_table]}</tr>;
        var row = [sys_name].concat(sys_table);
        stat_sys_table.push(row);
      });
      debugger;
      stat_sys_table = stat_sys_table.sort(function(a, b) {
        if (a[0] < b[0]) return -1;
        if (a[0] > b[0]) return 1;
        return 0;
      });
      stat_sys_table = stat_sys_table.map(function(row, i) {
        row = row.map(function(col, j) {
          return <td key={'td-' + j}>{col}</td>;
        });
        return <tr key={'row-' + i}>{row}</tr>;
      });
      table1 = (
        <div>
          <table>
            <thead>{header}</thead>
            <tbody>{stat_sys_table}</tbody>
          </table>
        </div>
      );
    }

    return (
      <div className="dr-statistics info-buttons" onClick={this.openModal}>
        Статистика
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Статистика рассогласований"
        >
          <h4>Статистика рассогласований</h4>
          {table1}
          {/*<button onClick={this.onExport}>Экспорт</button>*/}
          <button onClick={this.closeModal}>Отмена</button>
        </Modal>
      </div>
    );
  }
}

module.exports = DrStatisticsModal;
