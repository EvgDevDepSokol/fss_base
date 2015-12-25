/* require XLSX */
// var XLSX = require('XLSX')

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
    ws[cell_ref] = {v: columns[C].header, t: 's' };
  }

  for(var R = 0; R < data.length; R++) {
    var object = flattenObject(data[R]);

    //debugger;
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

function s2ab(s) {
  var buf = new ArrayBuffer(s.length);
  var view = new Uint8Array(buf);
  for (var i=0; i!=s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
  return buf;
}


function exportData(data, columns){

  //debugger;
  /* original data */
  var ws_name = "SheetJS";

  function Workbook() {
    if(!(this instanceof Workbook)) return new Workbook();
    this.SheetNames = [];
    this.Sheets = {};
  }

  var wb = new Workbook(), ws = sheet_from_data_and_cols(data, columns);

  /* add worksheet to workbook */
  wb.SheetNames.push(ws_name);
  wb.Sheets[ws_name] = ws;

  /* bookType can be 'xlsx' or 'xlsm' or 'xlsb' */
  var wopts = { bookType:'xlsx', bookSST:false, type:'binary' };

  var wbout = XLSX.write(wb,wopts);

  /* the saveAs call downloads a file on the local machine */
  saveAs(new Blob([s2ab(wbout)],{type:""}), "test.xlsx");
}

function workbook_to_json(workbook) {
  var result = [];
  workbook.SheetNames.forEach(function(sheetName) {
    var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
    //debugger;
    if(roa.length > 0){
      result.push({sheetName: sheetName, data: roa});
      //result[sheetName] = roa;
    }
  });
  return result;
}

function importFileData(file){
  var reader = new FileReader();
  var name = file.name;
  reader.onload = function(e) {
    debugger;
    var importData = e.target.result;
    var workbook = XLSX.read(importData, {type: 'binary'});
    var jsonImportData = workbook_to_json(workbook);
    /* DO SOMETHING WITH workbook HERE */
  };
  reader.readAsBinaryString(file);
}