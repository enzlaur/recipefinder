<%--
    Document   : admin-add-recipe
    Created on : Apr 11, 2014, 10:19:29 AM
    Author     : cheskaalindao
--%>

<%@page import="DatabaseTransactions.RecipeDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ResultSet  allMealTypes = RecipeDataContext.getAllPreferences("Meal Type");
    ResultSet  allCuisines = RecipeDataContext.getAllPreferences("Cuisine");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Recipe</title>
        <script>baseUrl = "<%=request.getContextPath()%>";</script>
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/logout.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/add-recipe.js" type="text/javascript"></script>
        
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
                        <li><a href="admin-index.jsp" >Home</a></li>
                        <li><a href="#" class="current">Add recipe</a></li>
                        <li><a href="ingredient-list.jsp" style="font-size:17px;">Ingredients</a></li>
                        <li><a id="logout" href="admin-sign-in.jsp">Log out</a></li>
                        <!--- <li><a href="account.html">Account</a></li>-->
                    </ul>
                </nav>
            </header>

            <div class="wrapper">
                <article class="menu">
                    <div class="border"></div>
                    <h4>Add Recipe</h4>
                    <div class="border2"></div>

                    <br>

                    <center>
                        <span id="add-recipe-message"></span>
                        
                         
                        <form id="add-recipe" method="post" action="AddRecipeServlet">            
                        <table style="border:1px dashed #9c5959">            
                            <tr style="border:1px dashed #9c5959">
                                <td width="30%"><center><h6>Recipe Name</h6></center></td>
                                <td>
                                    <input id="rname" name="rname" type="text" style="width:500px;" placeholder="Recipe Name"><br/>
                                    <span id="error-rname"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Category</h6></center></td>
                                <td>
                                    <strong>Meal Type:</strong>
                                    <select id="meal-type" name="meal-type">
                                        
                                        <%while(allMealTypes.next()){%>
                                        <option value="<%=allMealTypes.getInt("id")%>"><%=allMealTypes.getString("name")%></option>
                                        <%}%>   
                                    </select>
                                    
                                    <strong>Cuisine:</strong>
                                    <select id="cuisine" name="cuisine">
                                        
                                        <%while(allCuisines.next()){%>
                                        <option value="<%=allCuisines.getInt("id")%>"><%=allCuisines.getString("name")%></option>
                                        <%}%>
                                    </select>  
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Description</h6></center></td>
                                <td>
                                    <textarea id="description" name="description" placeholder="Description" cols="60" rows="10"></textarea>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Price</h6></center></td>
                                <td>
                                    <input id="price" name="price" type="text" style="width:500px;" placeholder="Price">
                                    <span id="error-price"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Serving</h6></center></td>
                                <td>
                                    <input id="serving" name="serving" type="text" style="width:500px;" placeholder="Serving">
                                    <span id="error-serving"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Time</h6></center></td>
                                <td>
                                    <input id="time" name="time" type="text" style="width:500px;" placeholder="Time">
                                    <span id="error-time"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Ingredients</h6></center></td>
                                <td>
                                    <span id="error-ingredients"></span>
                                    <table id="ingredients-table">
                                        <thead>
                                            <tr style="text-align:center;">
                                                <th style="width:160px"><strong>Quantity</strong></th>
                                                <th style="width:160px"><strong>Ingredient</strong></th>
                                                <th style="width:160px"><strong>Description</strong></th>
                                                <th style="width:160px"><strong>Category</strong></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                    <div id="ingredients-td">

                                    </div>
                                    <br/>
                                    <button id="add-ingredient" class="button">Add ingredient</button>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Procedures</h6></center></td>
                                <td>
                                    <textarea id="procedures" name="procedures" placeholder="Procedures" cols="60" rows="20"></textarea>
                                    <span id="error-procedures"></span>
                                </td>
                            </tr>
                        </table>
                        <button type="submit" class="button" href="">Add</button>
                        </form>
                    </center>
                </article>
            </div>
        </div>

    </body>
</html>
