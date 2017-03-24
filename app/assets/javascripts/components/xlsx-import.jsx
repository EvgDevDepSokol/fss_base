var React = require('react');
//var SimpleSelect = require('../modules/simple-select.jsx');
var _ = require('underscore');

var ImportStep1 = require('./xlsx-import/step1.jsx');
var ImportStep2 = require('./xlsx-import/step2.jsx');
var ImportStep4 = require('./xlsx-import/step4.jsx');
const HEADER_ERR='Ошибки';

const customStyles = {
  content: {
    //    position              : 'absolute',
    //    top                   : '100px',
    //    left                  : '40px',
    //    right                 : '40px',
    //    bottom                : '40px'
  }
};

var ImportXlsxModal = React.createClass({
  displayName: 'ImportXlsxModal',

  getInitialState: function() {
    return {
      step: 0,
      importData: [
        {
          data: {}
        }
      ],
      columns: {},
      keyColumn:'',
      msg:[]
    };
  },

  mapImportData: function(data) {
    var importColumns = this.state.columns;
    // наполняем данными importColumns
    Object.keys(importColumns).forEach(function(columnKey) {
      var toColumn = importColumns[columnKey].toColumn;
      if (toColumn){
        importColumns[columnKey]['options'] = getColumnOptions(toColumn);
      } else {
        //delete importColumns[columnKey];
      };
    });

    var parsedData = this.state.importData[0].data.map(function(row, i) {
      var convertedRow = {};
      var err = [];
      Object.keys(importColumns).forEach(function(columnKey) {
        var to = importColumns[columnKey].to;
        var toColumn = importColumns[columnKey].toColumn;

        if (to != null) {
          if (toColumn == null) {
          } else if (toColumn.nested == true) {
            var val = row[columnKey];
            var newVal = _.find(importColumns[columnKey].options, function(option) {
              return option.label == val;
            });
            if (newVal) {
              convertedRow[importColumns[columnKey].toColumn.attribute] = newVal.value;
            } else if (!!val) {
              err.push(columnKey + ': ' + data[i][columnKey] + ' не найдено')
            };

          } else {
            convertedRow[to] = row[columnKey];
          };
        };

      });
      debugger
      data[i][HEADER_ERR] = err.length>0?err:[];
      return convertedRow;
    });
    return parsedData;
  },

  openStep1: function() {
    if (current_user.user_rights >= 1) {
      this.setState({step: 1});
    } else {
      alert('У Вас недостаточно прав для выполнения импорта из файла!');
    }
  },

  closeAllModals: function() {
    this.setState({
      step: 0,
       importData: [
        {
          data: {}
        }
      ],
      columns: {},
      keyColumn:'',
      msg:[]
    });
  },

  rememberData: function(importData) {
    this.setState({importData: importData});
  },

  rememberColumns: function(columns) {
    this.setState({columns: columns});
  },

  rememberKeyColumn: function(keyColumn) {
    this.setState({keyColumn: keyColumn});
  },

  onSelectChange: function(columnKey) {
    var context = this;
    return function(value) {
      var impColumns = context.state.columns;
      impColumns[columnKey]['to'] = value;
      // impColumns[columnKey]['toColumn'] = context.findColumnData(value);
      context.setState({columns: impColumns});
    }
  }.bind(this),

  step1Finished: function(file) {
    this.setState({step: 2});
  },

  step2Finished: function() {
    var data = this.state.importData[0].data;
    var parsedData=this.mapImportData(data);
    this.setState({
      step: 4,
      parsedData: parsedData,
      data: data
    });
    this.sendDataToServer(parsedData,'/update_all_check');
  },

  step4Finished: function(to_exit) {
    if(to_exit) {
      this.setState({
        step: 0,
         importData: [
          {
            data: {}
          }
        ],
        columns: {},
        keyColumn:'',
        msg:[]
      });
    } else {
      var parsedData = this.state.parsedData;
      this.sendDataToServer(parsedData,'/update_all_finish');
    }
  },

  sendDataToServer: function(data, path) {
    $.ajax({
      url: path,
      dataType: 'json',
      type: 'PUT',
      data: {
        data: data,
        model: model_name,
        pds_project_id: project.id,
        keyColumn: this.state.keyColumn
      },
      success: function(response) {
        this.setState({
          msg: response.message,
        });
      }.bind(this),
      error: function(xhr, status, err) {
      }.bind(this)
    });
  },

  render: function() {
    return (
      <div className="import-from-excel">
        <a onClick={this.openStep1}>
          <img alt="Import export" src="/assets/import_export.png"/>
          Экспорт/ Импорт
        </a>

        <ImportStep1 
          key={"step-1"}
          isOpen={this.state.step == 1}
          onNextModal={this.step1Finished}
          onCloseModal={this.closeAllModals}
          rememberData={this.rememberData}
          rememberColumns={this.rememberColumns}
          onSelectChange={this.onSelectChange}
          style={customStyles}
          contentLabel='Импорт. Выбор файла.'/>
        <ImportStep2
          key={"step-2"}
          isOpen={this.state.step == 2}
          onNextModal={this.step2Finished}
          onCloseModal={this.closeAllModals}
          columns={this.state.columns}
          keyColumn={this.state.keyColumn}
          importData={this.state.importData[0].data}
          rememberColumns={this.rememberColumns}
          rememberKeyColumn={this.rememberKeyColumn}
          style={customStyles}
          contentLabel='Импорт. Выбор соответствия столбцов.'/>
        <ImportStep4
          key={"step-4"}
          isOpen={this.state.step == 4}
          onNextModal={this.step4Finished}
          onCloseModal={this.closeAllModals}
          columns={this.state.columns}
          importData={this.state.importData[0].data}
          msg={this.state.msg}
          style={customStyles}
          contentLabel='Импорт. Обработка.'/>
      </div>
    );
  }
});

module.exports = ImportXlsxModal;

var getColumnOptions = function(column) {
  if (!column.nested/* || !column.path*/)
    return;

  return column.editor
    ? column.editor.options()
    : [];
  var properties = column.property.split(".");
  if (properties.length != 2)
    return;

  var key = _.last(properties);

  var options = [];
  $.ajax({
    url: '/' + column.path,
    dataType: 'json',
    type: 'GET',
    success: function(data) {
      options = data;
    }.bind(this),
    error: function(xhr, status, err) {
      console.error(this.props.url, status, err.toString());
      options = [];
    }.bind(this),
    async: false
  });

  options = $.map(options, function(el) {
    return {value: el.id, label: el[key]}
  });
  return options;
};
