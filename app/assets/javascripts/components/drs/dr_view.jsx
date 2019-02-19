'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import { DRSTATUS } from './dr_data.jsx';
var SystemEngineerSelector = require('../../selectors/system_engineer.jsx');

class DrView extends React.Component {
  static displayName = 'DrView';

  static propTypes = {
    project: PropTypes.object,
    dr_details: PropTypes.object,
    onCommentSave: PropTypes.func,
    onDrCancel: PropTypes.func,
    isDrNew: PropTypes.bool
  };

  state = {
    project: this.props.project,
    dr_details: this.props.dr_details,
    isDrNew: this.props.isDrNew,
    comment: {
      status: 1,
      comment_date: Date(),
      pds_engineer: current_user,
      comment_text: '',
      pds_dr_id: -1
    },
    dr_details_new: {
      drNum: 0,
      drAuthor: current_user.id,
      status: 0,
      query: 'Описание рассогласования',
      comments: [],
      system: {
        id: -1,
        System: 'Не выбрано'
      },
      pds_engineer_worker: 'Не выбрано'
    },
    select: {
      sys_id: -1,
      eng_id: -1
    }
  };

  onTextEditorChange = e => {
    var comment = this.state.comment;
    comment.comment_text = e.target.value;
    this.setState({ comment: comment });
  };

  onTextEditorKeyUp = e => {
    if (e.keyCode == 27) {
      // ESC pressed
      this.onTextEditorCancel();
    }
    if (e.ctrlKey && e.keyCode == 13) {
      // Ctrl-Enter pressed
      this.onCommentSave();
    }
  };

  onTextEditorCancel = function() {
    var comment = this.state.comment;
    comment.comment_text = '';
    this.setState({ comment: comment });
  };

  comment_table = function(comment, i) {
    return (
      <div key={i + '-dr-comment'} className="dr_comment">
        <table>
          <tbody>
            <tr className={DRSTATUS[comment.status].tr_classname}>
              <td>{moment(comment.comment_date).format('DD.MM.YY HH:mm')}</td>
              <td>{comment.pds_engineer.name}</td>
              <td>{DRSTATUS[comment.status].label}</td>
            </tr>
          </tbody>
        </table>
        {i != -1 ? (
          <span> {comment.comment_text} </span>
        ) : (
          <textarea
            value={comment.comment_text}
            onChange={this.onTextEditorChange}
            onKeyUp={this.onTextEditorKeyUp}
            onBlur={this.onTextEditorBlur}
          />
        )}
        <p />
      </div>
    );
  };

  comment_buttons = function() {
    var disabled = true;
    var comment = this.state.comment;
    if (comment) {
      if (comment.comment_text) {
        if (comment.comment_text.length > 0) {
          disabled = false;
        }
      }
    }
    return (
      <div className="comment_buttons">
        <button
          key="comment_button_ok"
          onClick={() => this.onCommentSave()}
          disabled={disabled}
        >
          Сохранить
        </button>
        <button
          key="comment_button_cancel"
          onClick={() => this.onCommentCancel()}
        >
          Отмена
        </button>
      </div>
    );
  };

  onCommentAdd = function(val) {
    var comment = {
      status: val,
      comment_date: moment().format(),
      pds_engineer: current_user,
      pds_dr_id: this.props.dr_details.id
    };
    this.setState({ comment: comment });
  };

  onCommentSave = function() {
    var comment = this.state.comment;
    this.props.onCommentSave(comment);
    this.onCommentCancel();
  };

  onCommentCancel = function() {
    var comment = this.state.comment;
    comment.pds_dr_id = -1;
    comment.comment_text = '';
    this.setState({ comment: comment });
    this.props.onDrCancel();
  };

  onSystemEngineerChange = function(value) {
    var dr_details_new = this.state.dr_details_new;
    dr_details_new.system.id = value.id;
    dr_details_new.system.System = sys_eng_list[value.id]['sys_name'];
    dr_details_new.pds_engineer_worker = sys_eng_list[value.id]['eng_name']
      ? sys_eng_list[value.id]['eng_name']
      : 'Не выбрано';
    this.setState({ dr_details_new: dr_details_new });
  }.bind(this);

  onSysChange = function(event) {
    var select = this.state.select;
    select.sys_id = event.target.value;
    this.setState({ select });
    if (select.sys_id == -1) {
      select.eng_id = -1;
    }
  }.bind(this);

  onEngChange = function(event) {
    var select = this.state.select;
    select.eng_id = event.target.value;
    if (select.eng_id == -1) {
      select.sys_id = -1;
    }
    this.setState({ select });
  }.bind(this);

  sys_eng_selector = function() {
    var sys_opt = [];
    var eng_opt = [];
    var sys_id = this.state.select.sys_id;
    var eng_id = this.state.select.eng_id;
    if (sys_id > -1) {
      eng_opt = sys_eng_list[sys_id]['engineers'].map(function(eng, i) {
        return { value: eng.eng_id, label: eng.eng_name };
      });
    } else {
      Object.keys(eng_sys_list).forEach(function(key) {
        eng_opt.push({ value: key, label: eng_sys_list[key].eng_name });
      });
    }
    if (eng_id > -1) {
      sys_opt = eng_sys_list[eng_id]['systems'].map(function(sys, i) {
        return { value: sys.sys_id, label: sys.sys_name };
      });
    } else {
      Object.keys(sys_eng_list).forEach(function(key) {
        sys_opt.push({ value: key, label: sys_eng_list[key].sys_name });
      });
    }
    eng_opt = eng_opt.sort(function(a, b) {
      if (a.label < b.label) return -1;
      if (a.label > b.label) return 1;
      return 0;
    });
    eng_opt.unshift({ value: -1, label: 'Не выбрано' });
    sys_opt.unshift({ value: -1, label: 'Не выбрано' });
    sys_opt = sys_opt.map(function(opt, i) {
      return (
        <option key={'opt-' + i} value={opt.value}>
          {opt.label}
        </option>
      );
    });
    eng_opt = eng_opt.map(function(opt, i) {
      return (
        <option key={'opt-' + i} value={opt.value}>
          {opt.label}
        </option>
      );
    });
    return (
      <div className="dr-system-selector">
        <select
          size="20"
          value={this.state.select.eng_id}
          onChange={this.onEngChange}
        >
          {eng_opt}
        </select>
        <select
          size="20"
          value={this.state.select.sys_id}
          onChange={this.onSysChange}
        >
          {sys_opt}
        </select>
      </div>
    );
  };

  render() {
    var this_ = this;
    var project = this.props.project.project_name;
    var isDrNew = this.props.isDrNew;
    var dr_details = isDrNew
      ? this.state.dr_details_new
      : this.props.dr_details;
    var comment = this.state.comment;
    var show_new_comment = isDrNew || comment.pds_dr_id == dr_details.id;
    var dr_comments = dr_details['comments'].map(function(comment, i) {
      return this_.comment_table(comment, i);
    });
    var last_status = isDrNew ? 6 : dr_details['comments'].slice(-1)[0].status;

    var dr_buttons = DRSTATUS[last_status].links.map(function(l, i) {
      return (
        <button key={i + 'dr_button'} onClick={() => this_.onCommentAdd(l.val)}>
          {l.label}
        </button>
      );
    });

    return (
      <div className="dr_view_form">
        <div className="dr_header">
          <p />
          <p> Протокол Рассогласования № {dr_details.drNum}</p>
          <p> {project} </p>
        </div>
        <div className="dr_info">
          <table>
            <tbody>
              <tr>
                <td>Ответственный: {dr_details.pds_engineer_worker}</td>
                <td>Система: {dr_details.system.System}</td>
                <td>Текущий статус: {DRSTATUS[last_status].label}</td>
              </tr>
            </tbody>
          </table>
        </div>
        {this.sys_eng_selector()}
        <div className="dr_body">{dr_comments}</div>
        <div className="dr_buttons">{dr_buttons}</div>
        <div className="dr_body">
          {show_new_comment ? this.comment_table(comment, -1) : null}
          {show_new_comment ? this.comment_buttons() : null}
        </div>
      </div>
    );
  }
}

module.exports = DrView;
