'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import { DRSTATUS, DRPRIORITY } from './dr_data.jsx';
const NOT_SELECTED = '-Не выбрано-';

class DrView extends React.Component {
  static displayName = 'DrView';

  static propTypes = {
    project: PropTypes.object,
    dr_details: PropTypes.object,
    onCommentSave: PropTypes.func,
    onDrCancel: PropTypes.func,
    onDrInsert: PropTypes.func,
    isDrNew: PropTypes.bool
  };

  state = {
    project: this.props.project,
    dr_details: this.props.dr_details,
    isDrNew: this.props.isDrNew,
    isDrEdit: false,
    comment: {
      status: 1,
      comment_date: Date(),
      pds_engineer: current_user,
      comment_text: '',
      pds_dr_id: -1
    },
    dr_details_local: {
      drNum: 0,
      drAuthor: current_user.id,
      status: 1,
      query: 'Описание рассогласования',
      comments: [],
      system: {
        id: -1,
        System: NOT_SELECTED
      },
      pds_engineer_worker: NOT_SELECTED,
      Priority: 0,
      time_left: 0
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
    var isDrEdit = false;
    comment.comment_text = '';
    this.setState({ comment, isDrEdit });
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
            className={this.isCommentEmpty() ? 'attention' : ''}
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

  isCommentEmpty = function() {
    var comment = this.state.comment;
    return (
      comment && (!comment.comment_text || comment.comment_text.length < 1)
    );
  };

  comment_buttons = function() {
    var disabled = true;
    disabled = this.isCommentEmpty();
    if (this.props.isDrNew && this.state.select.sys_id == -1) disabled = true;
    if (this.state.isDrEdit) {
      disabled = true;
      var dr_details = this.props.dr_details;
      var dr_details_local = this.state.dr_details_local;
      var select = this.state.select;
      if (
        (dr_details_local.Priority != dr_details.Priority ||
          select.sys_id != dr_details.system.id) &&
        select.sys_id != -1
      )
        disabled = false;
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
    comment.comment_author_id = comment.pds_engineer.engineer_N;
    delete comment.pds_engineer;
    comment.Project = project.id;
    if (this.props.isDrNew) {
      var dr_details_local = this.state.dr_details_local;
      var pds_dr = {};
      pds_dr.query = comment.comment_text;
      pds_dr.drAuthor = dr_details_local.drAuthor;
      pds_dr.Project = project.id;
      pds_dr.sys = dr_details_local.system.id;
      pds_dr.drNum = -1;
      pds_dr.Priority = dr_details_local.Priority;

      this.props.onDrInsert(pds_dr, comment);
    } else {
      this.props.onCommentSave(comment);
    }
    this.onCommentCancel();
  };

  onCommentCancel = function() {
    var comment = this.state.comment;
    comment.pds_dr_id = -1;
    comment.comment_text = '';
    comment.pds_engineer = current_user;
    comment.status = 1;
    comment.comment_text = '';
    this.setState({ comment: comment, isDrEdit: false });
    this.props.onDrCancel();
  };

  onSysChange = function(event) {
    var select = this.state.select;
    var dr_details_local = this.state.dr_details_local;
    select.sys_id = event.target.value;
    dr_details_local.system.id = select.sys_id;
    if (select.sys_id == -1) {
      select.eng_id = -1;
      dr_details_local.system.System = NOT_SELECTED;
      dr_details_local.pds_engineer_worker = NOT_SELECTED;
    } else {
      dr_details_local.system.System = sys_eng_list[select.sys_id]['sys_name'];
      dr_details_local.pds_engineer_worker = sys_eng_list[select.sys_id][
        'engineers'
      ]
        .map(function(eng, i) {
          return eng.eng_name;
        })
        .sort()
        .join(', ');
    }
    this.setState({ select, dr_details_local });
  }.bind(this);

  onEngChange = function(event) {
    var select = this.state.select;
    var dr_details_local = this.state.dr_details_local;
    select.eng_id = event.target.value;
    if (select.eng_id == -1) {
      select.sys_id = -1;
      dr_details_local.system.System = NOT_SELECTED;
      dr_details_local.pds_engineer_worker = NOT_SELECTED;
    }
    this.setState({ select, dr_details_local });
  }.bind(this);

  onPriorityChange = function(event) {
    var dr_details_local = this.state.dr_details_local;
    dr_details_local.Priority = event.target.value;
    this.setState({ dr_details_local });
  }.bind(this);

  priority_selector = function(height) {
    var priority_opt = [];
    Object.keys(DRPRIORITY).forEach(function(key) {
      priority_opt.push({
        value: key,
        label: DRPRIORITY[key].label + ' ' + DRPRIORITY[key].period + ' дней'
      });
    });
    priority_opt = priority_opt.map(function(opt, i) {
      return (
        <option key={'opt-' + i} value={opt.value}>
          {opt.label}
        </option>
      );
    });
    return (
      <td className="dr_priority_selector">
        <select
          size={height}
          value={this.state.dr_details_local.Priority}
          onChange={this.onPriorityChange}
        >
          {priority_opt}
        </select>
      </td>
    );
  };
  sys_eng_selector = function(height) {
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
    eng_opt.unshift({ value: -1, label: NOT_SELECTED });
    sys_opt.unshift({ value: -1, label: NOT_SELECTED });
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
      <td className="dr_system_selector">
        <select
          size={height}
          value={this.state.select.eng_id}
          onChange={this.onEngChange}
        >
          {eng_opt}
        </select>
        <select
          className={this.state.select.sys_id < 0 ? 'attention' : ''}
          size={height}
          value={this.state.select.sys_id}
          onChange={this.onSysChange}
        >
          {sys_opt}
        </select>
      </td>
    );
  };

  onDrEditClick = function(last_status) {
    var dr_details = this.props.dr_details;
    var dr_details_local = this.state.dr_details_local;
    var comment = this.state.comment;
    comment.status = last_status;
    //comment.comment_text = dr_details.query;
    dr_details_local.Priority = dr_details.Priority;
    dr_details_local.drNum = dr_details.drNum;
    dr_details_local.id = dr_details.id;
    dr_details_local.query = dr_details.query;
    dr_details_local.status = dr_details.status;
    dr_details_local.system.id = dr_details.system.id;
    dr_details_local.comments = dr_details.comments;
    var isDrEdit = true;
    var select = {
      sys_id: dr_details_local.system.id,
      eng_id: -1
    };

    this.setState({ dr_details_local, isDrEdit, select });
    var e = { target: { value: select.sys_id } };
    this.onSysChange(e);
  };

  render() {
    var this_ = this;
    var project = this.props.project.project_name;
    var isDrNew = this.props.isDrNew;
    var isDrEdit = this.state.isDrEdit;
    var dr_details =
      isDrNew || isDrEdit ? this.state.dr_details_local : this.props.dr_details;
    var comment = this.state.comment;
    var show_new_comment = isDrNew || comment.pds_dr_id == dr_details.id;
    var dr_comments =
      dr_details['comments'].length == 0
        ? null
        : dr_details['comments'].map(function(comment, i) {
          return this_.comment_table(comment, i);
        });
    var last_status;
    if (isDrNew || dr_details['comments'].length == 0) {
      last_status = 6;
    } else {
      last_status = dr_details['comments'].slice(-1)[0].status;
    }

    var dr_buttons = DRSTATUS[last_status].links.map(function(l, i) {
      return (
        <button key={i + 'dr_button'} onClick={() => this_.onCommentAdd(l.val)}>
          {l.label}
        </button>
      );
    });

    var dr_edit_button = [0, 1, 2, 3, 5, 6].includes(last_status) ? (
      <button
        className="dr_edit_button"
        onClick={() => this_.onDrEditClick(last_status)}
      >
        Редактировать DR
      </button>
    ) : null;

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
              <tr className="header">
                <td className="dr_eng">Ответственный</td>
                <td className="dr_sys">Система</td>
                <td className="dr_status">Текущий статус</td>
                <td className="dr_priority">Приоритет</td>
              </tr>
              <tr>
                <td className="dr_eng">{dr_details.pds_engineer_worker}</td>
                <td className="dr_sys">{dr_details.system.System}</td>
                <td className="dr_status">{DRSTATUS[last_status].label}</td>
                <td className="dr_priority">
                  {DRPRIORITY[dr_details.Priority].label}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div className="dr_selectors">
          <table>
            <tbody>
              <tr>
                {isDrNew || isDrEdit ? this.sys_eng_selector(15) : null}
                {isDrNew || isDrEdit ? this.priority_selector(15) : null}
              </tr>
            </tbody>
          </table>
        </div>
        <div className="dr_body">{dr_comments}</div>
        <div className="dr_buttons">
          {show_new_comment || isDrEdit ? null : [dr_buttons, dr_edit_button]}
        </div>
        <div className="dr_body">
          {show_new_comment ? this.comment_table(comment, -1) : null}
          {show_new_comment || isDrEdit ? this.comment_buttons() : null}
        </div>
      </div>
    );
  }
}

module.exports = DrView;
