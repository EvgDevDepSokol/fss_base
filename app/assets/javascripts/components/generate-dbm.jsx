import React from 'react';
import PropTypes from 'prop-types';
import Modal from 'react-modal';
//import MOD from 'ruby_constants.js.erb'
//import VARIABLES from 'ruby_constants.js.erb'
//import ATTRIBUTE_LIST from 'ruby_constants.jsx.haml'
//import DELIMETER from 'ruby_constants.js.erb'

var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

const MOD = ['MDD', 'ADD', 'OMOD'];
//const MOD = ruby_constants.MOD;
const VARIABLES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announciator', 'time step', 'valves', 'power sections'];
const DELIMITER = [',', ';'];
const SEL_PATH = ['/selectors/dbm_sys_rfs','/selectors/dbm_sys_mfs'];

const customStyles = {
  content: {
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
      delIndex: 0,
      predecessor: 'globalyp',
      systems_all: false,
      systems_none: true,
      systems_warn: {na: false, all: false},
      systems:[]
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.onExport = this.onExport.bind(this);
    this.onModRadioChange = this.onModRadioChange.bind(this);
    this.onVarRadioChange = this.onVarRadioChange.bind(this);
    this.onDelimiterSelectorChange = this.onDelimiterSelectorChange.bind(this);
    this.onSysCheckChange = this.onSysCheckChange.bind(this);
    this.onSysAllChange = this.onSysAllChange.bind(this);
    this.onPredecessorChange = this.onPredecessorChange.bind(this);
    this.refreshSystems = this.refreshSystems.bind(this);
  }

  openModal() {
    this.setState({
      varIndex: 0,
      modalIsOpen: true});
    this.refreshSystems(0);
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.setState({varIndex: 0});
    this.refs.subtitle.style.color = '#0081c2';
    this.refreshSystems(0);
  }

  refreshSystems(varIndex){
    if (varIndex < 2) {
      var systems = getSelectorOptions(
        SEL_PATH[varIndex],
        {pds_project_id:project.ProjectID},
        this
      );
      var systems_warn = {na: false, all: false};
      debugger
      systems = systems.map((sys) => {
        if(sys.value==20000001) {
          systems_warn.na = true;
        }
        if(sys.value==34) {
          systems_warn.all = true;
        }
      return sys});
     
      systems = systems.filter(x => {return !([20000001,34].includes(x.value))})
      this.setState({
        systems_all: false,
        systems_none: true,
        systems_warn: systems_warn,
        systems: systems
      });
    }
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  onModRadioChange(e) {
    var modIndex = parseInt(e.target.value, 10);
    this.setState({modIndex: modIndex})
  }

  onVarRadioChange(e) {
    var varIndex = parseInt(e.target.value, 10);
    this.setState({varIndex: varIndex})
    this.refreshSystems(varIndex);
  }

  onDelimiterSelectorChange(e) {
    var delIndex = parseInt(e.target.value, 10);
    this.setState({delIndex: delIndex})
  }

  onPredecessorChange(e) {
    this.setState({predecessor: e.target.value})
  }

  onSysCheckChange(e) {
    var systems = this.state.systems;
    var l_all = true;
    var l_some = false;
    systems = systems.map((sys) => {
      if(sys.label==e.target.value) {
        sys.isChecked = !sys.isChecked;
      }
      l_all = l_all && sys.isChecked;
      l_some = l_some || sys.isChecked;
      return sys});
    this.setState({
      systems: systems,
      systems_all: l_all,
      systems_none: !l_some
    });
  }

  onSysAllChange(e) {
    var systems = this.state.systems;
    var systems_all = !this.state.systems_all
    systems = systems.map((sys) => {
      sys.isChecked = systems_all;
      return sys});
    this.setState({
      systems: systems,
      systems_all: systems_all,
      systems_none: !systems_all,
    });
  }

  onExport() {
    if (!([0,1].includes(this.state.varIndex)&&this.state.systems_none)){
      var systems = [];
      this.state.systems.forEach(function(sys) {
        if (sys.isChecked) systems.push(sys.value)
      });
      $.ajax(
      {
        url: '/generate_rf',
        dataType: 'json',
        type: 'PUT',
        data:
        {
          data: {
            mod: MOD[this.state.modIndex],
            delimiter: DELIMITER[this.state.delIndex],
            type: this.state.varIndex,
            predecessor: this.state.predecessor,
            systems: systems,
            systems_all: this.state.systems_all,
            project_id: project.id
          },
        },

        success: function (data)
        {
          data = data;
        },
        error: function (xhr, status, err)
        {
          console.error(this.props.url, status, err.toString());
          data = [];
        },
        async: false
      });
      this.setState({modalIsOpen: false});
    } else {
      alert('Выберите системы для генерации селект-файлов!');
    }
  }

  render() {
    var this_ = this;
    const systems = this.state.systems;

    const mod_radio_group = MOD.map((data,idx) =>
      <p key={'mod-radio-group-key'+idx}>
        <input type='radio' value={idx} checked={this_.state.modIndex === idx} onChange={this_.onModRadioChange} /> {data}<br/>
      </p>
    );

    const var_radio_group = VARIABLES.map((data,idx) =>
      <p key={'var-radio-group-key'+idx}>
        <input  type='radio' value={idx} checked={this_.state.varIndex === idx} onChange={this_.onVarRadioChange} /> {VARIABLES[idx]}<br/>
      </p>
    );
    
    const delimiter_select = <select value={this_.state.delIndex} onChange={this_.onDelimiterSelectorChange}>
      {DELIMITER.map((option,i) =>
        <option key={i + '-opt'} value={i}>
          {option}
        </option>
      )};
    </select>

    const sys_check_group = <div>
      <label>Системы</label><br/>
      {systems.map((data,idx) =>
        <label key={'sys-check-group-key'+idx}>
          <input  type='checkbox' value={data.label} checked={data.isChecked} onChange={this_.onSysCheckChange} />
          {data.label}
        </label>
      )}
      <br/>
    </div>

    const sys_all_checkbox = <label>
      <input  type='checkbox' checked={this.state.systems_all} onChange={this.onSysAllChange} />
      Выбрать все
    </label>

    const sys_warn_all = this.state.systems_warn.all?<label>Система ALL исключена из генерации</label>:<div/>;
    const sys_warn_na = this.state.systems_warn.na?<label>Система N/A исключена из генерации</label>:<div/>;
    const sys_none_label = this.state.systems_none?<label>Ни одной системы не выбрано</label>:<div/>;

    const sys_container = <div className='generate-dbm-sys-container'>
      {([0,1].includes(this.state.varIndex))?<div>{sys_none_label}{sys_check_group}{sys_all_checkbox}{sys_warn_all}{sys_warn_na}</div>:<div/>}
    </div>

      
    const predecessor_input = <input type='text' name = 'predecessor' value={this_.state.predecessor} onChange = {this_.onPredecessorChange}/> 

    const rf_container = <div className='generate-dbm-rf-container'>
      {([0].includes(this.state.varIndex))?<div>
          {delimiter_select}<br/>
          {predecessor_input}
        </div>
      :<div/>}
    </div>

    return (
      <div className="generate-dbm-modal" onClick={this.openModal}>
        <a onClick = {this.openModal} >
          <img alt = "Generate" src = "/assets/generate.png" />
          Генерация
        </a>
     
        <Modal isOpen={this.state.modalIsOpen} onAfterOpen={this.afterOpenModal} onRequestClose={this.closeModal} style={customStyles} contentLabel="Свойства экспорта в файл">

          <div className='generate-dbm-all'>
            <h2 ref="subtitle">Настройки создания SELECT файла и заполнения DBM.</h2>
            <div>
              <div className='generate-dbm-top'>
                {mod_radio_group}
                {rf_container}
              </div>
              <div className='generate-dbm-top'>
                {var_radio_group}
              </div>
            </div>
            {sys_container}
          </div>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.onExport}>Экспорт</button>
        </Modal>
      </div>
    );
  }
}

module.exports = GenerateDbm;
