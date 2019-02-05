'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
var TextEditor = require('../inputs/text_editor.jsx')();
var dr_status_code = ['Открыт', 'Готов к проверке', 'Закрыт'];
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
      { val: 2, label: 'Вернуть на доработку' }
    ]
  },
  4: {
    label: 'Закрыт',
    tr_classname: 'tec',
    links: []
  }
};

class DrView extends React.Component {
  static displayName = 'DrView';

  static propTypes = {
    project: PropTypes.object,
    dr_details: PropTypes.object,
    show_text_editor: PropTypes.bool
  };

  state = {
    project: this.props.project,
    dr_details: this.props.dr_details,
    show_text_editor: false
  };

  addComment = () => {
    this.setState({ show_text_editor: true });
  };

  render() {
    var this_ = this;
    var project = this.props.project.project_name;
    var dr_details = this.props.dr_details;
    var dr_comments = dr_details['comments'].map(function(comment, i) {
      return (
        <div key={i + '-dr-comment'} className="dr_comment">
          <table>
            <tbody>
              <tr className={DRSTATUS[comment.status].tr_classname}>
                <td>
                  {moment(comment.comment_date)
                    .utc()
                    .format('DD.MM.YY HH:mm')}
                </td>
                <td>{comment.pds_engineer.name}</td>
                <td>{DRSTATUS[comment.status].label}</td>
              </tr>
            </tbody>
          </table>
          <textarea value={comment.comment_text} />
          <p />
        </div>
      );
    });
    var last_comment = dr_details['comments'].slice(-1)[0];
    var dr_buttons = DRSTATUS[last_comment.status].links.map(function(l, i) {
      return (
        <button key={i + 'dr_button'} onClick={this_.addComment}>
          {l.label}
        </button>
      );
    });
    var text_editor = this.state.show_text_editor ? (
      <TextEditor value="test" />
    ) : null;
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
        <div>{text_editor}</div>
      </div>
    );
  }
}

module.exports = DrView;
