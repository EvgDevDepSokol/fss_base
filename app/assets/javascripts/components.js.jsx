// require_tree ./components
//= require ./components/xlsx-import
//= require ./components/general_table
//= require ./components/replace_confirm

//= require react
//= require react_ujs
//= require components

var React = require('react');
var ReactDOM = require('react-dom');
var SideMenu = require('components/treeview.jsx');
var XlsxImport = require('components/xlsx-import.jsx');
var ReplaceConfirm = require('components/replace_confirm.jsx');
var Modal = require('react-modal');

$(document).ready(function () {
  ReactDOM.render(
    <SideMenu dataSource={menu_data} key={"left-menu"} />,
    document.getElementById('left_menu')
  );

  var appElement = document.getElementById('import_xlsx_modal');
  Modal.setAppElement(appElement);
  ReactDOM.render(<XlsxImport key={"xlsx-import"} />, appElement);

 // var appElement1 = document.getElementById('replace_confirm_modal');
 // Modal.setAppElement(appElement1);
 // ReactDOM.render(<ReplaceConfirm key={"replace_confirm"} />, appElement1);
});
