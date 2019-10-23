import React, { PureComponent } from 'react';
import Modal from 'react-modal';
import PropTypes from 'prop-types';
import domtoimage from 'dom-to-image';
import fileDownload from 'js-file-download';

//import DatePicker from 'react-datepicker';
//import 'react-datepicker/dist/react-datepicker.css';

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
  LabelList,
  ResponsiveContainer
} from 'recharts';
const HEADERS = {
  nopn: 'На уточнении',
  new: 'Новые',
  opn: 'Открытые',
  cls: 'Закрытые',
  rdy: 'Готовые к проверке',
  rtn: 'Возвращенные',
  ovd: 'Просроченные',
  tot: 'Всего'
};

const HEADER_COLORS = {
  nopn: '#173F5F',
  rdy: '#20639B',
  opn: '#ED553B',
  cls: '#abd2e6',
  new: '#3CAEA3',
  rtn: '#F6D55C',
  ovd: '#2aa198',
  tot: '#cb4b16'
};

//cls: '#d33682',
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
    eng_id: Object.keys(eng_sys_list)[0],
    initialized: false
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
        nopn: 0,
        new: 0,
        opn: 0,
        cls: 0,
        rdy: 0,
        rtn: 0,
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
          nopn: 0,
          new: 0,
          opn: 0,
          cls: 0,
          rdy: 0,
          rtn: 0,
          ovd: 0,
          tot: 0
        };
      }
      var last_status = row['comments'].slice(-1)[0].status;
      if (last_status == 4) {
        stat_sys[sys_id]['cls']++;
      } else {
        if (last_status == 5) {
          stat_sys[sys_id]['rtn']++;
        } else if (last_status == 1) {
          stat_sys[sys_id]['new']++;
        } else if (last_status == 3) {
          stat_sys[sys_id]['rdy']++;
        } else if (last_status == 2) {
          stat_sys[sys_id]['opn']++;
        } else if (last_status == 0) {
          stat_sys[sys_id]['nopn']++;
        }
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
    stat_eng_table = stat_eng_table.sort(this.sortList);
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
    var last_row = ['Всего', 0, 0, 0, 0, 0, 0, 0, 0];
    stat_sys_table.forEach(function(row) {
      for (var i = 1; i < 9; i++) {
        last_row[i] += row[i];
      }
    });
    stat_sys_table.push(last_row);
    /*Закончил с таблицами и столбчатыми графиками*/
    /*Начал набирать статистику для графиков с зависимостью от времени*/
    var t_min = this.getTMin();
    var numDays = dateToArrayIndex(time_period.date_max, t_min) + 1;

    var stat_sys_date_tot = {};
    var stat_sys_date_dif = {};
    Object.keys(sys_eng_list).forEach(function(key) {
      var t1 = new Date(time_period.date_min);
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
      if (sys_eng_list[sys_id]) {
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
      }
    });
    var stat_eng_date_tot = [];
    var stat_eng_date_dif = [];
    Object.keys(eng_sys_list).forEach(function(eng_id) {
      var eng_name = eng_sys_list[eng_id]['eng_name'];
      var eng_table = [];
      eng_sys_list[eng_id]['systems'].forEach(function(system, i) {
        var key;
        if (stat_eng_date_tot[eng_id]) {
          for (i = 0; i < stat_sys_date_tot[system.sys_id].length; i++) {
            stat_eng_date_tot[eng_id][i].opn +=
              stat_sys_date_tot[system.sys_id][i].opn;
            stat_eng_date_tot[eng_id][i].cls +=
              stat_sys_date_tot[system.sys_id][i].cls;
            stat_eng_date_tot[eng_id][i].rdy +=
              stat_sys_date_tot[system.sys_id][i].rdy;
          }
        } else {
          stat_eng_date_tot[eng_id] = [];
          for (i = 0; i < stat_sys_date_tot[system.sys_id].length; i++) {
            stat_eng_date_tot[eng_id].push(stat_sys_date_tot[system.sys_id][i]);
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
      stat_sys_date_tot,
      stat_eng_date_dif,
      stat_eng_date_tot,
      startDate: new Date(time_period.date_min).toISOString().substr(0, 10),
      minDate: new Date(time_period.date_min).toISOString().substr(0, 10),
      endDate: new Date(time_period.date_max).toISOString().substr(0, 10),
      maxDate: new Date(time_period.date_max).toISOString().substr(0, 10),
      initialized: true
    });
  };

  closeModal = () => {
    this.setState({
      modalIsOpen: false,
      stat_eng_table: null,
      stat_sys_table: null,
      data: null,
      initialized: false
    });
  };

  exportChart = () => {
    var chart_id = this.state.chart_id;
    domtoimage
      .toBlob(document.getElementById('node-to-convert'))
      .then(function(blob) {
        fileDownload(
          blob,
          'DR.' + CHART_SELECTOR[chart_id]['label'].split(' ').join('') + 'png'
        );
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
      return {
        name: row[0],
        nopn: row[1],
        new: row[2],
        opn: row[3],
        cls: row[4],
        rdy: row[5],
        rtn: row[6]
      };
    });
  };

  getTMin = () => {
    var t1 = new Date(time_period.date_min);
    return new Date(t1.getFullYear(), t1.getMonth(), t1.getDate());
  };

  dateToArrayIndex = (date, t_min) => {
    var t2 = new Date(date);
    var t_max = new Date(t2.getFullYear(), t2.getMonth(), t2.getDate());
    return Math.floor((t_max - t_min) / 1000 / 60 / 60 / 24);
  };

  startDateChange = event => {
    if (
      event.target.value >= this.state.minDate &&
      event.target.value <= this.state.maxDate
    ) {
      this.setState({
        startDate: event.target.value
      });
    }
  };

  endDateChange = event => {
    if (
      event.target.value >= this.state.minDate &&
      event.target.value <= this.state.maxDate
    ) {
      this.setState({
        endDate: event.target.value
      });
    }
  };

  getChartData = data => {
    var chart_data = [];
    var tmp_data = [];
    var i1, i2;
    var t_min = this.getTMin();
    i1 = this.dateToArrayIndex(this.state.startDate, t_min);
    i2 = this.dateToArrayIndex(this.state.endDate, t_min);
    for (var i = i1; i <= i2; i++) {
      tmp_data.push(data[i]);
    }
    var l = tmp_data.length;
    if (l > 100) {
      var m = Math.ceil(l / 100);
      for (i = m; i <= l; i += m) {
        chart_data.push(tmp_data[i]);
      }
    } else {
      chart_data = tmp_data;
    }
    return chart_data;
  };

  render() {
    var data = this.state.data;
    var stat_sys_table = this.state.stat_sys_table;
    var stat_eng_table = this.state.stat_eng_table;
    var stat_sys_chart = this.state.stat_sys_chart;
    var stat_eng_chart = this.state.stat_eng_chart;
    var stat_sys_date_tot = this.state.stat_sys_date_tot;
    var stat_sys_date_dif = this.state.stat_sys_date_dif;
    var stat_eng_date_tot = this.state.stat_eng_date_tot;
    var stat_eng_date_dif = this.state.stat_eng_date_dif;
    var table_sys = null;
    var table_eng = null;
    var bar_chart_sys = null;
    var bar_chart_eng = null;
    var line_chart_sys = null;
    var line_chart_eng = null;
    var sys_selector = null;
    var eng_selector = null;
    var date_selector = null;
    var chart_id = this.state.chart_id;
    var chart_data = [];
    var maxopn = 0;
    var maxcls = 0;

    if (this.state.modalIsOpen && stat_sys_table && chart_id == 0) {
      var stat_sys_header = (
        <tr className="stat_sys_header">
          <td>Система</td>
          <td>{HEADERS['nopn']}</td>
          <td>{HEADERS['new']}</td>
          <td>{HEADERS['opn']}</td>
          <td>{HEADERS['cls']}</td>
          <td>{HEADERS['rdy']}</td>
          <td>{HEADERS['rtn']}</td>
          <td>{HEADERS['ovd']}</td>
          <td>{HEADERS['tot']}</td>
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
          <td>{HEADERS['nopn']}</td>
          <td>{HEADERS['new']}</td>
          <td>{HEADERS['opn']}</td>
          <td>{HEADERS['cls']}</td>
          <td>{HEADERS['rdy']}</td>
          <td>{HEADERS['rtn']}</td>
          <td>{HEADERS['ovd']}</td>
          <td>{HEADERS['tot']}</td>
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
          <ResponsiveContainer height="90%" width="100%">
            <BarChart
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
              <Tooltip isAnimationActive={false} />
              <Legend />
              <Bar
                dataKey="cls"
                fill={HEADER_COLORS['cls']}
                name={HEADERS['cls']}
              />
              <Bar
                dataKey="opn"
                stackId="a"
                fill={HEADER_COLORS['opn']}
                name={HEADERS['opn']}
              />
              <Bar
                dataKey="rdy"
                stackId="a"
                fill={HEADER_COLORS['rdy']}
                name={HEADERS['rdy']}
              />
              <Bar
                dataKey="rtn"
                stackId="a"
                fill={HEADER_COLORS['rtn']}
                name={HEADERS['rtn']}
              />
              <Bar
                dataKey="nopn"
                stackId="a"
                fill={HEADER_COLORS['nopn']}
                name={HEADERS['nopn']}
              />
              <Bar
                dataKey="new"
                stackId="a"
                fill={HEADER_COLORS['new']}
                name={HEADERS['new']}
              />
              {/* <Bar dataKey="opn" stackId="a" fill="#8884d8" name="Открытых">
              </Bar>
              <Bar dataKey="cls" stackId="a" fill="#82ca9d" name="Закрытых" /> */}
            </BarChart>
          </ResponsiveContainer>
        </div>
      );
    }
    if (this.state.modalIsOpen && stat_eng_chart && chart_id == 3) {
      bar_chart_eng = (
        <div className="bar-chart-container">
          <ResponsiveContainer height="90%" width="100%">
            <BarChart
              data={stat_eng_chart}
              margin={{
                top: 5,
                right: 5,
                left: 5,
                bottom: 10
              }}
            >
              <CartesianGrid strokeDasharray="3 3" />
              <Tooltip isAnimationActive={false} />
              <Bar
                dataKey="cls"
                fill={HEADER_COLORS['cls']}
                name={HEADERS['cls']}
              />
              <Bar
                dataKey="opn"
                stackId="a"
                fill={HEADER_COLORS['opn']}
                name={HEADERS['opn']}
              />
              <Bar
                dataKey="rdy"
                stackId="a"
                fill={HEADER_COLORS['rdy']}
                name={HEADERS['rdy']}
              />
              <Bar
                dataKey="rtn"
                stackId="a"
                fill={HEADER_COLORS['rtn']}
                name={HEADERS['rtn']}
              />
              <Bar
                dataKey="nopn"
                stackId="a"
                fill={HEADER_COLORS['nopn']}
                name={HEADERS['nopn']}
              />
              <Bar
                dataKey="new"
                stackId="a"
                fill={HEADER_COLORS['new']}
                name={HEADERS['new']}
              />

              <XAxis
                dataKey="name"
                height={100}
                interval={0}
                tick={<CustomizedAxisTick />}
              />
              <YAxis />
              <Legend />
            </BarChart>
          </ResponsiveContainer>
        </div>
      );
    }
    if (this.state.modalIsOpen && stat_sys_date_tot && chart_id == 4) {
      chart_data = this.getChartData(stat_sys_date_tot[this.state.sys_id]);
      line_chart_sys = (
        <div className="bar-chart-container">
          <h4>{sys_eng_list[this.state.sys_id].sys_name}</h4>
          <ResponsiveContainer height="90%" width="100%">
            <LineChart
              data={chart_data}
              margin={{
                top: 5,
                right: 5,
                left: 5,
                bottom: 10
              }}
            >
              <CartesianGrid />
              <Tooltip isAnimationActive={false} />
              <Line
                dataKey="opn"
                stroke={HEADER_COLORS['opn']}
                name={HEADERS['opn']}
                isAnimationActive={false}
              />
              <Line
                dataKey="cls"
                stroke={HEADER_COLORS['rdy']}
                name={HEADERS['cls']}
                isAnimationActive={false}
              />
              <XAxis
                dataKey="date"
                height={100}
                interval={5}
                tick={<CustomizedAxisTick />}
              />

              <YAxis type="number" domain={[0, 100]} allowDecimals={false} />
              <Legend />
            </LineChart>
          </ResponsiveContainer>
        </div>
      );
      var sys_opt = [];
      Object.keys(sys_eng_list).forEach(function(key) {
        sys_opt.push({ value: key, label: sys_eng_list[key].sys_name });
      });
      sys_opt = sys_opt.sort(sortList);
      sys_opt = sys_opt.map(arrayToOpt);

      sys_selector = (
        <div className="system-selector">
          <select
            size={15}
            value={this.state.sys_id}
            onChange={this.onSysChange}
          >
            {sys_opt}
          </select>
        </div>
      );
    }

    line_chart_eng = null;
    if (this.state.modalIsOpen && stat_eng_date_tot && chart_id == 5) {
      chart_data = this.getChartData(stat_eng_date_tot[this.state.eng_id]);
      chart_data.forEach(function(day) {
        if (maxopn < day['opn']) maxopn = day['opn'];
        if (maxcls < day['cls']) maxcls = day['cls'];
      });
      line_chart_eng = (
        <div className="bar-chart-container">
          <h4>{eng_sys_list[this.state.eng_id].eng_name}</h4>
          <ResponsiveContainer height="90%" width="100%">
            <LineChart
              data={chart_data}
              margin={{
                top: 5,
                right: 5,
                left: 5,
                bottom: 10
              }}
            >
              <CartesianGrid />
              <Tooltip isAnimationActive={false} />
              <Line
                dataKey="opn"
                stroke={HEADER_COLORS['opn']}
                name={HEADERS['opn']}
                isAnimationActive={false}
              />
              <Line
                dataKey="cls"
                stroke={HEADER_COLORS['rdy']}
                name={HEADERS['cls']}
                isAnimationActive={false}
              />
              <XAxis
                dataKey="date"
                height={100}
                interval={5}
                tick={<CustomizedAxisTick />}
              />
              <YAxis type="number" domain={[0, 100]} allowDecimals={false} />
              <Legend />
            </LineChart>
          </ResponsiveContainer>
        </div>
      );

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
    if (this.state.initialized && ['4', '5', '6'].indexOf(chart_id) !== -1) {
      date_selector = (
        <div className="date-selector">
          <label>Начало диапазона:</label>
          <input
            type="date"
            value={this.state.startDate}
            onChange={this.startDateChange}
            required={true}
            min={this.state.minDate}
            max={this.state.maxDate}
          />
          <label>Конец диапазона:</label>
          <input
            type="date"
            value={this.state.endDate}
            onChange={this.endDateChange}
            required={true}
            min={this.state.minDate}
            max={this.state.maxDate}
          />
        </div>
      );
    }
    var chart_opt = CHART_SELECTOR.map(arrayToOpt);
    var chart_selector = (
      <div className="chart-selector">
        <select
          size={6}
          value={this.state.chart_id}
          onChange={this.onChartChange}
        >
          {chart_opt}
        </select>
      </div>
    );

    return (
      <div
        className="dr-statistics-modal info-buttons"
        onClick={this.openModal}
        title="Статистика по DR"
      >
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
          <button
            className="modal-save-button"
            onClick={this.exportChart}
            title="Сохранить в PNG"
          />

          <div className="dr-statistics" id="node-to-convert">
            <h4>Статистика рассогласований</h4>
            <div className="dr-stat-list">
              {chart_selector}
              {sys_selector}
              {eng_selector}
              {date_selector}
            </div>
            <div className="dr-stat-draw">
              {table_sys}
              {table_eng}
              {bar_chart_sys}
              {bar_chart_eng}
              {line_chart_sys}
              {line_chart_eng}
            </div>
            {/*<button onClick={this.closeModal}>Отмена</button>
              <button onClick={this.onExport}>Экспорт</button>*/}
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = DrStatisticsModal;
