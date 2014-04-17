<%--
    Document   : admin-edit-recipe
    Created on : Apr 11, 2014, 8:47:49 AM
    Author     : cheskaalindao
--%>

<%@page import="classes.Ingredient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Recipe"%>
<%@page import="DatabaseTransactions.RecipeDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    int id = Integer.parseInt(request.getParameter("id"));
    Recipe recipe = RecipeDataContext.getRecipe(id);
    ArrayList<Ingredient> ingredients = RecipeDataContext.getRecipeIngredients(id);
    ResultSet  allMealTypes = RecipeDataContext.getAllPreferences("Meal Type");
    ResultSet  allCuisines = RecipeDataContext.getAllPreferences("Cuisine");
    ResultSet  allCategories = RecipeDataContext.getAllCategories();
    
    String selectedMealType = "";
    int selectedMealTypeId = 0;
    ResultSet mealType = RecipeDataContext.getPreference(id,"Meal Type");
    if(mealType.next()){
        selectedMealType = mealType.getString("name");
        selectedMealTypeId = mealType.getInt("id");
    }
    
    String selectedCuisine = "";
    int selectedCuisineId = 0;
    ResultSet cuisine = RecipeDataContext.getPreference(id,"Cuisine");
    if (cuisine.next()) {
        selectedCuisine = cuisine.getString("name");
        selectedCuisineId = cuisine.getInt("id");
    }
    
    String servletCondition = "EditRecipeServlet";
    String actionCondition = "RecipePictureServlet?upload-type=recipe-pic&id=" + id;
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Recipe</title>
        <script>baseUrl = "<%=request.getContextPath()%>";</script>
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/jquery.js"></script>
        <script src="<%=request.getContextPath()%>/js/logout.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/edit-recipe.js"></script>
        
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
                        <li><a href="admin-index.jsp" class="current">Home</a></li>
                        <li><a href="admin-add-recipe.jsp">Add recipe</a></li>
                        <li><a href="ingredient-list.jsp" style="font-size:17px;">Ingredients</a></li>
                        <li><a id="logout" href="admin-sign-in.jsp">Log out</a></li>
                        <!--- <li><a href="account.html">Account</a></li>-->
                    </ul>
                </nav>
            </header>
            
            <div class="wrapper">
                <article class="menu">
                    <div class="border"></div>
                    <h4>Edit Recipe</h4>
                    <div class="border2"></div>
                    
                    <%if(recipe != null){%>
                    <br>

                    <center>
                        <span id="edit-message"></span>
                        <table style="border:1px dashed #9c5959; width:95%">
                            <tr style="border:1px dashed #9c5959">
                                <td width="30%"><center><h6>Photo</h6></center></td>
                                <td>
                                    <img src="<%=request.getContextPath()%>/images/recipe/<%=recipe.getPicture()%>" class="left clear item" width="150" alt=""><br>

                                    <form name="upload-photo" enctype="multipart/form-data" id="upload-photo" method="post" class="form-signin" action="RecipePicServlet?upload-type=recipe-pic&id=<%=id%>" onSubmit="validateFileUpload(this); return false">
                                        Select another photo:
                                        <input type="hidden" id="recipe-id" name="recipe-id" value="<%=id%>">
                                        <input type="file" name="file" id="file">
                                        <button type="submit" value="Submit">Upload</button>
                                        <input type="hidden" name="upload-type" value="recipe-photo">
                                    </form>
                                </td>
                            </tr>
                        </table>
                                    
                     <form name="edit-form" id="edit-form" method="post" action="EditInfoServlet">                 
                        <table style="border:1px dashed #9c5959">
                            <tr style="border:1px dashed #9c5959">
                                <input type="hidden" id="recipe-id" name="recipe-id" value="<%=id%>">
                                <td width="30%"><center><h6>Recipe Name</h6></center></td>
                                <td>
                                    <input id="rname" name="rname" value="<%=recipe.getName()%>" type="text" style="width:600px;" placeholder="Recipe Name"><br/>
                                    <span id="error-rname"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Category</h6></center></td>
                                <td>
                                    <strong>Meal Type:</strong>
                                    <select id="meal-type" name="meal-type">
                                        
                                        <%while(allMealTypes.next()){
                                            String selectedProperty = "";
                                            if(allMealTypes.getString("name").equals(selectedMealType)){
                                                selectedProperty = "selected=selected";
                                            }
                                         %>
                                        <option value="<%=allMealTypes.getInt("id")%>" <%=selectedProperty%>><%=allMealTypes.getString("name")%></option>
                                        <%}%>   
                                    </select>
                                    <input type="hidden" id="selected-meal-type" name="selected-meal-type" value="<%=selectedMealTypeId%>">
                                    
                                    <strong>Cuisine:</strong>
                                    <select id="cuisine" name="cuisine">
                                        
                                        <%while(allCuisines.next()){
                                            String selectedProperty = "";
                                            if(allCuisines.getString("name").equals(selectedCuisine)){
                                                selectedProperty = "selected=selected";
                                            }
                                         %>
                                        <option value="<%=allCuisines.getInt("id")%>" <%=selectedProperty%>><%=allCuisines.getString("name")%></option>
                                        <%}%>
                                    </select>
                                    <input type="hidden" id="selected-cuisine" name="selected-cuisine" value="<%=selectedCuisineId%>">
                                    
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Description</h6></center></td>
                                <td>
                                    <textarea id="description" name="description" style="width:600px;" placeholder="Description"><%=recipe.getDescription()%></textarea>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Price</h6></center></td>
                                <td>
                                    <input id="price" name="price" value="<%=recipe.getPrice()%>" type="text" style="width:600px;" placeholder="Price">
                                    <span id="error-price"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Serving</h6></center></td>
                                <td>
                                    <input id="serving" name="serving" value="<%=recipe.getServing()%>" type="text" style="width:600px;" placeholder="Serving">
                                    <span id="error-serving"></span>
                                </td>
                            </tr>
                            <tr style="border:1px dashed #9c5959">
                                <td><center><h6>Time</h6></center></td>
                                <td>
                                    <input id="time" name="time" value="<%=recipe.getTime()%>" type="text" style="width:600px;" placeholder="Time">
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
                                            <%
                                                for(int ctr = 0; ctr < ingredients.size() ; ctr++){
                                                    Ingredient ingredient = ingredients.get(ctr);
                                            %>
                                                <tr>  
                                                    <td><input name='ingredient-quantity' class='ingredient-quantity' value="<%=ingredient.getIngredient_qty()%>" /></td>
                                                    <td>
                                                        <input name='ingredient-id' class='ingredient-id' type='hidden' value="<%=ingredient.getId()%>"/>
                                                        <input class='ingredient-name' value="<%=ingredient.getName()%>" readonly='readonly' />
                                                    </td>  
                                                    <td><input name='ingredient-description' value="<%=ingredient.getIngredient_info()%>" class='ingredient-description' /></td>
                                                    <td><span class='ingredient-category'><%=ingredient.getCategory()%></span></td>
                                                    <td><a href='#' class='delete-ingredient'>Delete</a></td>
                                                </tr>
                                            <%}%>
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
                                    <textarea name="procedures" id="procedures" style="width:600px;"><%=recipe.getProcedure()%></textarea>
                                    <span id="error-procedures"></span>
                                </td>
                            </tr>
                        </table>
                        <button type="submit" class="button" href="">Save</button>
                     </form>
                    </center>
                  <% } %>                  
                </article>
            </div>
        </div>
    </body>
</html>
