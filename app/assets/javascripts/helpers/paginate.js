'use strict'
function paginate(data, o) {
    data = data || [];

    // adapt to zero indexed logic
    var page = o.page - 1 || 0;
    var perPage = o.perPage;

    var amountOfPages = Math.ceil(data.length / perPage);
    var startPage = page < amountOfPages? page: 0;

    return {
        amount: amountOfPages,
        data: data.slice(startPage * perPage, startPage * perPage + perPage),
        page: startPage
    };
}

module.exports = paginate;


//export default function paginate({ page, perPage }) {
//  return (rows = []) => {
//    // adapt to zero indexed logic
//    const p = page - 1 || 0;
//
//    const amountOfPages = Math.ceil(rows.length / perPage);
//    const startPage = p < amountOfPages ? p : 0;
//
//    return {
//      amount: amountOfPages,
//      rows: rows.slice(startPage * perPage, startPage * perPage + perPage),
//      page: startPage
//    };
//  };
//}
//

