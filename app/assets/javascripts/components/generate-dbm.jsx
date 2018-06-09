import React from 'react';
import PropTypes from 'prop-types';
import Modal from 'react-modal';


var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

const MOD = ['MOD', 'ADD', 'OMOD'];
const VARIABLES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announciator', 'time step', 'valves', 'power sections'];
const SEPARATOR = [',', ';'];

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
      sepIndex: 0,
      predecessor: 'globalyp',
      systems_all: false,
      systems:[]
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.onExport = this.onExport.bind(this);
    this.onModRadioChange = this.onModRadioChange.bind(this);
    this.onVarRadioChange = this.onVarRadioChange.bind(this);
    this.onSeparatorSelectorChange = this.onSeparatorSelectorChange.bind(this);
    this.onSysCheckChange = this.onSysCheckChange.bind(this);
    this.onSysAllChange = this.onSysAllChange.bind(this);
    this.onPredecessorChange = this.onPredecessorChange.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.refs.subtitle.style.color = '#0081c2';
    var systems = getSelectorOptions(
      '/selectors/pds_sys_descriptions',
      {pds_project_id:project.ProjectID},
      this
    );
    systems = systems.map((sys) =>{sys.isChecked = false;return sys});
    this.setState({
      systems: systems,
      systems_all: false
    });
    
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
  }

  onSeparatorSelectorChange(e) {
    var sepIndex = parseInt(e.target.value, 10);
    this.setState({sepIndex: sepIndex})
  }

  onPredecessorChange(e) {
    this.setState({predecessor: e.target.value})
  }

  onSysCheckChange(e) {
    var systems = this.state.systems;
    var l_all = true;
    //l_none = true;
    systems = systems.map((sys) => {
      if(sys.label==e.target.value) {
        sys.isChecked = !sys.isChecked;
      }
      l_all = l_all && sys.isChecked
      return sys});
    this.setState({
      systems: systems,
      systems_all: l_all
    });
  }

  onSysAllChange(e) {
    debugger
    var systems = this.state.systems;
    var systems_all = !this.state.systems_all
    systems = systems.map((sys) => {
      sys.isChecked = systems_all;
      return sys});
    this.setState({
      systems: systems,
      systems_all: systems_all
    });
  }



  onExport() {
    this.setState({modalIsOpen: false});
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
    
    const separator_select = <select value={this_.state.sepIndex} onChange={this_.onSeparatorSelectorChange}>
      {SEPARATOR.map((option,i) =>
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
    //const sys_all_label = 

    const sys_container = <div className='generate-dbm-sys-container'>
      {([0,1].includes(this.state.varIndex))?<div>{sys_check_group}{sys_all_checkbox}</div>:<div/>}
    </div>


      
    const predecessor_input = <input type='text' name = 'predecessor' value={this_.state.predecessor} onChange = {this_.onPredecessorChange}/> 

    const rf_container = <div className='generate-dbm-rf-container'>
      {([0].includes(this.state.varIndex))?<div>
          {separator_select}<br/>
          {predecessor_input}
        </div>
      :<div/>}
    </div>

    return (
      <div className="generate-dbm-modal" onClick={this.openModal}>
        Генерация селект-файлов для DBM
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
