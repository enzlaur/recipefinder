/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $("#name").on("change", nameChanged);
    $("#add-ingredient").on("submit", addIngredientSubmit);
});

function nameChanged(){      
    $.post("AddIngredientServlet", "purpose=validate-ingredient&" + $("#name").serialize())
    .done(function(data,textStatus, jqXHR){
        $("#error-name").html(data.message);
    });
}


function addIngredientSubmit(){
    $.post("AddIngredientServlet", "purpose=add-ingredient&" + $("#add-ingredient").serialize())
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