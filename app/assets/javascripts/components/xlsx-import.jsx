var React = require('react');
//var SimpleSelect = require('../modules/simple-select.jsx');
var _ = require('underscore');

var ImportStep1 = require('./xlsx-import/step1.jsx');
var ImportStep2 = require('./xlsx-import/step2.jsx');
var ImportStep4 = require('./xlsx-import/step4.jsx');
const HEADER_ERR0 = 'err0';
const N_ROWS = 1000;

const customStyles = {
  content:
  {
    //    position              : 'absolute',
    //    top                   : '100px',
    //    left                  : '40px',
    //    right                 : '40px',
    //    bottom                : '40px'
  }
};

var ImportXlsxModal = React.createClass(
{
  displayName: 'ImportXlsxModal',

  getInitialState: function ()
  {
    return {
      step: 0,
      importData: [
      {
        data:
        {}
      }],
      columns:
      {},
      keyColumn: '',
      msg: [],
      parsedData: [],
      processed: 0
    };
  },

  mapImportData: function (data)
  {
    var importColumns = this.state.columns;
    debugger
    // наполняем данными importColumns
    Object.keys(importColumns).forEach(function (columnKey)
    {
      var toColumn = importColumns[columnKey].toColumn;
      if(toColumn)
      {
        importColumns[columnKey]['options'] = getColumnOptions(toColumn);
      }
      else
      {
        //delete importColumns[columnKey];
      };
    });


    var parsedData = this.state.importData[0].data.map(function (row, i)
    {
      var convertedRow = {};
      var err = [];
      Object.keys(importColumns).forEach(function (columnKey)
      {
        var to = importColumns[columnKey].to;
        var toColumn = importColumns[columnKey].toColumn;

        if(to != null)
        {
          if(toColumn == null)
          {}
          else if(toColumn.nested == true)
          {
            var val = row[columnKey];
            var newVal = _.find(importColumns[columnKey].options, function (option)
            {
              return option.label == val;
            });
            if(newVal)
            {
              convertedRow[importColumns[columnKey].toColumn.attribute] = newVal.value;
            }
            else if(!!val)
            {
              err.push(columnKey + ': ' + data[i][columnKey] + ' не найдено.')
            };

          }
          else
          {
            convertedRow[to] = row[columnKey];
          };
        };

      });
      data[i][HEADER_ERR0] = err.length > 0 ? err : [];
      convertedRow[HEADER_ERR0] = err.length > 0 ? err : [];
      return convertedRow;
    });
    return parsedData;
  },

  openStep1: function ()
  {
    if(current_user.user_rights >= 1)
    {
      this.setState(
      {
        step: 1
      });
    }
    else
    {
      alert('У Вас недостаточно прав для выполнения импорта из файла!');
    }
  },

  closeAllModals: function ()
  {
    this.setState(
    {
      step: 0,
      importData: [
      {
        data:
        {}
      }],
      columns:
      {},
      keyColumn: '',
      msg: [],
      parsedData:[],
      processed: 0
    });
  },

  rememberData: function (importData)
  {
    this.setState(
    {
      importData: importData
    });
  },

  rememberColumns: function (columns)
  {
    this.setState(
    {
      columns: columns
    });
  },

  rememberKeyColumn: function (keyColumn)
  {
    this.setState(
    {
      keyColumn: keyColumn
    });
  },

  onSelectChange: function (columnKey)
  {
    var context = this;
    return function (value)
    {
      var impColumns = context.state.columns;
      impColumns[columnKey]['to'] = value;
      // impColumns[columnKey]['toColumn'] = context.findColumnData(value);
      context.setState(
      {
        columns: impColumns
      });
    }
  }.bind(this),

  step1Finished: function (file)
  {
    this.setState(
    {
      step: 2
    });
  },

  step2Finished: function ()
  {
    var data = this.state.importData[0].data;
    var parsedData = this.mapImportData(data);
    this.setState(
    {
      step: 4,
      parsedData: parsedData,
      data: data,
      msg: [],
      processed: 0
    });
    this.sendDataToServer(parsedData, '/import_prepare');
  },

  step4Finished: function (to_exit)
  {
    if(to_exit)
    {
      this.setState(
      {
        step: 0,
        importData: [
        {
          data:
          {}
        }],
        columns:
        {},
        keyColumn: '',
        msg: [],
        parsedData: [], 
        processed: 0
      });
    }
    else
    {
      var parsedData = this.state.parsedData;
      this.sendDataToServer(parsedData, '/import_finish');
    }
  },

  sendDataToServer: function (data, path)
  {
    var i1, i2, msg;
    var ajaxcall = [];
    var n = Math.floor(data.length / N_ROWS);
    var context = this;
    var promise = $.when();
    var arr = Array.apply(null,
    {
      length: n + 1
    }).map(Function.call, Number);
    $.each(arr, function (index, value)
    {
      promise = promise.then(function ()
      {
        var i1 = value * N_ROWS;
        var i2 = Math.min(data.length, (value + 1) * N_ROWS);
        return $.ajax(
        {
          url: path,
          dataType: 'json',
          type: 'PUT',
          data:
          {
            data: data.slice(i1, i2),
            model: model_name,
            pds_project_id: project.id,
            i1: i1,
            i2: i2,
            keyColumn: context.state.keyColumn
          },
          success: function (response)
          {
            msg = context.state.msg;
            i1 = Number(response.i1);
            i2 = Number(response.i2);
            for(var j = i1; j < i2; j++)
            {
              msg[j] = response.message[j - i1]
            };
            context.setState(
            {
              msg: msg,
              processed: i2
            });
          }.bind(context),
          error: function (xhr, status, err) {}.bind(context)
        })
      })
    });
  },

  render: function ()
  {
    return( <
      div className = "import-from-excel" >
      <
      a onClick = {
        this.openStep1
      } >
      <
      img alt = "Import export"
      src = "/assets/import_export.png" / >
      Экспорт / Импорт <
      /a>

      <
      ImportStep1 key = {
        "step-1"
      }
      isOpen = {
        this.state.step == 1
      }
      onNextModal = {
        this.step1Finished
      }
      onCloseModal = {
        this.closeAllModals
      }
      rememberData = {
        this.rememberData
      }
      rememberColumns = {
        this.rememberColumns
      }
      onSelectChange = {
        this.onSelectChange
      }
      style = {
        customStyles
      }
      contentLabel = 'Импорт. Выбор файла.' / >
      <
      ImportStep2 key = {
        "step-2"
      }
      isOpen = {
        this.state.step == 2
      }
      onNextModal = {
        this.step2Finished
      }
      onCloseModal = {
        this.closeAllModals
      }
      columns = {
        this.state.columns
      }
      keyColumn = {
        this.state.keyColumn
      }
      importData = {
        this.state.importData[0].data
      }
      rememberColumns = {
        this.rememberColumns
      }
      rememberKeyColumn = {
        this.rememberKeyColumn
      }
      style = {
        customStyles
      }
      contentLabel = 'Импорт. Выбор соответствия столбцов.' / >
      <
      ImportStep4 key = {
        "step-4"
      }
      isOpen = {
        this.state.step == 4
      }
      onNextModal = {
        this.step4Finished
      }
      onCloseModal = {
        this.closeAllModals
      }
      columns = {
        this.state.columns
      }
      importData = {
        this.state.importData[0].data
      }
      msg = {
        this.state.msg
      }
      processed = {
        this.state.processed
      }
      style = {
        customStyles
      }
      contentLabel = 'Импорт. Обработка.' / >
      <
      /div>
    );
  }
});

module.exports = ImportXlsxModal;

var getColumnOptions = function (column)
{
  if(!column.nested /* || !column.path*/ )
    return;

  return column.editor ?
    column.editor.options() : [];
  var properties = column.property.split(".");
  if(properties.length != 2)
    return;

  var key = _.last(properties);

  var options = [];
  $.ajax(
  {
    url: '/' + column.path,
    dataType: 'json',
    type: 'GET',
    success: function (data)
    {
      options = data;
    }.bind(this),
    error: function (xhr, status, err)
    {
      console.error(this.props.url, status, err.toString());
      options = [];
    }.bind(this),
    async: false
  });

  options = $.map(options, function (el)
  {
    return {
      value: el.id,
      label: el[key]
    }
  });
  return options;
};
