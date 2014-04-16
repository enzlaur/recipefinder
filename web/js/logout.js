/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    $("#logout").on("click", logoutClicked);
});
        
function logoutClicked(){
    $.post("LogoutServlet")
    .done(function(){
        location = "/RecipeFinder/admin-sign-in.jsp";
    });
    return false;
}

