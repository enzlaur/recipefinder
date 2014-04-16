/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $("#rname").on("change", rnameChanged);
    $("#price").on("change", priceChanged);
    $("#serving").on("change", servingChanged);
    $("#time").on("change", timeChanged);
    $("#procedures").on("change", proceduresChanged);
    $("#add-recipe").on("submit", addFormSubmit);
    /*ingredients*/
    $("#add-ingredient").on("click", addIngredients);
    $("#ingredients-table").delegate(".ingredient-name", "click", ingredientNameClicked);
    $("#ingredients-table").delegate(".delete-ingredient", "click", deleteIngredientClicked);
});

function rnameChanged(){
    $(this).css("color","black");

    if($("#rname").val()=="")
    {
        $("#error-rname").html("Required").css("color", "red");
    }
}

function priceChanged(){
    $(this).css("color","black");

    if($("#price").val()=="")
    {
        $("#error-price").html("Required").css("color", "red");
    }
}

function servingChanged(){
    $(this).css("color","black");

    if($("#serving").val()=="")
    {
        $("#error-serving").html("Required").css("color", "red");
    }
}

function timeChanged(){
    $(this).css("color","black");

    if($("#time").val()=="")
    {
        $("#error-time").html("Required").css("color", "red");
    }
}

function proceduresChanged(){
    $(this).css("color","black");

    if($("#procedures").val()=="")
    {
        $("#error-procedures").html("Required").css("color", "red");
    }
}

function addFormSubmit(){
    $.post("AddRecipeServlet", "purpose=add-recipe&" + $("#add-recipe").serialize())
    .done(function(data,textStatus, jqXHR){
        if(data.status == "success"){
           $("#add-recipe-message").html(data.data);
        }
        else if(data.status=="failed"){
            var fieldErrors = data.data.fieldErrors;
            $("#add-recipe-message").html(data.data.errorSummary);
            $("#error-rname").html(fieldErrors.rname).css("color", "red"); 
            $("#error-price").html(fieldErrors.price).css("color", "red"); 
            $("#error-serving").html(fieldErrors.serving).css("color", "red");
            $("#error-time").html(fieldErrors.time).css("color", "red"); 
            $("#error-procedures").html(fieldErrors.procedures).css("color", "red"); 
            $("#error-ingredients").html(fieldErrors.ingredients).css("color", "red"); 
        }
    });
    
    return false;
}

function addIngredients(e)
{
    e.preventDefault();
    $("#ingredients-table").append
        ("<tr>" + 
        "<td><input name='ingredient-quantity' class='ingredient-quantity' /></td>" + 
        "<td>" + 
        "   <input name='ingredient-id' class='ingredient-id' type='hidden' />" + 
        "   <input class='ingredient-name' readonly='readonly' />" + 
        "</td>" + 
        "<td><input name='ingredient-description' class='ingredient-description' /></td>" +
        "<td><span class='ingredient-category'></span></td>" + 
        "<td><a href='#' class='delete-ingredient'>Delete</a></td>" +
        "</tr>");
    return false;
}


function ingredientNameClicked(e){
    var w = 400;
    var h = 400;
    var left = (screen.width/2)-(w/2);
    var top = (screen.height/2)-(h/2);
    window.open(baseUrl + "/ingredient-options.jsp", "Ingredients", "width=" + w + ", height=" + h + ", resizable=no, top=" + top + ", left="+ left +"");
    $ingredientRow = $(e.currentTarget).closest("tr");
}

function deleteIngredientClicked(e){
    e.preventDefault();
    $(e.currentTarget).closest("tr").remove();
    return false;
}

function ingredientOptionsCallback(ingId, ingName, ingCategory){

    $ingredientRow.find(".ingredient-id").val(ingId);
    $ingredientRow.find(".ingredient-name").val(ingName);
    $ingredientRow.find(".ingredient-category").text(ingCategory);
   
}