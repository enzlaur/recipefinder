<%-- 
    Document   : edit-ingredient.jsp
    Created on : Apr 14, 2014, 3:57:00 AM
    Author     : cheskaalindao
--%>

<%@page import="DatabaseTransactions.IngredientsDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    
        if (session.getAttribute("id") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-sign-in.jsp");
        return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        ResultSet allCategories = IngredientsDataContext.getAllCategories();
        ResultSet ingredient = IngredientsDataContext.getIngredientToEdit(id);
        
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Ingredient</title>
        
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/logout.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/edit-ingredient.js" type="text/javascript"></script>

        <link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="css/base.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="css/recipe.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="js/jquery.pikachoose.js"></script>
        <script type="text/javascript">
                            $(document).ready(function() {
                            $("#pikame").PikaChoose();	});
        </script>
    </head>
    <body>
        <div id="container">
            <header>
                <nav>
                    <ul id="nav">
                        <li><a href="admin-index.jsp">Home</a></li>
                        <li><a href="admin-add-recipe.jsp">Add recipe</a></li>
                        <li><a href="ingredient-list.jsp" style="font-size:17px;" class="current">Ingredients</a></li>
                        <li><a id="logout" href="admin-sign-in.jsp">Log out</a></li>
                        <!--- <li><a href="account.html">Account</a></li>-->
                    </ul>
                </nav>
            </header>

             <div class="wrapper">
                <article class="menu">
                    <div class="border"></div>
                    <h4>Edit ingredient</h4>
                    <div class="border2"></div>

                    <br><br>

                    <center>
                        <span id="error-message"></span>
                        <%ingredient.next();%>
                        <form id="edit-ingredient" method="post" action="EditIngredientServlet">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="id-name" value="<%=ingredient.getString("ingredient")%>">
                            <input type="text" name="name" id="name" value="<%=ingredient.getString("ingredient")%>" placeholder="Ingredient"  /><span id="error-name"></span>
                            <br/><br/>
                            <select id="category" name="category">
                                <% while(allCategories.next()){
                                    String selected = ingredient.getString("category");
                                    String selectedProperty = "";
                                    if(allCategories.getString("name").equals(selected)){
                                        selectedProperty = "selected=selected";
                                    }
                                %>
                                <option value="<%=allCategories.getInt("id")%>" <%=selectedProperty%>><%=allCategories.getString("name")%></option>
                                <%}%>
                            </select>
                            <br/><br/><br/>
                            <input class="button" type="submit" value="Save" />
                        </form>
                    </center>

                </article>
            </div>
        </div>
    </body>
</html>
