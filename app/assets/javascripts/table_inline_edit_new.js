/**
 * Created by denstepa on 12.03.15.
 */


var HelloMessage = React.createClass({
    render: function() {
        return <div>Hello {this.props.name}</div>;
    }
});

React.render(<HelloMessage name="John" />, mountNode);


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
        $(this).closest('tr').find('.editable').editable('show');
    });

    $('.table.editable-table .save').click(function() {
        var $btn = $(this);
        //debugger;

        var inputs = $('.table.editable-table').find('form input');
        values2 = {};
        inputs.each(function(index){
            var editable = $(this).closest("td").children('.editable');
            var key = $(editable).data('name');
            var value = this.value;
            values2[key] = value;
            // update value
         //   $(editable).text(value);
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
            error: function (msg, status)
            {
                console.log(msg);
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
        var editables = $(row).find('.editable');
        editables.each(function(index){
            attr = $(this).data('name');
            //$(row).find('.editable[data-slide=' + current +' ]');
            $(this).text(object.data[attr]);
        });
    }

});
