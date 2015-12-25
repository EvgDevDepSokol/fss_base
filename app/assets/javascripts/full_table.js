'use strict';

var React = require('react');
var Form = require('plexus-form');
var validate = require('plexus-validate');
var SkyLight = require('react-skylight');
var generators = require('annogenerate');
var math = require('annomath');
var Paginator = require('react-pagify');
var titleCase = require('title-case');
var findIndex = require('lodash/array/findIndex');

var Table = require('../lib/table.jsx');
var Search = require('../lib/search.jsx');
var editors = require('../lib/editors');
var sortColumn = require('../lib/sort_column');
var cells = require('../lib/cells');

var FieldWrapper = require('./field_wrapper.jsx');
var SectionWrapper = require('./section_wrapper.jsx');
var countries = require('./countries');
var generateData = require('./generate_data');


module.exports = React.createClass({
  displayName: 'FullTable',
  getInitialState:function() {
    var countryValues = countries.map(function(c)  {return c.value;});
    var properties = augmentWithTitles({
      name: {
        type: 'string'
      },
      position: {
        type: 'string'
      },
      salary: {
        type: 'number'
      },
      country: {
        enum: countryValues,
        enumNames: countries.map(function(c)  {return c.name;})
      },
      active: {
        type: 'boolean'
      }
    });
    var data = generateData({
      amount: 100,
      fieldGenerators: getFieldGenerators(countryValues),
      properties: properties
    });
    data = attachIds(data);
    var editable = cells.edit.bind(this, 'editedCell', function(value, celldata, rowIndex, property)  {
      var idx = findIndex(this.state.data, {
        id: celldata[rowIndex].id
      });

      this.state.data[idx][property] = value;

      this.setState({
        data: data
      });
    }.bind(this));
    var formatters = {
      country: function(country)  {return find(countries, 'value', country).name;},
      salary: function(salary)  {return parseFloat(salary).toFixed(2);}
    };
    var highlight = Search.highlight(function()  {return this.state.search.query;}.bind(this));

    return {
      editedCell: null,
      data: data,
      formatters: formatters,
      search: {
        query: '',
        column: ''
      },
      header: {
        onClick: function(column)  {
          // reset edits
          this.setState({
            editedCell: null
          });

          sortColumn(
            this.state.columns,
            column,
            this.state.data,
            this.setState.bind(this)
          );
        }.bind(this)
      },
      columns: [
        {
          property: 'name',
          header: 'Name',
          cell: [editable({
            editor: editors.input()
          }), highlight]
        },
        {
          property: 'position',
          header: 'Position'
        },
        {
          property: 'country',
          header: 'Country',
          search: formatters.country,
          cell: [editable({
            editor: editors.dropdown(countries)
          }), formatters.country, highlight]
        },
        {
          property: 'salary',
          header: 'Salary',
          search: formatters.salary,
          cell: formatters.salary
        },
        {
          property: 'active',
          header: 'Active',
          cell: [
            editable({
              editor: editors.boolean()
            }),
            function(active)  {return active && React.createElement("span", null, "✓");}
          ]
        },
        {
          cell: function(value, celldata, rowIndex) {
            var idx = findIndex(this.state.data, {
              id: celldata[rowIndex].id
            });

            var edit = function()  {
              var schema = {
                type: 'object',
                properties: properties
              };

              var onSubmit = function(data, value)  {
                this.refs.modal.hide();

                if(value === 'Cancel') {
                  return;
                }

                this.state.data[idx] = data;

                this.setState({
                  data: this.state.data
                });
              }.bind(this);

              var getButtons = function(submit)  {
                return (
                  React.createElement("span", null,
                    React.createElement("input", {type: "submit",
                      className: "pure-button pure-button-primary ok-button",
                      key: "ok", value: "OK",
                      onClick: submit}),
                    React.createElement("input", {type: "submit",
                      className: "pure-button cancel-button",
                      key: "cancel", value: "Cancel",
                      onClick: submit})
                  )
                );
              };

              this.setState({
                modal: {
                  title: 'Edit',
                  content: React.createElement(Form, {
                    className: "pure-form pure-form-aligned",
                    fieldWrapper: FieldWrapper,
                    sectionWrapper: SectionWrapper,
                    buttons: getButtons,
                    schema: schema,
                    validate: validate,
                    values: this.state.data[idx],
                    onSubmit: onSubmit})
                }
              });

              this.refs.modal.show();
            }.bind(this);

            var remove = function()  {
              // this could go through flux etc.
              this.state.data.splice(idx, 1);

              this.setState({
                data: this.state.data
              });
            }.bind(this);

            return {
              value: (
                React.createElement("span", null,
                  React.createElement("span", {className: "edit", onClick: edit.bind(this), style: {cursor: 'pointer'}},
                    "⇙"
                  ),
                  React.createElement("span", {className: "remove", onClick: remove.bind(this), style: {cursor: 'pointer'}},
                    "✗"
                  )
                )
              )
            };
          }.bind(this)
        },
      ],
      modal: {
        title: 'title',
        content: 'content'
      },
      pagination: {
        page: 0,
        perPage: 10
      }
    };
  },

  render:function() {
    var header = this.state.header;
    var columns = this.state.columns;
    var data = this.state.data;
    var searchData = Search.search(
      this.state.search,
      this.state.columns,
      this.state.data
    );

    var pagination = this.state.pagination;

    var paginated = Paginator.paginate(searchData, pagination);

    return (
      React.createElement("div", null,
        React.createElement("div", {className: "controls"},
          React.createElement("div", {className: "per-page-container"},
            "Per page ", React.createElement("input", {type: "text", defaultValue: pagination.perPage, onChange: this.onPerPage})
          ),
          React.createElement("div", {className: "search-container"},
            "Search ", React.createElement(Search, {columns: columns, onChange: this.setState.bind(this)})
          )
        ),
        React.createElement(Table, {className: "pure-table pure-table-striped", header: header, columns: columns, data: paginated.data},
          React.createElement("tfoot", null,
            React.createElement("tr", null,
              React.createElement("td", null,
                "You could show sums etc. here in the customizable footer."
              ),
              React.createElement("td", null),
              React.createElement("td", null),
              React.createElement("td", null),
              React.createElement("td", null),
              React.createElement("td", null)
            )
          )
        ),
        React.createElement("div", {className: "controls"},
          React.createElement("div", {className: "pagination"},
            React.createElement(Paginator, {
              page: paginated.page,
              pages: paginated.amount,
              beginPages: 3,
              endPages: 3,
              onSelect: this.onSelect})
          )
        ),
        React.createElement(SkyLight, {ref: "modal", title: this.state.modal.title}, this.state.modal.content)
      )
    );
  },

  onSelect:function(page) {
    var pagination = this.state.pagination || {};

    pagination.page = page;

    this.setState({
      pagination: pagination
    });
  },

  onPerPage:function(e) {
    var pagination = this.state.pagination || {};

    pagination.perPage = parseInt(e.target.value, 10);

    this.setState({
      pagination: pagination
    });
  }
});

function augmentWithTitles(o) {
  for (var property in o) {
    o[property].title = titleCase(property);
  }

  return o;
}

function getFieldGenerators(countryValues) {
  return {
    name: function() {
      var forenames = ['Jack', 'Bo', 'John', 'Jill', 'Angus', 'Janet', 'Cecilia',
        'Daniel', 'Marge', 'Homer', 'Trevor', 'Fiona', 'Margaret', 'Ofelia'];
      var surnames = ['MacGyver', 'Johnson', 'Jackson', 'Robertson', 'Hull', 'Hill'];

      return math.pick(forenames) + ' ' + math.pick(surnames);
    },
    position: function() {
      var positions = ['Boss', 'Contractor', 'Client'];

      return math.pick(positions);
    },
    salary: generators.number.bind(null, 0, 100000),
    country: function() {
      return math.pick(countryValues);
    }
  };
}

function attachIds(arr) {
  return arr.map(function(o, i)  {
    o.id = i;

    return o;
  });
}

function find(arr, key, value) {
  return arr.reduce(function(a, b)  {return a[key] === value? a: b[key] === value && b;});
}
