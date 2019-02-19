import React from 'react';
import PropTypes from 'prop-types';
import Modal from 'react-modal';
//import MOD from 'ruby_constants.js.erb'
//import VARIABLES from 'ruby_constants.js.erb'
//import ATTRIBUTE_LIST from 'ruby_constants.jsx.haml'
import XLSX from 'xlsx';

var getSelectorOptions = require('../selectors/selectors.jsx')
  .getSelectorOptions;

const MOD = ['MDD', 'ADD', 'OMOD'];
//const MOD = ruby_constants.MOD;
const VARIABLES = [
  'Дистанционное управление',
  'Отказы',
  'Оборудование',
  'Системы отображения',
  'Анонсиаторы'
];
const SEL_PATH = [
  '/selectors/dbm_sys_rfs',
  '/selectors/dbm_sys_mfs',
  '/selectors/dbm_tbl_ics'
];
const WARN_MESSAGES = [
  'RF без заданной системы.',
  'отказы без заданной системы.',
  'I&C без определенного типа оборудования (посредством PED).'
];
const CHECK_KEYS = ['ref', 'tag_no', 'tbl', 'sig', 'lvl', 'sys'];
const CHECK_HEADERS = [
  'Переменная',
  'REF',
  'KKS',
  'Таблица',
  'Сигнал',
  'Уровень',
  'Сист.'
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

class GenerateDbm extends React.Component {
  constructor() {
    super();

    this.state = {
      modalIsOpen: false,
      modIndex: 0,
      varIndex: 0,
      predecessor: 'globalyp',
      systems_all: false,
      systems_none: true,
      systems_warn: { na: false, all: false, empty: false },
      gen_tag: true,
      log_as_table: false,
      isProcessing: false,
      log: '',
      systems: []
    };
  }

  openModal = () => {
    this.setState({
      varIndex: 0,
      modalIsOpen: true
    });
    //this.refreshSystems(0);
  };

  refreshLog = () => {
    var _this = this;
    const ajaxcall = _this => {
      $.ajax({
        url: '/get_log',
        dataType: 'json',
        type: 'PUT',
        success: function(responce) {
          _this.setState({
            log: responce.log.split('\\n').join('\r\n'),
            log_as_table: false
          });
        },
        error: function(xhr, status, err) {
          //console.error(_this.props.url, status, err.toString());
        },
        async: true
      });
    };
    ajaxcall(this);
    do {
      setTimeout(function() {
        ajaxcall(_this);
      }, 1000);
    } while (this.state.isProcessing);
  };

  afterOpenModal = () => {
    // references are now sync'd and can be accessed.
    this.setState({ varIndex: 0 });
    this.refs.subtitle.style.color = '#0081c2';
    this.refreshSystems(0);
  };

  refreshSystems = varIndex => {
    var systems;
    if ([0, 1, 2].includes(varIndex)) {
      systems = getSelectorOptions(
        SEL_PATH[varIndex],
        { pds_project_id: project.ProjectID },
        this
      );
      var systems_warn = { na: false, all: false, empty: false };

      systems = systems.map(sys => {
        if (sys.value == null) {
          systems_warn.empty = true;
        }
        sys.isChecked = false;
        return sys;
      });

      if ([0, 1].includes(varIndex)) {
        systems = systems.map(sys => {
          if (sys.value == 20000001) {
            systems_warn.na = true;
          }
          if (sys.value == 34) {
            systems_warn.all = true;
          }
          return sys;
        });
        systems = systems.filter(x => {
          return ![20000001, 34, null].includes(x.value);
        });
      } else if (varIndex == 2) {
        systems = systems.filter(x => {
          return ![47, null].includes(x.value);
        });
      }
      this.setState({
        systems_all: false,
        systems_none: true,
        systems_warn: systems_warn,
        gen_tag: true,
        systems: systems
      });
    } else if (varIndex == 4) {
      systems = [{ value: 4, isChecked: true }];
      this.setState({
        gen_tag: false,
        systems_warn: { na: false, all: false, empty: false },
        systems_all: false,
        systems_none: false,
        systems: systems //announciators
      });
    } else {
      systems = [
        { value: 51, label: 'Аналоговые точки контроля', isChecked: true },
        { value: 52, label: 'Дискретные точки контроля', isChecked: true }
      ];
      this.setState({
        gen_tag: false,
        systems_warn: { na: false, all: false, empty: false },
        systems_all: true,
        systems_none: false,
        systems: systems //ppc
      });
    }
  };

  closeModal = () => {
    this.setState({ modalIsOpen: false });
  };

  onModRadioChange = e => {
    var modIndex = parseInt(e.target.value, 10);
    this.setState({ modIndex: modIndex });
  };

  onVarRadioChange = e => {
    var varIndex = parseInt(e.target.value, 10);
    this.setState({ varIndex: varIndex });
    this.refreshSystems(varIndex);
  };

  onPredecessorChange = e => {
    this.setState({ predecessor: e.target.value });
  };

  onSysCheckChange = e => {
    var systems = this.state.systems;
    var l_all = true;
    var l_some = false;
    systems = systems.map(sys => {
      if (sys.label == e.target.value) {
        sys.isChecked = !sys.isChecked;
      }
      l_all = l_all && sys.isChecked;
      l_some = l_some || sys.isChecked;
      return sys;
    });
    this.setState({
      systems: systems,
      systems_all: l_all,
      systems_none: !l_some
    });
  };

  onSysAllChange = () => {
    var systems = this.state.systems;
    var systems_all = !this.state.systems_all;
    systems = systems.map(sys => {
      sys.isChecked = systems_all;
      return sys;
    });
    this.setState({
      systems: systems,
      systems_all: systems_all,
      systems_none: !systems_all
    });
  };

  onGenTagChange = () => {
    var gen_tag = !this.state.gen_tag;
    this.setState({
      gen_tag: gen_tag
    });
  };

  onExport = () => {
    if (!this.state.systems_none) {
      var _this = this;
      var systems = [];
      this.state.systems.forEach(function(sys) {
        if (sys.isChecked) systems.push(sys.value);
      });
      $.ajax({
        url: '/generate_dbm_sel',
        dataType: 'json',
        type: 'PUT',
        data: {
          data: {
            mod: MOD[this.state.modIndex],
            gen_type: this.state.varIndex,
            predecessor: this.state.predecessor,
            systems: systems,
            systems_all: this.state.systems_all,
            gen_tag: this.state.gen_tag,
            project_id: project.id
          }
        },

        success: function(data) {
          _this.setState({ isProcessing: false });
          _this.refreshLog();
        },
        error: function(xhr, status, err) {
          //console.error(_this.props.url, status, err.toString());
          _this.setState({ isProcessing: false });
          _this.refreshLog();
        },
        async: true
      });
      this.setState({ isProcessing: true });
      this.refreshLog();
    } else {
      if (this.state.varIndex == 2) {
        alert('Выберите типы оборудования для генерации селект-файлов!');
      } else if (this.state.varIndex == 3) {
        alert('Выберите системы отображения для генерации селект-файлов!');
      } else {
        alert('Выберите системы для генерации селект-файлов!');
      }
    }
  };

  onExportXls = () => {
    var new_data = [];
    var hash = {};

    this.state.log.forEach(function(arr, i) {
      arr['info'].forEach(function(row, j) {
        hash = {};
        hash[CHECK_HEADERS[0]] = arr['var_name'];
        CHECK_KEYS.forEach(function(key, k) {
          hash[CHECK_HEADERS[k + 1]] = row[key];
        });
        new_data.push(hash);
      });
    });
    var bookname = 'check_tags_' + project.id + '.xls';
    var wb = XLSX.utils.book_new();
    var ws = XLSX.utils.json_to_sheet(new_data);
    XLSX.utils.book_append_sheet(wb, ws, 'Провека PED');
    XLSX.writeFile(wb, bookname, { bookType: 'biff8' });
  };

  onCheckPeds = () => {
    var _this = this;
    var systems = [];
    this.state.systems.forEach(function(sys) {
      systems.push(sys.value);
    });
    $.ajax({
      url: '/generate_dbm_check_tags',
      dataType: 'json',
      type: 'PUT',
      data: {
        data: {
          gen_type: this.state.varIndex,
          systems: systems,
          project_id: project.id
        }
      },

      success: function(responce) {
        _this.setState({ isProcessing: false });
        if (responce.log.length > 0) {
          _this.setState({
            //log: responce.log.split('\\n').join('\r\n'),
            log: responce.log,
            log_as_table: true
          });
        } else {
          _this.setState({
            log: 'Проверка завершена. Проблем не обнаружено.',
            log_as_table: false
          });
        }
      },
      error: function(xhr, status, err) {
        //console.error(_this.props.url, status, err.toString());
        _this.setState({ isProcessing: false });
        _this.setState({
          log: 'Ошибка при проверке. Обратитесь к разработчику',
          log_as_table: false
        });
      },
      async: true
    });
    this.setState({ isProcessing: true });
    _this.setState({
      log: 'Начата проверка. Ждите...',
      log_as_table: false
    });
  };

  render() {
    var this_ = this;
    const systems = this.state.systems;
    var sys_check_group_label = '';
    var none_label = '';
    if (this.state.varIndex == 2) {
      sys_check_group_label = 'Типы оборудования:';
      none_label = 'Ни одного типа оборудования';
    } else if (this.state.varIndex == 3) {
      sys_check_group_label = 'Системы отображения:';
      none_label = 'Ни одной системы отображения';
    } else {
      sys_check_group_label = 'Системы:';
      none_label = 'Ни одной системы';
    }

    const mod_radio_group = MOD.map((data, idx) => (
      <p key={'mod-radio-group-key' + idx}>
        <input
          type="radio"
          value={idx}
          checked={this_.state.modIndex === idx}
          onChange={this_.onModRadioChange}
          disabled={this.state.isProcessing}
        />{' '}
        {data}
        <br />
      </p>
    ));

    const var_radio_group = VARIABLES.map((data, idx) => (
      <p key={'var-radio-group-key' + idx}>
        <input
          type="radio"
          value={idx}
          checked={this_.state.varIndex === idx}
          onChange={this_.onVarRadioChange}
          disabled={this.state.isProcessing}
        />{' '}
        {VARIABLES[idx]}
        <br />
      </p>
    ));

    const sys_check_group = (
      <div className="generate-dbm-systems">
        <label>{sys_check_group_label}</label>
        <br />
        {systems.map((data, idx) => (
          <label key={'sys-check-group-key' + idx}>
            <input
              type="checkbox"
              value={data.label}
              checked={data.isChecked}
              onChange={this_.onSysCheckChange}
              disabled={this.state.isProcessing}
            />{' '}
            {data.label}
          </label>
        ))}
        <br />
      </div>
    );

    const gen_tag_checkbox = (
      <label>
        <input
          type="checkbox"
          checked={this.state.gen_tag}
          onChange={this.onGenTagChange}
          disabled={this.state.isProcessing}
        />{' '}
        Генерировать TAG
      </label>
    );

    const sys_all_checkbox = (
      <label className="generate-dbm-sys-all">
        <input
          type="checkbox"
          checked={this.state.systems_all}
          onChange={this.onSysAllChange}
          disabled={this.state.isProcessing}
        />{' '}
        Выбрать все
      </label>
    );

    const sys_warn_all = this.state.systems_warn.all ? (
      <label className="generate-dbm-warn">
        Система ALL исключена из генерации
      </label>
    ) : (
      <div />
    );
    const sys_warn_na = this.state.systems_warn.na ? (
      <label className="generate-dbm-warn">
        Система N/A исключена из генерации
      </label>
    ) : (
      <div />
    );
    const sys_warn_empty = this.state.systems_warn.empty ? (
      <div>
        <label className="generate-dbm-warn">
          Присутствуют {WARN_MESSAGES[this.state.varIndex]} Они исключены из
          генерации.
        </label>
      </div>
    ) : (
      <div />
    );
    const sys_none_label = this.state.systems_none ? (
      <label className="generate-dbm-err">{none_label} не выбрано!</label>
    ) : (
      <div />
    );

    const sys_container = (
      <div className="generate-dbm-sys-container">
        {[0, 1, 2, 3].includes(this.state.varIndex) ? (
          <div>
            {sys_check_group}
            {sys_all_checkbox}
            {sys_none_label}
            {sys_warn_all}
            {sys_warn_na}
            {sys_warn_empty}
          </div>
        ) : (
          <div />
        )}
      </div>
    );

    const check_tags_button =
      this.state.varIndex == 2 ? (
        <div className="generate-dbm-check-peds generate-dbm-top">
          <button onClick={this.onCheckPeds} disabled={this.state.isProcessing}>
            Проверить TAG
          </button>
        </div>
      ) : (
        <div />
      );

    const predecessor_input = (
      <input
        type="text"
        name="predecessor"
        value={this_.state.predecessor}
        onChange={this_.onPredecessorChange}
        disabled={this.state.isProcessing}
      />
    );

    const rf_container = (
      <div className="generate-dbm-rf-container">
        {[0].includes(this.state.varIndex) ? (
          <div>{predecessor_input}</div>
        ) : (
          <div />
        )}
        {[2].includes(this.state.varIndex) ? (
          <div>{gen_tag_checkbox}</div>
        ) : (
          <div />
        )}
      </div>
    );

    var rows = null;
    var log_container;
    if (this.state.log_as_table) {
      var tbl_header = CHECK_HEADERS.map(function(key, k) {
        return <th key={'header' + k + '-cell'}>{CHECK_HEADERS[k]}</th>;
      });
      rows = this.state.log.map(function(row, i) {
        var row_info = row['info'].map(function(row2, j) {
          var cells = CHECK_KEYS.map(function(key, k) {
            return <td key={i + '-' + j + '-' + k + '-cell'}>{row2[key]}</td>;
          });
          var row_var_name =
            j == 0 ? (
              <td rowSpan={row['info'].length}>{row['var_name']}</td>
            ) : null;
          var row_together = (
            <tr>
              {row_var_name}
              {cells}
            </tr>
          );
          return row_together;
        });
        return row_info;
      });
      log_container = (
        <table>
          <tbody>
            <tr>{tbl_header}</tr>
            {rows}
          </tbody>
        </table>
      );
    } else {
      log_container = <textarea value={this.state.log} readOnly />;
    }

    return (
      <div className="generate-dbm-modal">
        <a onClick={this.openModal}>
          <div className="header-icon" />
          Генерация
        </a>

        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          style={customStyles}
          contentLabel="Свойства экспорта в файл"
        >
          <button
            className="modal-close-button"
            data-close
            aria-label="Close modal"
            type="button"
            onClick={this.closeModal}
            disabled={this.state.isProcessing}
            title="Закрыть"
          >
            <span aria-hidden="true">&times;</span>
          </button>

          <div className="generate-dbm">
            <div className="generate-dbm-all">
              <h2 ref="subtitle">
                Настройки создания SELECT файла и заполнения DBM
              </h2>
              <div>
                <div className="generate-dbm-top">
                  {mod_radio_group}
                  {rf_container}
                </div>
                <div className="generate-dbm-top">{var_radio_group}</div>
              </div>
              {sys_container}
              {check_tags_button}
            </div>
            <div className="generate-dbm-top generate-dbm-run">
              <button
                onClick={this.onExport}
                disabled={this.state.isProcessing}
              >
                Генерировать селект-файлы
              </button>
            </div>
            <div className="generate-dbm-top">
              <button
                onClick={this.onExportXls}
                disabled={this.state.isProcessing}
                title="Экспорт в XLS"
                className={
                  'generate-dbm-xls-button' +
                  (this.state.log_as_table ? '' : ' hidden-element')
                }
              />
            </div>
            <div className="generate-dbm-log">{log_container}</div>
          </div>
        </Modal>
      </div>
    );
  }
}

module.exports = GenerateDbm;
