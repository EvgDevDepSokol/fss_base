// require_tree ./components
//= require ./components/xlsx-import
//= require ./components/general_table

//= require react
//= require react_ujs
//= require components

//var React = require('react');
//var TableContainer = require('components/general_table.jsx');


var React = require('react');
var ReactDOM = require('react-dom');
var SideMenu = require('components/treeview.jsx');
var XlsxImport = require('components/xlsx-import.jsx');
var Modal = require('react-modal');
var ProjectShortSelector =  require('selectors/static_project_short.jsx') 


$(document).ready(function () {
  ReactDOM.render(
    <SideMenu dataSource={menu_data} key={"left-menu"} />,
    document.getElementById('left_menu')
  );

  var appElement = document.getElementById('import_xlsx_modal');
  Modal.setAppElement(appElement);
  ReactDOM.render(<XlsxImport key={"xlsx-import"} />, appElement);

//  var appElement = document.getElementById('select_project');
//  Modal.setAppElement(appElement);
//  ReactDOM.render(<ProjectShortSelector key={"select_project"} />, appElement);
});
