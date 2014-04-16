/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#name").on("change", nameChanged);
    $("#edit-ingredient").on("submit", editIngredientSubmit);
});

function nameChanged(){      
    $.post("EditIngredientServlet", "purpose=validate-ingredient&" + $("#edit-ingredient").serialize())
    .done(function(data,textStatus, jqXHR){
        $("#error-name").html(data.message);
    });
}


function editIngredientSubmit(){
    $.post("EditIngredientServlet", "purpose=edit-ingredient&" + $("#edit-ingredient").serialize())
    .done(function(data,textStatus, jqXHR){
        if(data.status == "success"){
           $("#error-message").html(data.data);
        }
        else if(data.status=="failed"){
            var fieldErrors = data.data.fieldErrors;
            $("#error-message").html(data.data.errorSummary);
            $("#error-name").html(fieldErrors.name).css("color", "red");
        }
    });
    
    return false;
}
