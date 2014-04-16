/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $(".ingredient-list").delegate(".btndelete","click",deleteClicked);
});

function deleteClicked(){      
    var ingId = $(this).attr("data-ingid");
    var message = confirm("Are you sure you want to delete this ingredient?");
    
    if(message == true){
        $.post("DeleteIngredientServlet", "ingId=" + ingId)
        .done(function(data,textStatus, jqXHR){
           location = "/RecipeFinder/ingredient-list.jsp";
        });
    }
    
}