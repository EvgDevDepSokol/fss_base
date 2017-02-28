//= require ./components/xlsx-import
//= require ./components/general_table

//= require react
//= require react_ujs

var React = require('react');
var ReactDOM = require('react-dom');
var SideMenu = require('components/treeview.jsx');
var XlsxImport = require('components/xlsx-import.jsx');
var App = require('components/xlsx-export.jsx');
//var ReplaceConfirm = require('components/replace_confirm.jsx');
var Modal = require('react-modal');

$(document).ready(function () {
  ReactDOM.render(
    <SideMenu dataSource={menu_data} key={"left-menu"} />,
    document.getElementById('left_menu')
  );

  var appElement = document.getElementById('import_xlsx_modal');
  Modal.setAppElement(appElement);
  ReactDOM.render(<XlsxImport key={"xlsx-import"} />, appElement);

//  var appElement1 = document.getElementById('replace_confirm_modal');
//  Modal.setAppElement(appElement1);
//  ReactDOM.render(<ReplaceConfirm key={"replace_confirm"} />, appElement1);

//  var appElement1 = document.getElementById('export_to_excel');
//  Modal.setAppElement(appElement1);
//  ReactDOM.render(<App key={"export-to-excel"} />, appElement1);
});
