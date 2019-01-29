//= require ./components/general_table
//= require ./components/dr_table
//= require react
//= require react_ujs

var React = require('react');
var ReactDOM = require('react-dom');
var SideMenu = require('components/treeview.jsx');
var XlsxImport = require('components/xlsx-import.jsx');
var CompareProjects = require('components/compare-projects.jsx');
var GenerateDbm = require('components/generate-dbm.jsx');

import Modal from 'react-modal';

$(document).ready(function() {
  var appElement3 = document.getElementById('left_menu');
  if (appElement3) {
    ReactDOM.render(
      <SideMenu dataSource={menu_data} key={'left-menu'} />,
      appElement3
    );
  }
  var appElement = document.getElementById('import_xlsx_modal');
  if (appElement) {
    Modal.setAppElement(appElement);
    ReactDOM.render(<XlsxImport key={'xlsx-import'} />, appElement);
  }
  var appElement2 = document.getElementById('navbar_compare_projects');
  if (appElement2) {
    Modal.setAppElement(appElement2);
    ReactDOM.render(<CompareProjects key={'compare-projects'} />, appElement2);
  }

  var appElement1 = document.getElementById('navbar_generate_dbm_modal');
  if (appElement1) {
    Modal.setAppElement(appElement1);
    ReactDOM.render(<GenerateDbm key={'generate-dbm'} />, appElement1);
  }
});
