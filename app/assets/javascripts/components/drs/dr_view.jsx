'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import { DRSTATUS } from './dr_data.jsx';

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
      sys: -1,
      drAuthor: current_user.id,
      status: 0,
      query: 'Описание рассогласования',
      comments: [],
      system: {
        id: -1,
        System: 'Не выбрано'
      }
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
                <td>Система: {dr_details.system.System}</td>
                <td>Ответственный: {dr_details.pds_engineer_worker}</td>
                <td>Текущий статус: {DRSTATUS[last_status].label}</td>
              </tr>
            </tbody>
          </table>
        </div>
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
