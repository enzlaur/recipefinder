/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $("#signin-form").bind("submit", signinFormClicked);
});

function signinFormClicked(e){
    e.preventDefault();
    
    $.post("LoginServlet", $("#signin-form").serialize())
    .done(function(){
        location = "/RecipeFinder/admin-index.jsp";
    })
    .fail(function(jqXHR, responseText, errorThrown){
        alert(jqXHR.responseText);
    });
    
    return false;
}


