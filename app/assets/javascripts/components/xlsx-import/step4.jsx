var React = require('react');
var Modal = require('react-modal');

// preview results
var ImportStep4 = React.createClass({
  displayName: 'ImportStep4',

  getInitialState: function() {
    return{
      filter_add:0,
      filter_err:0,
      filter_warn:0,
      to_exit:false
    };
  },

  afterOpenModal() {
    this.setState({
      filter_add:0,
      filter_err:0,
      filter_warn:0,
      to_exit:false
    });
  },

  closeModal: function() {
    this.setState({
      filter_add:0,
      filter_err:0,
      filter_warn:0,
      to_exit:false
    });
    this.props.onCloseModal();
  },

  nextModal: function() {
    this.props.onNextModal(this.state.to_exit);
    this.setState({
      to_exit:true
    })
  },

  onFilterErrChange: function(e) {
    var filter_err = parseInt(e.target.value, 10);
    this.setState({filter_err: filter_err})
  },

  onFilterAddChange: function(e) {
    var filter_add = parseInt(e.target.value, 10);
    this.setState({filter_add: filter_add})
  },

  onFilterWarnChange: function(e) {
    var filter_warn = parseInt(e.target.value, 10);
    this.setState({filter_warn: filter_warn})
  },

  render: function() {
    var importHeaders = this.props.columns;
    var importData = this.props.importData; 
    var msg = this.props.msg;
    var message = null;
    var filters = null; 
    var to_exit = this.state.to_exit;
    var modalTableContainerClass = "modal-table-container"

    if(this.props.isOpen) {
      if (msg.length==1 && msg[0].not_unique) {
        filters = <div>Файл обработан.</div>;
        message = <p>'Значение выбранного ключевого поля в базе для этой таблицы не уникально! Записи для импорта не могут быть определены однозначно. Импорт не может быть продолжен.'</p>;
        modalTableContainerClass = "modal-table-container hidden-element"
        to_exit = true;
      } else {

        var radio_add = < div className = 'filter-add-radio-group modal-filter' >
          <p> Статус</p>
          <input type='radio' name='filter-add' value='0' checked={this.state.filter_add === 0} onChange={this.onFilterAddChange}/>Показать все < br />
          <input type='radio' name='filter-add' value='1' checked={this.state.filter_add === 1} onChange={this.onFilterAddChange}/>Показать только записи на добавление < br />
          <input type='radio' name='filter-add' value='2' checked={this.state.filter_add === 2} onChange={this.onFilterAddChange}/>Показать только записи на обновление < br />
        </div>

        var radio_warn = < div className = 'filter-warn-radio-group modal-filter' >
          <p> Предупреждение</p>
          <input type='radio' name='filter-warn' value='0' checked={this.state.filter_warn === 0} onChange={this.onFilterWarnChange}/>Показать все < br />
          <input type='radio' name='filter-warn' value='1' checked={this.state.filter_warn === 1} onChange={this.onFilterWarnChange}/>Показать только записи с предупреждениями < br />
          <input type='radio' name='filter-warn' value='2' checked={this.state.filter_warn === 2} onChange={this.onFilterWarnChange}/>Показать только записи без предупреждений < br />
        </div> 

        var radio_err = < div className = 'filter-err-radio-group modal-filter' >
          <p> Ошибки</p>
          <input type='radio' name='filter-err' value='0' checked={this.state.filter_err === 0} onChange={this.onFilterErrChange}/>Показать все < br />
          <input type='radio' name='filter-err' value='1' checked={this.state.filter_err === 1} onChange={this.onFilterErrChange}/>Показать только записи с ошибками < br />
          <input type='radio' name='filter-err' value='2' checked={this.state.filter_err === 2} onChange={this.onFilterErrChange}/>Показать только записи без ошибок < br />
        </div> 
       

        importHeaders['Статус'] = '';
        importHeaders['Предупреждение'] = '';
        importHeaders['Ошибки'] = '';
        importHeaders['Результат'] = '';

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
        var filter_warn = this.state.filter_warn;

        var rows = null;
        if (importData.length > 0 && msg.length > 0) {
          rows = importData.map(function(row, i) {
            row['Статус']=msg[i].add;
            row['Предупреждение'] = msg[i].warn;
            row['Ошибки']=msg[i].err;
            row['Результат']=msg[i].result;
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

          switch(filter_warn){
            case 1:
              rows = rows.filter(function(row){
                return !!row['Предупреждение'];
              });
              break;
            case 2:
              rows = rows.filter(function(row){
                return !row['Предупреждение'];
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
          filters = !!msg?<div className='modal-filter-container'>{radio_add}{radio_warn}{radio_err}</div>:<div></div>;
        } else {
          filters = <div>Ваш файл обрабатывается</div>;
        }
      }
      var next_button=to_exit?null:<button onClick={this.nextModal}>Подтвердить</button>
      var exit_button=to_exit?<button onClick={this.closeModal}>Выход</button>:<button onClick={this.closeModal}>Отмена</button>
    };


    return (
      <div className="import-from-excel-3">
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel} onAfterOpen={this.afterOpenModal}>
          <h2>Предварительные результаты</h2>
          {filters}
          <div className={modalTableContainerClass} key={"modal-table"}>
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

          <div className={'modal-warning'}>{message}</div>
          {exit_button} 
          {next_button} 
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep4;
