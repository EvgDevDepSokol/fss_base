// selector to be used for booleans

'use strict';
import React from 'react';
import createClass from 'create-react-class';
import PropTypes from 'prop-types';
import Select from 'react-select';

module.exports = React.createClass({
  displayName: 'ProjectShortSelector',

  propTypes: {label: PropTypes.string},

  getInitialState() {
    return {
      value: this.props.value
    };
  },

  setValue(value) {
    onChange(value,this)
  },

  render: function() {

    var options = [
     { value: 90        , label: 'ПМТ Смоленск-2'}, 
     { value: 87        , label: 'ПМТ СмАЭС-3'},
     { value: 83        , label: 'Курск-2'},
     { value: 80000001  , label: 'ПМТ КуАЭС-4'},
     { value: 80000003  , label: 'ПМТ КуАЭС-4 2016'},
     { value: 200000029 , label: 'АТ БилАЭС'},
     { value: 88        , label: 'ПМТ БалАЭС-1'  }] 

    return (
      React.createElement(Select, {name: "Project",
        options: options,
        onChange: this.setValue,
        value: this.state.value,
        simpleValue:true,
        multi: false,
        clearable: false
      })
    );
  }
});
