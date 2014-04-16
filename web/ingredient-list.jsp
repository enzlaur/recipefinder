<%-- 
    Document   : ingredient-list
    Created on : Apr 14, 2014, 12:46:24 AM
    Author     : cheskaalindao
--%>

<%@page import="DatabaseTransactions.IngredientsDataContext"%>
<%@page import="DatabaseTransactions.RecipeDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("id") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-sign-in.jsp");
        return;
    }
    
    String key="";
    key = request.getParameter("search");
    ResultSet ingredients = IngredientsDataContext.getAllIngredients("");
    if(key!=null)
    {
        ingredients = IngredientsDataContext.getAllIngredients(key);
    }
    
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingredients</title>
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/logout.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/delete-ingredient.js" type="text/javascript"></script>

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
                    <table>
                        <tr>
                            <td width="500px">
                                <h4>Ingredients</h4>
                            </td>
                            <td width="500px">
                                <a  style="float:right" href="add-ingredient.jsp" class="button">Add Ingredient</a>
                            </td>
                        </tr>
                    </table>
                    <div class="border2"></div>

                    <br>
                    
                    <div class="border"></div>
                    <center>
                        <br>
                        <form>
                            <span class="phone-number">
                                <input type="text" name="search" placeholder="Ingredient">
                            </span>

                            <div class="email-us"> <button type="submit" class="button">Find ingredient</button> </div>
                        </form>
                        <br>
                    </center>
                    
                    <div class="border2"></div>

                    <br><br>

                    <div class="ingredient-list">
                        <center>
                        <table style="border:1px dashed #9c5959">
                            <tr style="border:1px solid #9c5959; text-align:center">
                                <td style="border:1px solid #9c5959"><h6>Ingredient Name</h6></td>
                                <td style="border:1px solid #9c5959"><h6>Category</h6></td>
                                <td style="border:1px solid #9c5959"></td>
                                <td style="border:1px solid #9c5959"></td>
                            </tr>
                            <%while(ingredients.next()){%>
                                <tr style="border:1px dashed #9c5959; text-align: center">
                                    <td width="300px"><%=ingredients.getString("ingredient")%></td>
                                    <td width="30%"><%=ingredients.getString("category")%></td>
                                    <td width="100px"><strong><a href="edit-ingredient.jsp?id=<%=ingredients.getString("id")%>">Edit</a></strong></td>
                                    <td width="100px"><strong><a style="cursor:pointer" data-ingid="<%=ingredients.getInt("id")%>" class="btndelete">Delete</a></strong></td>
                                </tr>
                            <%}%>
                        </table>
                        </center>
                    </div>
                </article>
            </div>        
        </div>
    </body>
</html>
