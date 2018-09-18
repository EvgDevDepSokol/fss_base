import XLSX from 'xlsx'

var flattenObject = function(ob) {
  var toReturn = {};
  var flatObject;
  for (var i in ob) {
    if (!ob.hasOwnProperty(i)) {
      continue;
    }
    if ((typeof ob[i]) === 'object') {
      flatObject = flattenObject(ob[i]);
      for (var x in flatObject) {
        if (!flatObject.hasOwnProperty(x)) {
          continue;
        }
        toReturn[i + (!!isNaN(x) ? '.' + x : '')] = flatObject[x];
      }
    } else {
      toReturn[i] = ob[i];
    }
  }
  return toReturn;
};

function datenum(v, date1904) {
  if(date1904) v+=1462;
  var epoch = Date.parse(v);
  return (epoch - new Date(Date.UTC(1899, 11, 30))) / (24 * 60 * 60 * 1000);
}

Object.byString = function(o, s) {
  s = s.replace(/\[(\w+)\]/g, '.$1');  // convert indexes to properties
  s = s.replace(/^\./, ''); // strip leading dot
  var a = s.split('.');
  for (var i = 0, n = a.length; i < n; ++i) {
    var n = a[i];
    if (n in o) {
      o = o[n];
    } else {
      return;
    }
  }
  return o;
};

function sheet_from_data_and_cols(data, columns) {
  var ws = {};
  var range = {s:  {c:0, r:0 }, e: {c: columns.length, r: data.length + 1}};
  for(var C = 0; C < columns.length; C++) {
    var cell_ref = XLSX.utils.encode_cell({c:C,r:0});
    var label = columns[C].label ? columns[C].label : columns[C].header;
    ws[cell_ref] = {v: label, t: 's' };
  }

  for(var R = 0; R < data.length; R++) {
    var object = flattenObject(data[R]);

    for(var C = 0; C < columns.length; ++C) {
    //  if(range.s.r > R) range.s.r = R;
    //  if(range.s.c > C) range.s.c = C;
    //  if(range.e.r < R) range.e.r = R;
    //  if(range.e.c < C) range.e.c = C;
      var value = object[columns[C].property];// Object.byString(object, columns[C].property);
      var cell = {v: value };
      if(value == null) continue;
      var cell_ref = XLSX.utils.encode_cell({c: C,r: (R+1)});

      if(typeof cell.v === 'number') cell.t = 'n';
      else if(typeof cell.v === 'boolean') cell.t = 'b';
      else if(cell.v instanceof Date) {
        cell.t = 'n'; cell.z = XLSX.SSF._table[14];
        cell.v = datenum(cell.v);
      }
     // else cell.t = 's';
      cell.t = 's';

      ws[cell_ref] = cell;
    }
  }
  //if(range.s.c < 10000000)
  ws['!ref'] = XLSX.utils.encode_range(range);
  return ws;
}

//function s2ab(s) {
//  var buf = new ArrayBuffer(s.length);
//  var view = new Uint8Array(buf);
//  for (var i=0; i!=s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
//  //for (var i=0; i!=s.length; ++i) view[i] = s.charCodeAt(i);
//  return buf;
//}


var exportData = function(data, columns, bookname){
  var wb = XLSX.utils.book_new();
  var ws = sheet_from_data_and_cols(data, columns);
  var ws_name = 'Экспорт';
  wb.SheetNames.push(ws_name);
  wb.Sheets[ws_name] = ws;
  XLSX.writeFile(wb,bookname,{ bookType:'csv'});
}

var workbook_to_json =function(workbook) {
  var result = [];
  workbook.SheetNames.forEach(function(sheetName) {
    var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName],{raw: true, defval: null});
    if(roa.length > 0){
      result.push({sheetName: sheetName, data: roa});
    }
  });
  return result;
}

function importFileData(file){
  var reader = new FileReader();
  var name = file.name;
  reader.onload = function(e) {
    var importData = e.target.result;
    var workbook = XLSX.read(importData, {type: 'binary'});
    var jsonImportData = workbook_to_json(workbook);
    /* DO SOMETHING WITH workbook HERE */
  };
  reader.readAsBinaryString(file);
}

module.exports.exportData = exportData;
module.exports.workbook_to_json = workbook_to_json;
