// require_tree ./components
//= require ./components/xlsx-import
//= require ./components/general_table

//var React = require('react');
//var TableContainer = require('components/general_table.jsx');


var React = require('react');
var SideMenu = require('components/treeview.jsx');

var XlsxImport = require('components/xlsx-import.jsx');
var Modal = require('react-modal');


$(document).ready(function () {
  React.render(
    <SideMenu dataSource={menu_data} key={"left-menu"} />,
    document.getElementById('left_menu')
  );

  var appElement = document.getElementById('import_xlsx_modal');
  Modal.setAppElement(appElement);
  Modal.injectCSS();
  React.render(<XlsxImport key={"xlsx-import"} />, appElement);

});
