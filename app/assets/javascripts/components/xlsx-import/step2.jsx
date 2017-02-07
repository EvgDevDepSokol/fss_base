var React = require('react');
var Modal = require('react-modal');

// preview data
var ImportStep2 = React.createClass({
  displayName: 'ImportStep2',

  getInitialState: function() {
    return {
      modalIsOpen: false,
      mappedColumns: []
    };
  },

  closeModal: function() {this.props.onCloseModal();},

  nextModal: function() {
    this.props.onNextModal();
  },

  render: function() {
    var importColumns = this.props.columns;
    if(importColumns != null)
    {
    var headersFrom = Object.keys(importColumns).map(function(key, i)  {

      return (
        <th key={i + '-header'} className={"static-header"} >
          {key}
        </th>
      );
    });
    var headersTo = Object.keys(importColumns).map(function(key, i)  {
      return (
        <th key={i + '-header'} className={"select-header"} >
          {importColumns[key].selector}
        </th>
      );
    });

    var rows = null;
    if (this.props.importData.length > 0){
      rows = this.props.importData.slice(0,10).map(function(row, i){

        var cells = Object.keys(importColumns).map(function(key, j) {
          return (
            <td key={i + '-' + j + '-cell'}>
              {row[key]}
            </td>
          );
        });

        return (
          <tr key={i + '-row'}>
          {cells}
          </tr>);
      });
    }
    return (
      <div className="import-from-excel-2">
        <Modal
          isOpen={this.props.isOpen}
          onRequestClose={this.closeModal}
          style={this.props.style}
        >
          <h2>Step 2. Выберите столбцы</h2>
          <table className={"table table-bordered table-striped table-hover"}>
            <thead>
              <tr>
                {headersFrom}
              </tr>
              <tr className="selector-header">
                {headersTo}
              </tr>
            </thead>
            <tbody>
              {rows}
            </tbody>
          </table>
          <p>Всего {this.props.importData.length} строк данных</p>
          <div>Укажите соответствия импорта колонок</div>

          <button onClick={this.closeModal}>close</button>
          <button onClick={this.nextModal}>Next</button>
        </Modal>
      </div>
    );
    }else
    {
      return(<div />);
    }
  }
});

module.exports = ImportStep2;
