'use strict';
var React = require('react');
var ReactDOM = require('react-dom');
var createReactClass = require('create-react-class');
import PropTypes from 'prop-types';
import Modal from 'react-modal';

var SystemSelector = require('../selectors/system.jsx');
var SystemFilterSelector = require('../selectors/system_filter.jsx');
var SystemAllSelector = require('../selectors/system_all.jsx');

var HwIcSelector = require('../selectors/hw_ic.jsx');
var DetectorSelector = require('../selectors/detector.jsx');
var PdsManEquipSelector = require('../selectors/pds_man_equips.jsx');
var PdsSectionAssemblerSelector = require('../selectors/pds_section_assembler.jsx');
var HwPedSelector = require('../selectors/hw_ped.jsx');
var HwIosignaldefSelector = require('../selectors/hw_iosignaldef.jsx');
var PdsPanelSelector = require('../selectors/pds_panels.jsx');
var HwDevTypesSelector = require('../selectors/hw_dev_types.jsx');
var PdsEquipSelector = require('../selectors/pds_equip.jsx');

var PdsMotorTypeSelector = require('../selectors/pds_motor_types.jsx');
var ProjectSelector = require('../selectors/project.jsx');

//some static selectors
var MalfunctionTypeSelector = require('../selectors/static_selectors.jsx')
  .MalfunctionTypeSelector;
var RFTypeSelector = require('../selectors/static_selectors.jsx')
  .RFTypeSelector;
var ValveTypeSelector = require('../selectors/static_selectors.jsx')
  .ValveTypeSelector;
var BooleanSelector = require('../selectors/static_selectors.jsx')
  .BooleanSelector;
var BooleanYNSelector = require('../selectors/static_selectors.jsx')
  .BooleanYNSelector;
var BooleanNumbSelector = require('../selectors/static_selectors.jsx')
  .BooleanNumbSelector;
var MotorZmnSelector = require('../selectors/static_selectors.jsx')
  .MotorZmnSelector;
var UserRightsSelector = require('../selectors/static_selectors.jsx')
  .UserRightsSelector;
var RegidityUnitSelector = require('../selectors/static_selectors.jsx')
  .RegidityUnitSelector;
var AnnounciatorTypeSelector = require('../selectors/static_selectors.jsx')
  .AnnounciatorTypeSelector;
var AnnounciatorSignSelector = require('../selectors/static_selectors.jsx')
  .AnnounciatorSignSelector;
var SyslistDescriptorSelector = require('../selectors/static_selectors.jsx')
  .SyslistDescriptorSelector;
var SyslistCategorySelector = require('../selectors/static_selectors.jsx')
  .SyslistCategorySelector;

var SdSelector = require('../selectors/pds_sds.jsx');
var UnitSelector = require('../selectors/pds_project_units.jsx');
var UnitAllSelector = require('../selectors/pds_units.jsx');
var PdsEngineersSelector = require('../selectors/pds_engineers.jsx');
var PdsDocumentationsSelector = require('../selectors/pds_documentation.jsx');
var PdsValvesSelector = require('../selectors/pds_valves.jsx');

//var ReplaceConfirmContainer =  require('../components/replace_confirm.jsx');

var findIndex = require('lodash').findIndex;
var new_data = {};

class CustomInput extends React.Component {
  static displayName = 'CustomInput';

  static propTypes = {
    editor: PropTypes.func,
    attribute: PropTypes.string,
    enabled: PropTypes.bool
  };

  state = {
    editor: this.props.editor,
    attribute: this.props.attribute,
    enabled: this.props.enabled
  };

  render() {
    var editor = this.props.editor;
    var lpass = false;
    if (editor) {
      lpass = editor.displayName.endsWith('Selector');
    }
    if (lpass) {
      editor = eval(this.props.editor.displayName);
      return (
        <div className="replace-selector">
          {React.createElement(editor, {
            onValue: function() {},
            disabled: !this.props.enabled
          })}
        </div>
      );
    } else {
      return (
        <div className="replace-input-container">
          <input className="replace-input" disabled={!this.props.enabled} />
        </div>
      );
    }
  }
}

module.exports = class extends React.Component {
  static displayName = 'Replace';

  static propTypes = {
    onChange: PropTypes.func,
    columns: PropTypes.array,
    column: PropTypes.string,
    data: PropTypes.array,
    isReplaceModalOpen: PropTypes.bool,
    disabled: PropTypes.bool
  };

  state = {
    editor: null,
    attribute: null,
    data: data,
    disabled: this.props.disabled,
    fromIndex: 0,
    toIndex: 0,
    isReplaceModalOpen: false
  };

  openReplaceModal = () => {
    this.setState({ isReplaceModalOpen: true });
  };

  closeReplaceModal = () => {
    this.setState({ isReplaceModalOpen: false });
  };

  onSubmit = () => {
    var _this = this;
    var data = this.props.data;
    var attribute = this.state.attribute;
    //var column = ReactDOM.findDOMNode(this.refs.column).value;
    var column = this.state.column;
    var editor = this.state.editor;
    var lpass = false;
    if (editor) {
      lpass = editor.displayName.endsWith('Selector');
    }
    if (lpass) {
      var from = ReactDOM.findDOMNode(this.refs.from).firstChild.childNodes[0]
        .defaultValue;
      var to = ReactDOM.findDOMNode(this.refs.to).firstChild.childNodes[0]
        .defaultValue;
    } else {
      var from = ReactDOM.findDOMNode(this.refs.from).children[0].value;
      var to = ReactDOM.findDOMNode(this.refs.to).children[0].value;
    }
    var ids = [];

    if (column.length > 0) {
      data.forEach(function(row) {
        if (row.checked) {
          ids.push(row.id);
        }
      });
      if (ids.length > 0) {
        $.ajax({
          url: '/replace_prepare',
          dataType: 'json',
          data: {
            pds_project_id: project ? project.id : null,
            model: model_name,
            column: attribute ? attribute : column,
            from: from,
            to: to,
            ids: ids,
            fromIndex: this.state.fromIndex,
            toIndex: this.state.toIndex
          },
          type: 'PUT',
          success: function(responce) {
            new_data = JSON.parse(responce.new_data);

            if (new_data) {
              //    _this.setState({isReplaceModalOpen:true});
              var lsave = confirm(
                'Количество измененных записей: ' +
                  new_data.length +
                  '. Сохранить изменения?'
              );
              //    var lsave=false;
              if (lsave && new_data.length > 0) {
                $.ajax({
                  url: '/replace_finish',
                  dataType: 'json',
                  data: {
                    new_data: new_data,
                    column: attribute ? attribute : column,
                    model: model_name
                  },
                  type: 'PUT',
                  success: function(responce) {
                    var cols = JSON.parse(responce.data);
                    var data = this.state.data;
                    var arr = column.split('.');
                    column = arr[0];
                    cols.forEach(function(col) {
                      var idx = findIndex(data, { id: col.id });
                      data[idx][column] = col[column];
                      data[idx].checked = false;
                    });
                    this.props.onReplaceDone(data);
                  }.bind(_this),
                  error: function(xhr, status, err) {
                    console.error(this.props.url, status, err.toString());
                  }.bind(_this)
                });
              }
            }
          },
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
          }.bind(this)
        });
      } else {
        alert(
          'Поставьте галочки в строках, в которых желаете произвести замену!'
        );
      }
    } else {
      alert('Выберите колонку, в которой будет производиться замена!');
    }
  };

  onChangeColumn = e => {
    var column = e.target.value;
    var columns = this.props.columns;
    var attribute;
    var editor;
    columns.forEach(function(col) {
      if (col.property == column) {
        attribute = col.attribute;
        editor = col.editor;
      }
    });
    this.setState({
      column: column,
      attribute: attribute,
      editor: editor
    });
  };

  onRadioFromChange = e => {
    var fromIndex = parseInt(e.target.value, 10);
    var toIndex = this.state.toIndex;
    if (fromIndex !== 2) {
      toIndex = 0;
    }
    this.setState({ fromIndex: fromIndex, toIndex: toIndex });
  };

  onRadioToChange = e => {
    var toIndex = parseInt(e.target.value, 10);
    this.setState({ toIndex: toIndex });
  };

  render() {
    var columns = this.props.columns || [];
    var options = [{}].concat(
      columns
        .map(function(column) {
          if (column.property && column.label) {
            if (column.editor && column.attribute !== 'extra_label') {
              return { value: column.property, name: column.label };
            }
          }
        })
        .filter(id)
    );

    return (
      <div className="replace">
        <span> В столбце </span>
        {
          <div className="replace-where">
            {
              <select
                className="replace-column-selector"
                onChange={this.onChangeColumn}
              >
                {options.map(function(option, i) {
                  return (
                    <option key={'opt' + i} value={option.value}>
                      {option.name}
                    </option>
                  );
                })}
              </select>
            }{' '}
          </div>
        }
        <span> заменить </span>
        <div className="replace-from">
          {
            <div className="replace-from-radio-group">
              <input
                type="radio"
                name="replace-from"
                value="0"
                checked={this.state.fromIndex === 0}
                onChange={this.onRadioFromChange}
              />{' '}
              <CustomInput
                ref="from"
                editor={this.state.editor}
                attribute={this.state.attribute}
                description="Что заменить"
                enabled={this.state.fromIndex === 0}
              />
              <br />{' '}
              <input
                type="radio"
                name="replace-from"
                value="1"
                checked={this.state.fromIndex === 1}
                onChange={this.onRadioFromChange}
              />{' '}
              пустые <br />{' '}
              <input
                type="radio"
                name="replace-from"
                value="2"
                checked={this.state.fromIndex === 2}
                onChange={this.onRadioFromChange}
              />{' '}
              все <br />{' '}
            </div>
          }
        </div>
        <span> на </span>
        <div className="replace-to">
          {
            <div className="replace-to-radio-group">
              <input
                type="radio"
                name="replace-to"
                value="0"
                checked={this.state.toIndex === 0}
                onChange={this.onRadioToChange}
              />{' '}
              <CustomInput
                ref="to"
                editor={this.state.editor}
                attribute={this.state.attribute}
                description="На что заменить"
                enabled={this.state.toIndex === 0}
              />
              <br />{' '}
              <input
                type="radio"
                name="replace-to"
                value="1"
                checked={this.state.toIndex === 1}
                onChange={this.onRadioToChange}
                disabled={this.state.fromIndex !== 2}
              />{' '}
              пустые <br />{' '}
            </div>
          }
        </div>
        {
          <button
            onClick={this.onSubmit}
            className="btn btn-xs btn-default"
            disabled={this.props.disabled}
          >
            {' '}
            OK{' '}
          </button>
        }
        {
          <div>
            <ReplaceConfirmModal
              id="replace_confirm_modal"
              isReplaceModalOpen={this.state.isReplaceModalOpen}
              onRequestClose={this.closeReplaceModal}
              new_data={new_data}
              contentLabel="Замена. Подтверждение."
            />{' '}
          </div>
        }
      </div>
    );
  }
};

function id(a) {
  return a;
}

class ReplaceConfirmModal extends React.Component {
  static displayName = 'ReplaceConfirmModal';
  state = { isReplaceModalOpen: this.props.isReplaceModalOpen };

  closeReplaceModal = () => {
    this.props.onRequestClose();
  };

  render() {
    return (
      <div>
        <Modal
          isOpen={this.props.isReplaceModalOpen}
          onRequestClose={this.closeReplaceModal}
          contentLabel={this.props.contentLabel}
        >
          shouldCloseOnOverlayClick=
          {false}
          <h2 ref="subtitle">Окно с предварительными результатами замены.</h2>
          <button onClick={this.closeReplaceModal}>close</button>
          <div>Пока не работает.</div>
          <form>{this.props.new_data}</form>
        </Modal>
      </div>
    );
  }
}
