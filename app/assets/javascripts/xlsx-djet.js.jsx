import XLSX from 'xlsx';

function sheet_from_data_and_cols(data, columns) {
  var label = '';
  var value = '';
  var new_data = [];
  data.forEach(function(row) {
    var new_row = {};
    columns.forEach(function(column) {
      label = column.label ? column.label : column.header;
      var keys = column.property.split('.');
      if (column.nested) {
        var tempVal = row;
        keys.forEach(function(key) {
          if (tempVal) {
            tempVal = tempVal[key];
          }
        });
        if (tempVal == null) tempVal = '';
        value = tempVal;
      } else {
        value = row[column.property];
      }
      new_row[label] = value;
    });
    new_data.push(new_row);
  });
  var ws = XLSX.utils.json_to_sheet(new_data);
  return ws;
}

var exportData = function(data, columns, bookname) {
  var wb = XLSX.utils.book_new();
  var ws = sheet_from_data_and_cols(data, columns);
  var ws_name = 'Экспорт';
  XLSX.utils.book_append_sheet(wb, ws, ws_name);
  XLSX.writeFile(wb, bookname, { bookType: 'biff8' });
};

var workbook_to_json = function(workbook) {
  var result = [];
  workbook.SheetNames.forEach(function(sheetName) {
    //var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName],{raw: true, defval: null});
    var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName], {
      raw: false,
      defval: null
    });
    roa = roa.map(function(line) {
      var line1 = line;
      for (var key in line) {
        if (key.includes('__EMPTY')) {
          delete line1[key];
        }
      }
      return line1;
    });
    if (roa.length > 0) {
      result.push({ sheetName: sheetName, data: roa });
    }
  });
  return result;
};

function importFileData(file) {
  var reader = new FileReader();
  var name = file.name;
  reader.onload = function(e) {
    var importData = e.target.result;
    var workbook = XLSX.read(importData, { type: 'binary' });
    var jsonImportData = workbook_to_json(workbook);
    /* DO SOMETHING WITH workbook HERE */
  };
  reader.readAsBinaryString(file);
}

module.exports.exportData = exportData;
module.exports.workbook_to_json = workbook_to_json;
