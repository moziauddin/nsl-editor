var json_result = <%=raw(@response)%>;

function recursivelyAdd(json, block) {
    console.log(json);
    var subblock
    if (json.message) {
        var subblock = $("<div style='padding-left: 1em;'>"+json.message+"</div>");
        block.append(subblock);
    }
    else {
        var subblock = $("<div style='padding-left: 1em;'><span class='text-" + json.status + "'><b>" + json.msg + "</b> " + json.body + "</span></div>");
        block.append(subblock);
    }
    if (json.nested) {
        for(i in json.nested) {
            recursivelyAdd(json.nested[i], subblock);
        }
    }
}


if (json_result.success) {
    $('#instance-classification-tab').click();
}
else {
    var block = $("#place_name_error_block");
    block.empty();
    block.append("<div class='text-danger'><b><u>Could not update values</u></b></div>");

    for (var i in json_result.msg) {
        recursivelyAdd(json_result.msg[i], block);
    }

}
