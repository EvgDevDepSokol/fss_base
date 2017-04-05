var React = require('react');
var Modal = require('react-modal');
var Paginator = require('react-pagify').default;
var segmentize = require('segmentize');

const HEADER_STATE = 'Статус';
const HEADER_WARN = 'Предупреждение';
const HEADER_ERR = 'Ошибки';
const HEADER_ERR0 = 'err0';
const HEADER_RESULT = 'Результат';

// preview results
var ImportStep4 = React.createClass(
    {
      displayName: 'ImportStep4',

      getInitialState: function ()
      {
        return {
          filter_add: 0,
          filter_err: 0,
          filter_warn: 0,
          to_exit: false,
          pagination:
          {
            page: 1,
            perPage: 20
          }
        };
      },

      afterOpenModal()
      {
        this.setState(
        {
          filter_add: 0,
          filter_err: 0,
          filter_warn: 0,
          to_exit: false
        });
      },

      closeModal: function ()
      {
        this.setState(
        {
          filter_add: 0,
          filter_err: 0,
          filter_warn: 0,
          to_exit: false
        });
        this.props.onCloseModal();
      },

      nextModal: function ()
      {
        this.props.onNextModal(this.state.to_exit);
        this.setState(
        {
          to_exit: true
        })
      },

      onFilterErrChange: function (e)
      {
        var filter_err = parseInt(e.target.value, 10);
        this.setState(
        {
          filter_err: filter_err
        })
      },

      onFilterAddChange: function (e)
      {
        var filter_add = parseInt(e.target.value, 10);
        this.setState(
        {
          filter_add: filter_add
        })
      },

      onFilterWarnChange: function (e)
      {
        var filter_warn = parseInt(e.target.value, 10);
        this.setState(
        {
          filter_warn: filter_warn
        })
      },

      onSelect: function (page)
      {
        var pagination = this.state.pagination ||
        {};
        var pages = Math.ceil(this.props.importData.length / pagination.perPage);

        pagination.page = Math.min(Math.max(page, 1), pages);

        this.setState(
        {
          pagination: pagination
        });
      },


      render: function ()
      {
        var importHeaders = this.props.columns;
        var importData = this.props.importData;
        var msg = this.props.msg;
        var message = null;
        var filters = null;
        var to_exit = this.state.to_exit;
        var modalTableContainerClass = "modal-table-container"
        var pagination = this.state.pagination ||
        {};
        var numberOfRows = 0;

        if(this.props.isOpen)
        {
          debugger

          if(msg.length == 1 && msg[0].not_unique)
          {
            filters = < div > Файл обработан. < /div>;
            message = < p > 'Значение выбранного ключевого поля в базе для этой таблицы не уникально! Записи для импорта не могут быть определены однозначно. Импорт не может быть продолжен.' < /p>;
            modalTableContainerClass = "modal-table-container hidden-element"
            to_exit = true;
          }
          else
          {

            var radio_add = < div className = 'filter-add-radio-group modal-filter' >
              <
              p > Статус < /p> <
            input type = 'radio'
            name = 'filter-add'
            value = '0'
            checked = {
              this.state.filter_add === 0
            }
            onChange = {
              this.onFilterAddChange
            }
            />Показать все < br / >
            <
            input type = 'radio'
            name = 'filter-add'
            value = '1'
            checked = {
              this.state.filter_add === 1
            }
            onChange = {
              this.onFilterAddChange
            }
            />Показать только записи на добавление < br / >
            <
            input type = 'radio'
            name = 'filter-add'
            value = '2'
            checked = {
              this.state.filter_add === 2
            }
            onChange = {
              this.onFilterAddChange
            }
            />Показать только записи на обновление < br / >
            <
            /div>

            var radio_warn = < div className = 'filter-warn-radio-group modal-filter' >
              <
              p > Предупреждение < /p> <
            input type = 'radio'
            name = 'filter-warn'
            value = '0'
            checked = {
              this.state.filter_warn === 0
            }
            onChange = {
              this.onFilterWarnChange
            }
            />Показать все < br / >
            <
            input type = 'radio'
            name = 'filter-warn'
            value = '1'
            checked = {
              this.state.filter_warn === 1
            }
            onChange = {
              this.onFilterWarnChange
            }
            />Показать только записи с предупреждениями < br / >
            <
            input type = 'radio'
            name = 'filter-warn'
            value = '2'
            checked = {
              this.state.filter_warn === 2
            }
            onChange = {
              this.onFilterWarnChange
            }
            />Показать только записи без предупреждений < br / >
            <
            /div>

            var radio_err = < div className = 'filter-err-radio-group modal-filter' >
              <
              p > Ошибки < /p> <
            input type = 'radio'
            name = 'filter-err'
            value = '0'
            checked = {
              this.state.filter_err === 0
            }
            onChange = {
              this.onFilterErrChange
            }
            />Показать все < br / >
            <
            input type = 'radio'
            name = 'filter-err'
            value = '1'
            checked = {
              this.state.filter_err === 1
            }
            onChange = {
              this.onFilterErrChange
            }
            />Показать только записи с ошибками < br / >
            <
            input type = 'radio'
            name = 'filter-err'
            value = '2'
            checked = {
              this.state.filter_err === 2
            }
            onChange = {
              this.onFilterErrChange
            }
            />Показать только записи без ошибок < br / >
            <
            /div>


            importHeaders[HEADER_STATE] = '';
            importHeaders[HEADER_WARN] = '';
            importHeaders[HEADER_ERR] = '';
            importHeaders[HEADER_RESULT] = '';

            if(importHeaders != null)
            {
              var headersFrom = Object.keys(importHeaders).map(function (key, i)
              {
                var className = importHeaders[key]['to'] ? "static-header" : "static-header not-editable";
                return( <
                  th key = {
                    i + '-header'
                  }
                  className = {
                    className
                  } >
                  {
                    key
                  } <
                  /th>
                );
              });
            };

            var filtered = [];
            var filter_add = this.state.filter_add;
            var filter_err = this.state.filter_err;
            var filter_warn = this.state.filter_warn;

            var rows = null;
            numberOfRows = importData.length;
            if(importData.length > 0)
            {
              rows = importData.map(function (row, i)
                {
                  var err = [];
                  for(var j = 0; j < row[HEADER_ERR0].length; j++)
                  {
                    err.push( < p >
                      {
                        row[HEADER_ERR0][j]
                      } < /p>);
                    }
                    if(typeof msg[i] !== 'undefined')
                    {
                      row[HEADER_STATE] = msg[i].add;
                      row[HEADER_WARN] = msg[i].warn;
                      row[HEADER_RESULT] = msg[i].result;
                      for(var j = 0; j < msg[i].err.length; j++)
                      {
                        err.push( < p >
                          {
                            msg[i].err[j]
                          } < /p>);
                        }
                      }
                      row[HEADER_ERR] = err;
                      return row;
                    });

                  switch(filter_add)
                  {
                  case 1:
                    rows = rows.filter(function (row)
                    {
                      return row[HEADER_STATE];
                    });
                    break;
                  case 2:
                    rows = rows.filter(function (row)
                    {
                      return !row[HEADER_STATE];
                    });
                    break;
                  };

                  switch(filter_warn)
                  {
                  case 1:
                    rows = rows.filter(function (row)
                    {
                      return !!row[HEADER_WARN];
                    });
                    break;
                  case 2:
                    rows = rows.filter(function (row)
                    {
                      return !row[HEADER_WARN];
                    });
                    break;
                  };

                  switch(filter_err)
                  {
                  case 1:
                    rows = rows.filter(function (row)
                    {
                      return !!row[HEADER_ERR] && row[HEADER_ERR].length > 0;
                    });
                    break;
                  case 2:
                    rows = rows.filter(function (row)
                    {
                      return !row[HEADER_ERR];
                    });
                    break;
                  };


                  var paginated = paginate(rows, pagination);
                  var pages = Math.ceil(rows.length / Math.max(isNaN(pagination.perPage) ?
                    1 :
                    pagination.perPage, 1));

                  rows = paginated.data.map(function (row, i)
                  {
                    row[HEADER_STATE] = row[HEADER_STATE] ? 'Новая запись' : 'Существующая запись';

                    var cells = Object.keys(importHeaders).map(function (key, j)
                    {
                      return( <
                        td key = {
                          i + '-' + j + '-cell'
                        } >
                        {
                          row[key]
                        } <
                        /td>
                      );
                    });

                    return( <
                      tr key = {
                        i + '-row'
                      } >
                      {
                        cells
                      } <
                      /tr>
                    );
                  });

                  filters = !!msg ? < div className = 'modal-filter-container' >
                  {
                    radio_add
                  }
                  {
                    radio_warn
                  }
                  {
                    radio_err
                  } < /div>:<div></div > ;
                }
                else
                {
                  filters = < div > Ваш файл обрабатывается < /div>;
                }
              }
              var next_button = to_exit ? null : < button onClick = {
                this.nextModal
              } > Подтвердить < /button>
              var exit_button = to_exit ? < button onClick = {
                this.closeModal
              } > Выход < /button>:<button onClick={this.closeModal}>Отмена</button >
            };


            return( <
              div className = "import-from-excel-3" >
              <
              Modal isOpen = {
                this.props.isOpen
              }
              onRequestClose = {
                this.closeModal
              }
              style = {
                this.props.style
              }
              contentLabel = {
                this.props.contentLabel
              }
              onAfterOpen = {
                this.afterOpenModal
              } >
              <
              h2 > Предварительные результаты < /h2>
              {
                filters
              }

              <
              div className = {
                modalTableContainerClass
              }
              key = {
                "modal-table"
              } >
              <
              table className = {
                "table table-bordered table-striped table-hover"
              } >
              <
              thead >
              <
              tr >
              {
                headersFrom
              } <
              /tr> < /
              thead > <
              tbody >
              {!!rows ? rows : null
              } <
              /tbody> < /
              table > <
              /div>

              <
              div className = 'pagination' >
              <
              Paginator.Context className = "pagify-pagination"
              segments = {
                segmentize(
                {
                  page: pagination.page,
                  pages: pages,
                  beginPages: 3,
                  endPages: 3,
                  sidePages: 2
                })
              }
              onSelect = {
                this.onSelect
              } >
              <
              Paginator.Button page = {
                pagination.page - 1
              } > Предыдущая < /Paginator.Button> <
              Paginator.Segment field = "beginPages" / >
              <
              Paginator.Ellipsis className = "ellipsis"
              previousField = "beginPages"
              nextField = "previousPages" / >
              <
              Paginator.Segment field = "previousPages" / >
              <
              Paginator.Segment field = "centerPage"
              className = "selected" / >
              <
              Paginator.Segment field = "nextPages" / >
              <
              Paginator.Ellipsis className = "ellipsis"
              previousField = "nextPages"
              nextField = "endPages" / >
              <
              Paginator.Segment field = "endPages" / >
              <
              Paginator.Button page = {
                pagination.page + 1
              } > Следующая < /Paginator.Button> < /
              Paginator.Context > <
              /div>

              <
              p > Обработано
              {
                this.props.processed
              }
              строк данных. < /p> <
              p > Всего
              {
                numberOfRows
              }
              строк данных. < /p>

              <
              div className = {
                'modal-warning'
              } >
              {
                message
              } < /div>
              {
                exit_button
              }
              {
                next_button
              } <
              /Modal> < /
              div >
            );
          }
        });

      function paginate(data, o)
      {
        data = data || [];

        // adapt to zero indexed logic
        var page = o.page - 1 || 0;
        var perPage = o.perPage;

        var amountOfPages = Math.ceil(data.length / perPage);
        var startPage = page < amountOfPages ?
          page :
          0;

        return {
          amount: amountOfPages,
          data: data.slice(startPage * perPage, startPage * perPage + perPage),
          page: startPage
        };
      }

      module.exports = ImportStep4;
