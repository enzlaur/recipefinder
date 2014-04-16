/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $(".recipelist").delegate(".btndelete","click",deleteClicked);
});

function deleteClicked(){      
    var recipeId = $(this).attr("data-recipeid");
    var message = confirm("Are you sure you want to delete this recipe?");
    
    if(message == true){
        $.post("DeleteRecipeServlet", "recipeid=" + recipeId)
        .done(function(data,textStatus, jqXHR){
           location = "/RecipeFinder/admin-index.jsp";
        });
    }
    
}