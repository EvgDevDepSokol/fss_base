var React = require('react');

var _ = require('underscore');

module.exports = React.createClass({
  displayName: 'SimpleSelect',
  getInitialState: function() {
    return {
      selected: this.props.selected
    }
  },
  onChange: function(event){
    debugger
    this.setState({value: event.target.value});
    //this.props.onChange();
  },

  render: function() {

    //debugger;
    var selected_option = this.state.selected;
    var options = this.props.options.map(function(option){
      var selected = selected_option == this.value || selected_option == option.label ? 'selected' : null;
      return(<option value={option.value} selected={selected} >{option.label}</option>);
    });
    options.unshift(<option value="" >Не выбрано</option>);
    //debugger;

    return (
      <select onChange={this.onChange} >
        {options}
      </select>
    );
  }
});
