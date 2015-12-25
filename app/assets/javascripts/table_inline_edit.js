/**
 * Created by denstepa on 12.03.15.
 */

$( document ).ready(function() {

    var defaults = {
        mode: 'inline',
        toggle: 'manual',
        showbuttons: false,
        onblur: 'ignore',
        inputclass: 'input-small',
        savenochange: true,
        success: function() {
            return false;
        }
    };
    $.extend($.fn.editable.defaults, defaults);

    $('.table.editable-table .edit').click(function(){
        // скрываем другие строки
        $('.table.editable-table').find('.editable-open').editable('hide');
        $('.table.editable-table').find('.btn-primary').hide();
        $('.table.editable-table').find('.edit').show();

        $(this).hide().siblings('.btn-primary').show();

        setEditables($(this).closest('tr'));


        $(this).closest('tr').addClass('editable-raw');
    });

    $('.table.editable-table .save').click(function() {
        var $btn = $(this);
        //debugger;

        var inputs = $('.table.editable-table').find('form input');
        $(this).closest('tr').removeClass('editable-raw');
        values2 = {};
        inputs.each(function(index){
            var editable = $(this).closest("td").children('.editable');
            var key = $(editable).data('attribute');
            var value = this.value;
            values2[key] = value;
            //$(editable).addClass("editable-unsaved");
            $(editable).addClass("editable-bg-transition");
            $(editable).text(this.value);

        });

        // hilight row
        var row =  $(this).closest("tr");
        bgColor = row.css('background-color');
        row.css('background-color', "#FFFF80");


        //post server data
        var data = {};
        data[modelName] = values2;

        url = $(this).data("url");

        //debugger;
        $.ajax
        ({
            url: url,
            type: "PUT",
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: "application/json",
            processData: false,
            success: function (msg)
            {
                //debugger;
                console.log(msg);
                setValues(row, msg);
                restoreColor(row, bgColor);
            },
            error: function (xhr, status, error)
            {
                console.log(xhr);
                var parsed = JSON.parse(xhr.responseText);
                console.log(parsed);
                setValues(row, parsed);
                restoreColor(row, bgColor);
            }
        });

        console.log(values2);

        $btn.closest('tr').find('.editable').editable('hide');
        $btn.hide().siblings('.edit').show();
    });

    function restoreColor(row, bgColor){
        setTimeout(function(){
            if(bgColor === 'transparent') {
                bgColor = '';
            }
            row.css('background-color', bgColor);
            row.addClass('editable-bg-transition');
            setTimeout(function(){
                row.removeClass('editable-bg-transition');
            }, 1700);
        }, 10);
    }

    function setValues(row, object){
        //debugger;
        var editables = $(row).find('.editable');
        editables.each(function(index){
            if($(this).data('name'))
            {
                attr = $(this).data('name');
            }else
            {
                attr = $(this).data('attribute');
            }
            //$(row).find('.editable[data-slide=' + current +' ]');
            $(this).text(object.data[attr]);
            //$(this).removeClass("editable-unsaved");
            $(this).removeClass("editable-bg-transition");
        });
    }

    function setEditables(row){
        //debugger;
        row.find('.editable').each(function(index, value){
            console.log($(value).attr('id'));
            //debugger;
            switch ($(value).attr('id')){
                case "system":
                    $(value).editable({
                        select2: {
                            placeholder: 'Select System',
                            allowClear: true,
                            minimumInputLength: 0,
                            id: function (item) {
                                return item.id;
                            },
                            ajax: {
                                url: '/pds_syslists',
                                dataType: 'json',
                                data: function (term, page) {
                                    return { query: term };
                                },
                                results: function (data, page) {
                                    return { results: data };
                                }
                            },
                            formatResult: function (item) {
                                return item.System;
                            },
                            formatSelection: function (item) {
                                return item.System;
                            },
                            initSelection: function (element, callback) {
                                return $.get('/pds_syslists/' + element.val(),
                                    {},
                                    function (data) {
                                    callback(data);
                                }, "json");
                            }
                        }
                    });
                    break;
                default:
                    break;

            }
        });
      row.find('.editable').editable('show');
    }


/*    $('#system').editable({
        select2: {
            placeholder: 'Select Country',
            allowClear: true,
            minimumInputLength: 3,
            id: function (item) {
                return item.CountryId;
            },
            ajax: {
                url: '/getCountries',
                dataType: 'json',
                data: function (term, page) {
                    return { query: term };
                },
                results: function (data, page) {
                    return { results: data };
                }
            },
            formatResult: function (item) {
                return item.CountryName;
            },
            formatSelection: function (item) {
                return item.CountryName;
            },
            initSelection: function (element, callback) {
                return $.get('/getCountryById', { query: element.val() }, function (data) {
                    callback(data);
                });
            }
        }
    });*/

});
