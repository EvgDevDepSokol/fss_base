'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
const DRSTATUS = {
  0: {
    label: 'На уточнении',
    tr_classname: 'eng',
    links: [{ val: 1, label: 'Уточнить и открыть.' }]
  },
  1: {
    label: 'Открыт',
    tr_classname: 'tec',
    links: [
      { val: 0, label: 'Вернуть на уточнение' },
      { val: 2, label: 'Принять в работу' }
    ]
  },
  2: {
    label: 'Принят в работу',
    tr_classname: 'eng',
    links: [{ val: 3, label: 'Готов к проверке' }]
  },
  3: {
    label: 'Готов к проверке',
    tr_classname: 'eng',
    links: [
      { val: 4, label: 'Закрыть' },
      { val: 5, label: 'Вернуть на доработку' }
    ]
  },
  4: {
    label: 'Закрыт',
    tr_classname: 'tec',
    links: []
  },
  5: {
    label: 'Вернут на доработку',
    tr_classname: 'eng',
    links: [{ val: 3, label: 'Готов к проверке' }]
  }
};

class DrView extends React.Component {
  static displayName = 'DrView';

  static propTypes = {
    project: PropTypes.object,
    dr_details: PropTypes.object,
    onCommentSave: PropTypes.func
  };

  state = {
    project: this.props.project,
    dr_details: this.props.dr_details,
    comment: {
      status: 1,
      comment_date: Date(),
      pds_engineer: current_user,
      comment_text: '',
      pds_dr_id: -1
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
      this.onTextEditorSave();
    }
  };

  onTextEditorSave = function() {
    var comment = this.state.comment;
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
          <textarea value={comment.comment_text} />
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
  };

  render() {
    var this_ = this;
    var project = this.props.project.project_name;
    var dr_details = this.props.dr_details;
    var comment = this.state.comment;
    var show_new_comment = comment.pds_dr_id == dr_details.id;
    var dr_comments = dr_details['comments'].map(function(comment, i) {
      return this_.comment_table(comment, i);
    });
    var last_comment = dr_details['comments'].slice(-1)[0];

    var dr_buttons = DRSTATUS[last_comment.status].links.map(function(l, i) {
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
          <p> Протокол Рассогласования </p>
          <p> {project} </p>
        </div>
        <div className="dr_info">
          <table>
            <tbody>
              <tr>
                <td>№ {dr_details.drNum}</td>
                <td>Система: {dr_details.system.System}</td>
                <td>Ответственный: {dr_details.pds_engineer_worker}</td>
                <td>Текущий статус: {DRSTATUS[last_comment.status].label}</td>
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
