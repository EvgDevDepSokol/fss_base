import React, { PureComponent } from 'react';
import Modal from 'react-modal';
import PropTypes from 'prop-types';
import { prepareRow, sortList, arrayToOpt } from './dr_data.jsx';
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  LabelList
} from 'recharts';
const HEADERS = {
  opn: 'Открытых',
  cls: 'Закрытых',
  rdy: 'Готовых к проверке',
  ovd: 'Просроченных',
  tot: 'Всего'
};
const CHART_SELECTOR = [
  { value: 0, label: 'Таблица. Системы.' },
  { value: 1, label: 'Таблица. Инженеры.' },
  { value: 2, label: 'Гистограмма. Системы.' },
  { value: 3, label: 'Гистограмма. Инженеры.' },
  { value: 4, label: 'График. Системы.' },
  { value: 5, label: 'График. Инженеры.' }
];

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

class CustomizedAxisTick extends PureComponent {
  static propTypes = {
    x: PropTypes.number,
    y: PropTypes.number,
    stroke: PropTypes.string,
    payload: PropTypes.object
  };
  render() {
    const { x, y, stroke, payload } = this.props;
    return (
      <g transform={`translate(${x},${y})`}>
        <text
          x={0}
          y={0}
          dy={16}
          textAnchor="end"
          fill="#666"
          transform="rotate(-35)"
        >
          {payload.value}
        </text>
      </g>
    );
  }
}

class DrStatisticsModal extends React.Component {
  static displayName = 'DrStatisticsModal';
  state = {
    modalIsOpen: false,
    exportIndex: 0,
    chart_id: 0,
    sys_id: Object.keys(sys_eng_list)[0],
    eng_id: Object.keys(eng_sys_list)[0]
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
    var dateToArrayIndex = this.dateToArrayIndex;
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

    /*Таблица и столбчатый график по инженерам*/
    var stat_eng_table = [];
    var stat_eng_chart = [];

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
    stat_eng_chart = this.tableToChart(stat_eng_table);

    /*Таблица и столбчатый график по системам*/
    var stat_sys_table = [];
    var stat_sys_chart = [];

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
    stat_sys_chart = this.tableToChart(stat_sys_table);
    var last_row = ['Всего', 0, 0, 0, 0, 0];
    stat_sys_table.forEach(function(row) {
      for (var i = 1; i < 6; i++) {
        last_row[i] += row[i];
      }
    });
    stat_sys_table.push(last_row);
    /*Закончил с таблицами и столбчатыми графиками*/
    /*Начал набирать статистику для графиков с зависимостью от времени*/
    var t1 = new Date(time_period.date_min);
    var t_min = new Date(t1.getFullYear(), t1.getMonth(), t1.getDate());
    var numDays = dateToArrayIndex(time_period.date_max, t_min) + 1;

    var stat_sys_date_tot = {};
    var stat_sys_date_dif = {};
    Object.keys(sys_eng_list).forEach(function(key) {
      t1 = new Date(time_period.date_min);
      stat_sys_date_tot[key] = [];
      stat_sys_date_dif[key] = [];
      for (var i = 0; i < numDays; i++) {
        stat_sys_date_tot[key].push({
          day: i,
          date:
            t1.getFullYear() + '-' + (t1.getMonth() + 1) + '-' + t1.getDate(),
          opn: 0,
          cls: 0,
          rdy: 0
        });
        stat_sys_date_dif[key].push({
          day: i,
          date:
            t1.getFullYear() + '-' + (t1.getMonth() + 1) + '-' + t1.getDate(),
          opn: 0,
          cls: 0,
          rdy: 0
        });
        t1.setDate(t1.getDate() + 1);
      }
    });

    var data_chart = [];

    data.forEach(function(dr) {
      var sys_id = dr.system.id;
      var com_arr = dr.comments.map(function(comment, j) {
        var ind = dateToArrayIndex(comment.comment_date, t_min);
        return { i_start: ind, status: comment.status };
      });
      var len = com_arr.length - 1;
      var i;
      for (i = 0; i < len; i++) {
        com_arr[i]['i_finish'] = com_arr[i + 1]['i_start'];
      }
      com_arr[len]['i_finish'] = numDays;
      com_arr.forEach(function(com) {
        var st = com.status;
        if (st == 4) {
          stat_sys_date_dif[sys_id][com.i_start].cls++;
          for (i = com.i_start; i < com.i_finish; i++) {
            stat_sys_date_tot[sys_id][i].cls++;
          }
        } else {
          if (st == 3) {
            stat_sys_date_dif[sys_id][com.i_start].rdy++;
          } else if (st == 6 || st == 1) {
            stat_sys_date_dif[sys_id][com.i_start].opn++;
          }
          for (i = com.i_start; i < com.i_finish; i++) {
            stat_sys_date_tot[sys_id][i].opn++;
          }
        }
      });
    });

    this.setState({
      stat_sys_table,
      stat_eng_table,
      data,
      stat_sys_chart,
      stat_eng_chart,
      stat_sys_date_dif,
      stat_sys_date_tot
    });
  };

  closeModal = () => {
    this.setState({
      modalIsOpen: false,
      stat_eng_table: null,
      stat_sys_table: null,
      data: null
    });
  };

  onSysChange = function(event) {
    var sys_id = event.target.value;
    this.setState({ sys_id });
  }.bind(this);
  onEngChange = function(event) {
    var eng_id = event.target.value;
    this.setState({ eng_id });
  }.bind(this);
  onChartChange = function(event) {
    var chart_id = event.target.value;
    this.setState({ chart_id });
  }.bind(this);

  tableToChart = table => {
    return table.map(function(row, i) {
      return { name: row[0], opn: row[1], cls: row[2] };
    });
  };

  dateToArrayIndex = (date, t_min) => {
    var t2 = new Date(date);
    var t_max = new Date(t2.getFullYear(), t2.getMonth(), t2.getDate());
    return Math.floor((t_max - t_min) / 1000 / 60 / 60 / 24);
  };

  render() {
    var data = this.state.data;
    var stat_sys_table = this.state.stat_sys_table;
    var stat_eng_table = this.state.stat_eng_table;
    var stat_sys_chart = this.state.stat_sys_chart;
    var stat_eng_chart = this.state.stat_eng_chart;
    var stat_sys_date_tot = this.state.stat_sys_date_tot;
    var stat_sys_date_dif = this.state.stat_sys_date_dif;
    var table_sys = null;
    var table_eng = null;
    var bar_chart_sys = null;
    var bar_chart_eng = null;
    var line_chart_sys = null;
    var sys_selector = null;
    var eng_selector = null;
    var chart_id = this.state.chart_id;
    var chart_data = [];
    if (this.state.modalIsOpen && stat_sys_table && chart_id == 0) {
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
    if (this.state.modalIsOpen && stat_eng_table && chart_id == 1) {
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
    if (this.state.modalIsOpen && stat_sys_chart && chart_id == 2) {
      bar_chart_sys = (
        <div className="bar-chart-container">
          <BarChart
            width={1000}
            height={500}
            data={stat_sys_chart}
            margin={{
              top: 5,
              right: 5,
              left: 5,
              bottom: 10
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Bar dataKey="opn" stackId="a" fill="#8884d8" name="Открытых">
              {/*<LabelList dataKey="opn" position="Top" />*/}
            </Bar>
            <Bar dataKey="cls" stackId="a" fill="#82ca9d" name="Закрытых" />
          </BarChart>
        </div>
      );
    }
    if (this.state.modalIsOpen && stat_eng_chart && chart_id == 3) {
      bar_chart_eng = (
        <div className="bar-chart-container">
          <BarChart
            width={1000}
            height={500}
            data={stat_eng_chart}
            margin={{
              top: 5,
              right: 5,
              left: 5,
              bottom: 10
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <Tooltip />
            <Bar dataKey="opn" fill="#8884d8" name="Открытых" />
            {/*<Bar dataKey="cls" fill="#82ca9d" name="Закрытых" />*/}
            <XAxis
              dataKey="name"
              height={100}
              interval={0}
              tick={<CustomizedAxisTick />}
            />
            <YAxis />
            <Legend />
          </BarChart>
        </div>
      );
    }
    if (this.state.modalIsOpen && stat_sys_date_tot && chart_id == 4) {
      var l = stat_sys_date_tot[this.state.sys_id].length;
      if (l > 100) {
        var m = Math.ceil(l / 100);
        for (var i = m; i < l; i += m) {
          chart_data.push(stat_sys_date_tot[this.state.sys_id][i]);
        }
      } else {
        chart_data = stat_sys_date_tot[this.state.sys_id];
      }
      line_chart_sys = (
        <div className="bar-chart-container">
          <LineChart
            width={1000}
            height={500}
            data={chart_data}
            margin={{
              top: 5,
              right: 5,
              left: 5,
              bottom: 10
            }}
          >
            <CartesianGrid />
            <Tooltip />
            <Line
              dataKey="opn"
              stroke="#8884d8"
              name="Открытых"
              isAnimationActive={false}
            />
            <Line
              dataKey="cls"
              stroke="#82ca9d"
              name="Закрытых"
              isAnimationActive={false}
            />
            <XAxis
              dataKey="date"
              height={100}
              interval={5}
              tick={<CustomizedAxisTick />}
            />

            <YAxis />
            <Legend />
          </LineChart>
        </div>
      );
      var sys_opt = [];
      Object.keys(sys_eng_list).forEach(function(key) {
        sys_opt.push({ value: key, label: sys_eng_list[key].sys_name });
      });
      sys_opt = sys_opt.sort(sortList);
      sys_opt = sys_opt.map(arrayToOpt);

      sys_selector = (
        <select size={15} value={this.state.sys_id} onChange={this.onSysChange}>
          {sys_opt}
        </select>
      );
    }

    if (this.state.modalIsOpen && stat_sys_date_tot && chart_id == 5) {
      var eng_opt = [];
      Object.keys(eng_sys_list).forEach(function(key) {
        eng_opt.push({ value: key, label: eng_sys_list[key].eng_name });
      });
      eng_opt = eng_opt.sort(sortList);
      eng_opt = eng_opt.map(arrayToOpt);
      eng_selector = (
        <select size={15} value={this.state.eng_id} onChange={this.onEngChange}>
          {eng_opt}
        </select>
      );
    }
    var chart_opt = CHART_SELECTOR.map(arrayToOpt);
    var chart_selector = (
      <select
        size={6}
        value={this.state.chart_id}
        onChange={this.onChartChange}
      >
        {chart_opt}
      </select>
    );

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
            <div className="dr-stat-list">
              {chart_selector}
              {sys_selector}
              {eng_selector}
            </div>
            <div className="dr-stat-draw">
              {table_sys}
              {table_eng}
              {bar_chart_sys}
              {bar_chart_eng}
              {line_chart_sys}
            </div>
            {/*<button onClick={this.onExport}>Экспорт</button>*/}
            {/*<button onClick={this.closeModal}>Отмена</button>*/}
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = DrStatisticsModal;
