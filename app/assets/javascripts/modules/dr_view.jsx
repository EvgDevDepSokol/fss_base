'use strict';
import React from 'react';
import PropTypes from 'prop-types';

class DrView extends React.Component {
  static displayName = 'DrView';

  static propTypes = {
    project: PropTypes.object,
    dr_details: PropTypes.object
  };

  state = {
    project: this.props.project,
    dr_details: this.props.dr_details
  };

  render() {
    var project = this.props.project.project_name;
    var dr_details = this.props.dr_details;

    return (
      <div className="dr_view_form">
        <div className="dr_header">
          <p />
          <p> Протокол Рассогласования </p>
          <p> {project} </p>
        </div>
        <div className="dr_body">
          <textarea value={dr_details.query} />
        </div>
      </div>
    );
  }
}

module.exports = DrView;
