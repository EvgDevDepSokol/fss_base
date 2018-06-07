import React from 'react';
import PropTypes from 'prop-types';
//import ReactDOM from 'react-dom';
import Modal from 'react-modal';


var getSelectorOptions = require('../selectors/selectors.jsx').getSelectorOptions;

const MOD = ['MOD', 'ADD', 'OMOD'];
const VARIABLES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announcicator', 'time step', 'valves', 'power sections'];

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

class GenerateDbm extends React.Component {
  constructor() {
    super();

    this.state = {
      modalIsOpen: false,
      modIndex: 1
    };

    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.onExport = this.onExport.bind(this);
    this.onModRadioChange = this.onModRadioChange.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.refs.subtitle.style.color = '#0081c2';
    var options = getSelectorOptions(
      '/selectors/pds_sys_descriptions',
      {pds_project_id:project.ProjectID},
      this
    );
    
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  onModRadioChange(e) {
    var modIndex = parseInt(e.target.value, 10);
    this.setState({modIndex: modIndex})
  }

  onExport() {
    this.setState({modalIsOpen: false});
  }

  render() {
    var this_=this;

    const mod_radio_group = MOD.map((data,idx) =>
      <p key={'mod-radio-group-key'+idx}>
        <input type='radio' value={idx} checked={this_.state.modIndex === idx} onChange={this_.onModRadioChange} /> {MOD[idx]}<br/>
      </p>
    );

    const var_radio_group = VARIABLES.map((data,idx) =>
      <p key={'var-radio-group-key'+idx}>
        <input  type='radio' value={idx} checked={this_.state.varIndex === idx} onChange={this_.onVarRadioChange} /> {VARIABLES[idx]}<br/>
      </p>
    );

    return (
      <div className="export-to-excel" onClick={this.openModal}>
        Генерация селект-файлов для DBM
        <Modal isOpen={this.state.modalIsOpen} onAfterOpen={this.afterOpenModal} onRequestClose={this.closeModal} style={customStyles} contentLabel="Свойства экспорта в файл">

          <h4 ref="subtitle">Экспорт производится с учетом активных фильтров.</h4>
          <h3 ref="subtitle">Свойства экспорта в файл:</h3>
          <table style='{width:100%}'}>
            <tr>
              <th>header1</th>
              <th>header2</th>
            </tr>
            <tr>
              <td>{mod_radio_group}</td>
              <td>{mod_radio_group}{mod_radio_group}</td>
            </tr>
          </table>
          <h3></h3>
          <h3></h3>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.onExport}>Экспорт</button>
        </Modal>
      </div>
    );
  }
}

module.exports = GenerateDbm;
