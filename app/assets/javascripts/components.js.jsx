// require ./components/xlsx-import
//= require ./components/general_table
// require ./components/generate-dbm
//= require react
//= require react_ujs

var React = require('react');
var ReactDOM = require('react-dom');
var SideMenu = require('components/treeview.jsx');
var XlsxImport = require('components/xlsx-import.jsx');
var GenerateDbm = require('components/generate-dbm.jsx');
import Modal from 'react-modal';

$(document).ready(function() {
  ReactDOM.render(
    <SideMenu dataSource={menu_data} key={'left-menu'} />,
    document.getElementById('left_menu')
  );

  var appElement = document.getElementById('import_xlsx_modal');
  Modal.setAppElement(appElement);
  ReactDOM.render(<XlsxImport key={'xlsx-import'} />, appElement);

  var appElement1 = document.getElementById('navbar_generate_dbm_modal');
  Modal.setAppElement(appElement1);
  ReactDOM.render(<GenerateDbm key={'generate-dbm'} />, appElement1);
});
