<%--
    Document   : admin-index.jsp
    Created on : Apr 8, 2014, 10:32:14 PM
    Author     : cheskaalindao
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
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
    ResultSet recipes = RecipeDataContext.getRecipeListByPage("");
    if(key!=null)
    {
        recipes = RecipeDataContext.getRecipeListByPage(key);
    }
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Home</title>
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/logout.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/delete-recipe.js" type="text/javascript"></script>

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

                <hgroup class="intro">
                  <h1 class="title">Recipe Finder</h1>
                  <h3 class="tagline">where recipe finding is made easier</h3>
                </hgroup>

                <div class="reservations"><br />
                  <span class="reservations-title">Search</span>
                  <hr class="hr-solid" />

                  <form> <!--search recipe-->
                    <span class="phone-number">
                      <input type="text" name="search" placeholder="Recipe Name"> <br>
                    </span>
                    <hr class="hr-dashed" />
                    <div class="email-us"> <button type="submit" class="button" href="recipes.jsp">Find recipe</button> </div>
                  </form>
                </div>
            </header>
        </div>
        
        

        <div class="border"></div>
        
        <!--navigation-->
        <div class="wrapper">
            <article class="menu">
                <div class="border"></div>
                <strong>Sort by: </strong>

          <select id="selectsort">
            <option value ="1" selected="selected" >Name (A-Z)</option>
            <option value ="2">Price (Low to High)</option>
            <option value ="3">Price (High to Low)</option>
          </select>
          
          <a id="toggle-sort" class="box" href="javascript:void(0);" width="50px" >Sort</a>
          <script>
              var $togglesort = $("#toggle-sort");
              
              $togglesort.one("click", function ajaxSort(){
                 var selectsort = $("#selectsort").val();
                 $.ajax({
                     data:{
                         s:selectsort
                     },
                     type:"get",
                     dataType:"json",
                     success:sortsuccess,
                     error:sorterror,
                     url:"http://localhost:8084/RecipeFinder/sort/name"
                 });
                 
                 function sortsuccess(data, text){
                     var result = data.result;
                     var $decoy = $('#result-decoy');
                     
                     for(var ctr = 0; ctr < result.length; ctr++){
                        $('#result-holder').append($('.result-'+result[ctr].id));
                     }
                     
                     $togglesort.one('click', ajaxSort);
                 }
                 function sorterror(){
                     $togglesort.one('click', ajaxSort);
                 }
                 
              });
          </script>
          <div class="border3"></div>
            <div id="result-holder">
                <div class="recipelist">
                    <table>
                        <%
                            ArrayList recipeList = new ArrayList();
                            while(recipes.next()){
                                HashMap tmprecipe = new HashMap(); 
                                tmprecipe.put("id", recipes.getString("id")); // get list of name and price to SORT
                                tmprecipe.put("name", recipes.getString("name"));
                                tmprecipe.put("price", recipes.getString("price"));

                                recipeList.add(tmprecipe);
                        %>
                        <tr class="result-<%= recipes.getString("id") %>">
                            <td><img src="<%=request.getContextPath()%>/images/recipe/<%=recipes.getString("picture")%>" class="left clear item" width="150" height="150" alt=""></td>
                            <td><h6><a href="admin-edit-recipe.jsp?id=<%=recipes.getString("id")%>"><%=recipes.getString("name")%>: Php<%=recipes.getString("price")%></a></h6></td>
                            <td><button type="submit" data-recipeid="<%=recipes.getInt("id")%>" class="btndelete button">Delete</button></td>
                        </tr>
                        <%
                            }
                            session.setAttribute("recipe", recipeList);
                        %>    
                    </table>
                </div>
            </div>
            </article>
        </div>
    </body>
</html>
