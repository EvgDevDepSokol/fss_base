var React = require('react');
var Modal = require('react-modal');
var SimpleSelect = require('../../modules/simple-select.jsx');

// preview results
var ImportStep3 = React.createClass({
  displayName: 'ImportStep3',

  //options:[],

  getInitialState: function() {
    return {
      message:[],
      options:[],
    };
  },

  afterOpenModal() {
    var options = [];
    var importHeaders = this.props.columns;
    Object.keys(importHeaders).forEach(function(key) {
      if (importHeaders[key]['to']) {
        options.push({
          value: importHeaders[key]['toColumn']['attribute']?importHeaders[key]['toColumn']['attribute']:importHeaders[key]['to'],
          label: importHeaders[key]['toColumn']['label']?importHeaders[key]['toColumn']['label']:importHeaders[key]['to']})
      }
    });
    this.setState({
      options:options,
      message: []
    });
    //this.options = options;
  },

  closeModal: function() {
    this.props.onCloseModal();
  },

  nextModal: function() {
    var keyColumn = this.props.keyColumn;
    var importHeaders = this.props.columns;
    var importData = this.props.importData;
    var keyImport = '';
    var message = [];
    if(keyColumn){
      Object.keys(importHeaders).forEach(function(key) {
        if (importHeaders[key]['to']) {
          if (importHeaders[key]['to']==keyColumn) {
            keyImport = key;
          }
        }
      });
      var n = {},r='';
      for(var i = 0; i < importData.length; i++) 
      {
        r=importData[i][keyImport];
        if (!r) r='undefined';
        if (!n[r]) 
        {
          n[r] = {cnt:1, col:'\''+(i+1)+'\''};
        } else {
          n[r].cnt++; 
          n[r].col = n[r].col + ', \'' + (i+1) +'\''; 
        }
      };

      if (n['undefined']){
        message.push('В некоторых записях файла ключевое поле является пустым.')
        message.push(' Проверьте записи: '+n['undefined'].col+'.');
      };

      Object.keys(n).forEach(function(key) {
        if ((n[key].cnt>1)&&(key!=='undefined')) {
          message.push('В файле встречаются записи с одинаковым ключом: \''+key+'\'.')
          message.push(' Проверьте записи: '+n[key].col+'.');
        }
      });
    } else {
      message.push('Выберите ключевое поле импорта. Сейчас поле не выбрано.');
    };

    if (message > '') {
      this.setState({message:message});
    } else {
      this.setState({
        message:[],
        options:[]
      });
      this.props.onNextModal();
    };
  },

  prevModal: function() {
    this.props.onPrevModal();
  },

  onKeyColumnChange: function(value) {
    this.props.rememberKeyColumn(value);
  },

  render: function() {
    var importColumns = this.props.columns;
    var options = this.state.options;
    //var options = this.options;
    var message=this.state.message;
    var message = $.map(message,function(m,i){
      return(
        <p key={i+'-message'}>{m}</p>
      )
    });
    var keyColumnSelector = <SimpleSelect 
      onSelectChange={ this.onKeyColumnChange}
      value={ this.props.keyColumn}
      options= {options}/>
   
    return (
      <div className="import-from-excel-3">
        <Modal isOpen={this.props.isOpen} onRequestClose={this.closeModal} style={this.props.style} contentLabel={this.props.contentLabel} onAfterOpen={this.afterOpenModal}>
          <h2>Шаг 3. Выберите ключевое поле</h2>

          <div>Выберите ключевое поле, по которому запись будет искаться в базе.</div>
          <div>Значение поля для каждой записи из импортируемого файла должно быть уникальным и не должно быть пустым.</div>
          <div>При возникновении сообщения об ошибке, внесите исправления в импортруемый файл и начните импорт заново.</div>
          <div>
            {keyColumnSelector}
          </div>
          <button onClick={this.closeModal}>Отмена</button>
          <button onClick={this.prevModal}>Назад</button>
          <button onClick={this.nextModal}>Далее</button>
          <div className={'modal-warning'}>{message}</div>
        </Modal>
      </div>
    );
  }
});

module.exports = ImportStep3;
