var React = require('react');
//var SimpleSelect = require('../modules/simple-select.jsx');
var _ = require('underscore');

var ImportStep1 = require('./xlsx-import/step1.jsx');
var ImportStep2 = require('./xlsx-import/step2.jsx');
var ImportStep3 = require('./xlsx-import/step3.jsx');
var ImportStep4 = require('./xlsx-import/step4.jsx');

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
      modal_1_IsOpen: false,
      modal_2_IsOpen: false,
      modal_3_IsOpen: false,
      modal_4_IsOpen: false,
      step: 0,
      importData: [
        {
          data: {}
        }
      ],
      columns: {},
      keyColumn:''
    };
  },

  mapImportData: function() {
    var importColumns = this.state.columns;
    debugger
    // наполняем данными importColumns
    Object.keys(importColumns).forEach(function(columnKey) {
      var toColumn = importColumns[columnKey].toColumn;
      if (toColumn)
        importColumns[columnKey]['options'] = getColumnOptions(toColumn);
      }
    );

    var data = this.state.importData[0].data.map(function(row) {
      var convertedRow = {};

      Object.keys(importColumns).forEach(function(columnKey) {
        var to = importColumns[columnKey].to;
        var toColumn = importColumns[columnKey].toColumn;

        if (to != null) {
          if (toColumn == null) {} else if (toColumn.nested == true) {
            var val = row[columnKey];
            var newVal = _.find(importColumns[columnKey].options, function(option) {
              return option.label == val;
            });
            if (newVal) {
              convertedRow[importColumns[columnKey].toColumn.attribute] = newVal.value;
            } else {
              // report error
            };

          } else {
            convertedRow[to] = row[columnKey];
          };
        };

      });
      return convertedRow;
    });
    return data;
  },

  openStep1: function() {
    this.setState({step: 1});
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
      keyColumn:''
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
    this.setState({step: 3});
  },

  step3Finished: function() {
    var parsedData = this.mapImportData();
    this.setState({
      step: 4,
      importData: [
        {
          data: {}
        }
      ],
      parsedData: parsedData
    });
    this.sendDataToServer(parsedData);
  },

  step3Back: function() {
    this.setState({step: 2});
  },


  step4Finished: function() {
    this.setState({step: 0});
  },

  sendDataToServer: function(data) {
    $.ajax({
      url: '/update_all',
      dataType: 'json',
      type: 'PUT',
      data: {
        data: data,
        model: model_name,
        pds_project_id: project.id,
        keyColumn: this.state.keyColumn
      },
      success: function(response) {
        console.error(response);

      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    return (
      <div className="import-from-excel">
        <a href="#" onClick={this.openStep1}>
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
          importData={this.state.importData[0].data}
          columns={this.state.columns}
          rememberColumns={this.rememberColumns}
          style={customStyles}
          contentLabel='Импорт. Выбор соответствия столбцов.'/>
        <ImportStep3
          key={"step-3"}
          isOpen={this.state.step == 3}
          onNextModal={this.step3Finished}
          onPrevModal={this.step3Back}
          onCloseModal={this.closeAllModals}
          columns={this.state.columns}
          keyColumn={this.state.keyColumn}
          importData={this.state.importData[0].data}
          rememberKeyColumn={this.rememberKeyColumn}
          style={customStyles}
          contentLabel='Импорт. Выбор ключевого поля.'/>
        <ImportStep4
          key={"step-4"}
          isOpen={this.state.step == 4}
          onNextModal={this.step4Finished}
          onCloseModal={this.closeAllModals}
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
