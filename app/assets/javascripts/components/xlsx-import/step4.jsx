var React = require('react');
var Modal = require('react-modal');

// preview results
var ImportStep4 = React.createClass({
  displayName: 'ImportStep4',

  getInitialState: function() {
    return{
      filter_add:0,
      filter_err:0
    };
  },

  openModal: function() {
    this.setState({modalIsOpen: true});
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    this.props.onNextModal();
  },

  onFilterErrChange: function(e) {
    var filter_err = parseInt(e.target.value, 10);
    this.setState({filter_err: filter_err})
  },

  onFilterAddChange: function(e) {
    var filter_add = parseInt(e.target.value, 10);
    this.setState({filter_add: filter_add})
  },

  render: function() {
    var importHeaders = this.props.columns;
    var importData = this.props.importData; 
    var msg = this.props.msg;

    if(this.props.isOpen) {

      var radio_err = < div className = 'filter-err-radio-group modal-filter' >
        <p> Ошибки</p>
        <input type='radio' name='filter-err' value='0' checked={this.state.filter_err === 0} onChange={this.onFilterErrChange}/>Показать все < br />
        <input type='radio' name='filter-err' value='1' checked={this.state.filter_err === 1} onChange={this.onFilterErrChange}/>Показать только записи с ошибками < br />
        <input type='radio' name='filter-err' value='2' checked={this.state.filter_err === 2} onChange={this.onFilterErrChange}/>Показать только записи без ошибок < br />
      </div> 

      var radio_add = < div className = 'filter-add-radio-group modal-filter' >
        <p> Статус</p>
        <input type='radio' name='filter-add' value='0' checked={this.state.filter_add === 0} onChange={this.onFilterAddChange}/>Показать все < br />
        <input type='radio' name='filter-add' value='1' checked={this.state.filter_add === 1} onChange={this.onFilterAddChange}/>Показать только записи на добавление < br />
        <input type='radio' name='filter-add' value='2' checked={this.state.filter_add === 2} onChange={this.onFilterAddChange}/>Показать только записи на обновление < br />
      </div> 

      importHeaders['Статус'] = '';
      importHeaders['Ошибки'] = '';

      if (importHeaders != null) {
        var headersFrom = Object.keys(importHeaders).map(function(key, i) {

          return (
            <th key={i + '-header'} className={"static-header"}>
              {key}
            </th>
          );
        });
      };

      var filtered = [];
      var filter_add = this.state.filter_add;
      var filter_err = this.state.filter_err;

      var rows = null;
      if (importData.length > 0 && msg.length > 0) {
        rows = importData.map(function(row, i) {
          row['Статус']=msg[i].add;
          row['Ошибки']=msg[i].err;
          return row;
        });

        switch(filter_add){
          case 1:
            rows = rows.filter(function(row){
              return row['Статус'];
            });
            break;
          case 2:
            rows = rows.filter(function(row){
              return !row['Статус'];
            });
            break;
        };
  
        switch(filter_err){
          case 1:
            rows = rows.filter(function(row){
              return !!row['Ошибки'];
            });
            break;
          case 2:
            rows = rows.filter(function(row){
              return !row['Ошибки'];
            });
            break;
        };

        rows = rows.map(function(row, i) {
          row['Статус']=row['Статус']?'Новая запись':'Существующая запись';

          var cells = Object.keys(importHeaders).map(function(key, j) {
            return (
              <td key={i + '-' + j + '-cell'}>
                {row[key]}
              </td>
            );
          });

          return (
            <tr key={i + '-row'}>
              {cells}
            </tr>
          );
        });
        var filters = !!msg?<div className='modal-filter-container'>{radio_add}{radio_err}</div>:<div></div>;
      } else {
        var filters = <div>Ваш файл обрабатывается</div>;
      }
    };


    return (
      <div className="import-from-excel-3">
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel}>
          <h2>Предварительные результаты</h2>
          {filters}
          <div className="modal-table-container" key={"modal-table"}>
            <table className={"table table-bordered table-striped table-hover"}>
              <thead>
                <tr>
                  {headersFrom}
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
          </div>
          <p>Всего {!!rows?rows.length:0} строк данных.</p>
 
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.nextModal}>Завершить</button>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep4;
