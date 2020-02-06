// selector to be used for booleans
'use strict';
import React from 'react';
import PropTypes from 'prop-types';
import Select from 'react-select';

module.exports = class extends React.Component {
  static displayName = 'ProjectShortSelector';
  static propTypes = { label: PropTypes.string };

  state = {
    value: this.props.value
  };

  setValue = value => {
    onChange(value, this);
  };

  render() {
    var options = [
      { value: 90, label: 'ПМТ Смоленск-2' },
      { value: 87, label: 'ПМТ СмАЭС-3' },
      { value: 83, label: 'Курск-2' },
      { value: 80000001, label: 'ПМТ КуАЭС-4' },
      { value: 80000003, label: 'ПМТ КуАЭС-4 2016' },
      { value: 88, label: 'ПМТ БалАЭС-1' },
      { value: 80000006, label: 'ПМТ РостАЭС-1' },
      { value: 80000007, label: 'ПМТ СмАЭС-3 2020' }
    ];

    return (
      <Select
        name="Project"
        options={options}
        onChange={this.setValue}
        value={this.state.value}
        simpleValue={true}
        multi={false}
        clearable={false}
      />
    );
  }
};
