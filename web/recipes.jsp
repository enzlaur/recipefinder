<%-- 
    Document   : recipes
    Created on : Apr 7, 2014, 11:59:51 PM
    Author     : cheskaalindao
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="DatabaseTransactions.RecipeDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  ResultSet beverage;
    ResultSet condiment;
    ResultSet fruit;
    ResultSet meat;
    ResultSet poultry;
    ResultSet rice;
    ResultSet seafood;
    ResultSet herb;
    ResultSet vegetable;
    ResultSet dairy;
    ResultSet pastry;
    ResultSet noodle;
    ResultSet nut;
    
    beverage = RecipeDataContext.getBeverage();
    condiment = RecipeDataContext.getCondiment();
    fruit = RecipeDataContext.getFruit();
    meat = RecipeDataContext.getMeat();
    poultry = RecipeDataContext.getPoultry();
    rice = RecipeDataContext.getRice();
    seafood = RecipeDataContext.getSeafood();
    herb = RecipeDataContext.getHerb();
    vegetable = RecipeDataContext.getVegetable();
    dairy = RecipeDataContext.getDairy();
    pastry = RecipeDataContext.getPastry();
    noodle = RecipeDataContext.getNoodle();
    nut = RecipeDataContext.getNuts();
    Map AllParameters = request.getParameterMap();
    ResultSet recipe;
    
    String allingredients = "";
    String specificIngredient = "";
    String priceRange="";
    String mealtype = "";
    String cuisine = "";
    String[] pricelist = {"", ""};
    
    String allbeverage ="";
    String allcondiment ="";
    String allfruit ="";
    String allmeat="";
    String allpoultry="";
    String allrice="";
    String allseafood="";
    String allherb="";
    String allvegetable="";
    String alldairy="";
    String allpastry="";
    String allnoodle="";
    String allnut="";
    
    if(AllParameters.containsKey("search")){
        String search = request.getParameter("search");
        recipe = RecipeDataContext.getRecipeList(search);
    }
    else{
        allingredients = request.getParameter("allingredients");
        specificIngredient = request.getParameter("specificIngredient");
        priceRange = request.getParameter("allprices");
        mealtype = request.getParameter("mealtype");
        cuisine = request.getParameter("cuisine");
        recipe = RecipeDataContext.getRecipeList(specificIngredient, allingredients, priceRange, mealtype, cuisine);
        pricelist = priceRange.split(",");
        
        allbeverage =request.getParameter("allbeverage");
        allcondiment =request.getParameter("allcondiment");
        allfruit =request.getParameter("allfruit");
        allmeat=request.getParameter("allmeat");
        allpoultry=request.getParameter("allpoultry");
        allrice=request.getParameter("allrice");
        allseafood=request.getParameter("allseafood");
        allherb=request.getParameter("allherb");
        allvegetable=request.getParameter("allvegetable");
        alldairy=request.getParameter("alldairy");
        allpastry=request.getParameter("allpastry");
        allnoodle=request.getParameter("allnoodle");
        allnut=request.getParameter("allnut");
    }
    
    
%>
<!DOCTYPE HTML>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Search Recipes </title>

    <link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/base.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/recipe.css" rel="stylesheet" type="text/css" media="screen" />

    <script type="text/javascript" src="js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.pikachoose.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/searchrecipe.js"></script>
    <script type="text/javascript">
          $(document).ready(function() {
          $("#pikame").PikaChoose();  });
    </script>
  </head>
  
  <body>
    <div id="container">
      <header>
        <nav>
          <ul id="nav">
            <li><a href="index.jsp">Home</a></li>
                <li><a href="" class="current">Search</a></li>
          </ul>
        </nav>
      </header>

      <div class="wrapper">
        <div class="border"></div>
        
        <article >
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
          <div id="result-holder">
          
          <%
            ArrayList recipeList = new ArrayList();
            while(recipe.next()){
          
                HashMap tmprecipe = new HashMap(); // 
                tmprecipe.put("id", recipe.getString("id"));
                tmprecipe.put("name", recipe.getString("name"));
                tmprecipe.put("price", recipe.getString("price"));
                
                recipeList.add(tmprecipe);
          %>
          <div class="result result-<%= recipe.getString("id") %>">
          <div class="border3"></div>
          
          <div class="left">
            <h3><%=recipe.getString("name")%>: Php<%=recipe.getString("price")%></h3>
          </div>

          <div class="right menu-order"><a class="button" href="steps.jsp?id=<%=recipe.getString("id")%>&specificIngredient=<%=specificIngredient%>&allingredients=<%=allingredients%>&allbeverage=<%=allbeverage%>&allcondiment=<%=allcondiment%>&allfruit=<%=allfruit%>&allmeat=<%=allmeat%>&allpoultry=<%=allpoultry%>&allrice=<%=allrice%>&allseafood=<%=allseafood%>&allherb=<%=allherb%>&allvegetable=<%=allvegetable%>&alldairy=<%=alldairy%>&allpastry=<%=allpastry%>&allnoodle=<%=allnoodle%>&allnut=<%=allnut%>&allprices=<%= priceRange%>&mealtype=<%=mealtype%>&cuisine=<%= cuisine%>">See recipe</a></div>
          <img src="<%=request.getContextPath()%>/images/recipe/<%=recipe.getString("picture")%>" class="left clear item" width="150" alt="">
          <p class="left">
            <%=recipe.getString("description")%><br><br>   
          </p>
          <div class="clear"></div>
          </div>
          <%
            }
            session.setAttribute("recipe", recipeList);
          %>
          </div>
          
        </article>

        <aside class="sidebar">
          <h4>Ingredients</h4>
          <br>

          <center>
            <strong>Beverages</strong>
            <p><% 
                if( !allbeverage.equals("") ){
                out.println(allbeverage.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>

            <strong>Condiments</strong>
            <p><% 
                if( !allcondiment.equals("") ){
                out.println(allcondiment.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>

            <strong>Fruits</strong>
            <p><% 
                if( !allfruit.equals("") ){
                out.println(allfruit.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>

            <strong>Meat</strong>
            <p><% 
                if( !allmeat.equals("") ){
                out.println(allmeat.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>

            <strong>Poultry</strong>
            <p><% 
                if( !allpoultry.equals("") ){
                out.println(allpoultry.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Rice</strong>
            <p><% 
                if( !allrice.equals("") ){
                out.println(allrice.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Seafood</strong>
            <p><% 
                if( !allseafood.equals("") ){
                out.println(allseafood.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Herbs and Spices</strong>
            <p><% 
                if( !allherb.equals("") ){
                out.println(allherb.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Vegetables</strong>
            <p><% 
                if( !allvegetable.equals("") ){
                out.println(allvegetable.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Dairy</strong>
            <p><% 
                if( !alldairy.equals("") ){
                out.println(alldairy.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Pastry</strong>
            <p><% 
                if( !allpastry.equals("") ){
                out.println(allpastry.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Noodle</strong>
            <p><% 
                if( !allnoodle.equals("") ){
                out.println(allnoodle.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
            
            <strong>Nuts</strong>
            <p><% 
                if( !allnut.equals("") ){
                out.println(allnut.replace(",", " • "));
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
          </center>

          <div class="border3"></div>
          <h4>Ingredient Entered</h4>
          <br>
          <center>
              <% 
              if( !specificIngredient.equals("") ){
                out.println("<strong>" + specificIngredient + "</strong>");
                }
                else{
                    out.println("No input");
                }
              %>
          </center>
          
          
          <div class="border3"></div>

          <h4>Price Range</h4>
          <br>
          <center>
            <strong><% 
                if(pricelist.length > 0){
                    if((pricelist[0].equals("1")) && (pricelist[1].equals("99999"))){
                        out.println("All prices available");
                    }
                    else if(pricelist[0].equals("")){
                        out.println("All prices available");
                    }
                    else{
                        out.println("PHP " + pricelist[0] + " to " + pricelist[1]);
                    }
                }
            %></strong>
          </center>

          <div class="border3"></div>

          <h4>Preference</h4>
          <br>
          <center>
            <strong>Meal Type</strong>
            <p><% 
            
                if( !mealtype.equals("") ){
                out.println(mealtype);
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>

            <strong>Cuisine</strong>
            <p><% 
            
                if( !cuisine.equals("") ){
                out.println(cuisine);
                }
                else{
                    out.println("<i>None selected.</i>");
                }
            %></p>
          </center>
        </aside>

        <div class="border2"></div>
        <br>
      </div>

      <footer>
        <aside id="pricing-table" class="clear">
          <form id="frm" name="frm" action="recipes.jsp">
          <div class="plan">
            <h3>Ingredients<span><img src="images/home/4.png" class="home-des"/></span></h3>
    
                <div class="panel panel-default"><!-- 1st COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
                                Beverages
                            </a>
                        </h4>
                    </div>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( beverage.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories beverage" value="<%=beverage.getString("name")%>"> <%=beverage.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( beverage.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories beverage" value="<%=beverage.getString("name")%>"> <%=beverage.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 1st COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 2nd COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
                                Condiments
                            </a>
                        </h4>
                    </div>
                    <div id="collapse2" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( condiment.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories condiment" value="<%=condiment.getString("name")%>"> <%=condiment.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( condiment.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories condiment" value="<%=condiment.getString("name")%>"> <%=condiment.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 2nd COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 3rd COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
                                Fruits
                            </a>
                        </h4>
                    </div>
                    <div id="collapse3" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( fruit.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories fruit" value="<%=fruit.getString("name")%>"> <%=fruit.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( fruit.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories fruit" value="<%=fruit.getString("name")%>"> <%=fruit.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 3rd COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 4th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">
                                Meat
                            </a>
                        </h4>
                    </div>
                    <div id="collapse4" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( meat.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories meat" value="<%=meat.getString("name")%>"> <%=meat.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( meat.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories meat" value="<%=meat.getString("name")%>"> <%=meat.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 4th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 5th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">
                                Poultry
                            </a>
                        </h4>
                    </div>
                    <div id="collapse5" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( poultry.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories poultry" value="<%=poultry.getString("name")%>"> <%=poultry.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( poultry.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories poultry" value="<%=poultry.getString("name")%>"> <%=poultry.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 5th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 6th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse6">
                                Rice
                            </a>
                        </h4>
                    </div>
                    <div id="collapse6" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( rice.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories rice" value="<%=rice.getString("name")%>"> <%=rice.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( rice.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories rice" value="<%=rice.getString("name")%>"> <%=rice.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 6th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 7th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse7">
                                Seafood
                            </a>
                        </h4>
                    </div>
                    <div id="collapse7" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( seafood.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories seafood" value="<%=seafood.getString("name")%>"> <%=seafood.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( seafood.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories seafood" value="<%=seafood.getString("name")%>"> <%=seafood.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 7th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 8th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse8">
                                Herbs and Spices
                            </a>
                        </h4>
                    </div>
                    <div id="collapse8" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( herb.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories herb" value="<%=herb.getString("name")%>"> <%=herb.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( herb.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories herb" value="<%=herb.getString("name")%>"> <%=herb.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 8th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 9th COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse9">
                                Vegetables
                            </a>
                        </h4>
                    </div>
                    <div id="collapse9" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( vegetable.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories vegetable" value="<%=vegetable.getString("name")%>"> <%=vegetable.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( vegetable.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories vegetable" value="<%=vegetable.getString("name")%>"> <%=vegetable.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 9th COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 10 COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse10">
                                Dairy
                            </a>
                        </h4>
                    </div>
                    <div id="collapse10" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( dairy.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories dairy" value="<%=dairy.getString("name")%>"> <%=dairy.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( dairy.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories dairy" value="<%=dairy.getString("name")%>"> <%=dairy.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 10 COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 11 COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse11">
                                Pastry
                            </a>
                        </h4>
                    </div>
                    <div id="collapse11" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( pastry.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories pastry" value="<%=pastry.getString("name")%>"> <%=pastry.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( pastry.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories pastry" value="<%=pastry.getString("name")%>"> <%=pastry.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 11 COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 12 COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse12">
                                Noodle
                            </a>
                        </h4>
                    </div>
                    <div id="collapse12" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( noodle.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories noodle" value="<%=noodle.getString("name")%>"> <%=noodle.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( noodle.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories noodle" value="<%=noodle.getString("name")%>"> <%=noodle.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 12 COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 13 COLLAPSE START-->
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse13">
                                Nuts
                            </a>
                        </h4>
                    </div>
                    <div id="collapse13" class="panel-collapse collapse">
                        <div class="panel-body">
                            <center>
                                <table style="text-align:left">
                                    <tr>
                                       <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( nut.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories nut" value="<%=nut.getString("name")%>"> <%=nut.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>

                                        <td>
                                <% for(int ctr = 0 ; ctr < 5 ; ctr ++){
                                    if( nut.next() ) 
                                    {
                                %>
                                        <input type="checkbox" class="categories nut" value="<%=nut.getString("name")%>"> <%=nut.getString("name")%><br>

                                <%  } 
                                   }   %>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            <br> 
                        </div>
                    </div>                 
                </div><!-- 13 COLLAPSE END -->
                
                <div class="panel panel-default"><!-- 14 COLLAPSE START -->
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                    Or Search ingredient
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse">
                            <div class="panel-body">
                                <input type="text" name="specificIngredient" placeholder="ingredient">
                                <br> 
                            </div>
                        </div>

                    </div> <!-- 14 COLLAPSE END -->

                <div class="panel-group" id="accordion">
                </div>
                
                <input type="textbox" id="allingredients" name="allingredients" style="display: none;">
                <input type="textbox" id="allbeverage" name="allbeverage" style="display: none;">
                <input type="textbox" id="allcondiment" name="allcondiment" style="display: none;">
                <input type="textbox" id="allfruit" name="allfruit" style="display: none;">
                <input type="textbox" id="allmeat" name="allmeat" style="display: none;">
                <input type="textbox" id="allpoultry" name="allpoultry" style="display: none;">
                <input type="textbox" id="allrice" name="allrice" style="display: none;">
                <input type="textbox" id="allseafood" name="allseafood" style="display: none;">
                <input type="textbox" id="allherb" name="allherb" style="display: none;">
                <input type="textbox" id="allvegetable" name="allvegetable" style="display: none;">
                <input type="textbox" id="alldairy" name="alldairy" style="display: none;">
                <input type="textbox" id="allpastry" name="allpastry" style="display: none;">
                <input type="textbox" id="allnoodle" name="allnoodle" style="display: none;">
                <input type="textbox" id="allnut" name="allnut" style="display: none;">
                
          </div> <!-- plan end -->

          <div class="plan">
            <h3>Budget<span><img src="images/home/5.png" class="home-des"/></span></h3>
            <ul>
              <li>
                <strong>Input price range (Lower and Higher): </strong><br>
                <input class="prices" type="number" placeholder="From Php"><br/><br/><input class="prices"type="number" placeholder=" To Php">
                <input type="textbox" id="allprices" name="allprices" style="display: none;">
              </li>
              
            </ul>
          </div>

          <div class="plan">
            <h3>Preferences<span><img src="images/home/6.png" class="home-des"/></span></h3>
            <ul>
              <li>
                <strong>Meal Type</strong><br>

                 <select name="mealtype">
                  <option value="">All</option>
                  <option value="Appetizer">Appetizer</option>
                  <option value="Bread">Bread</option>
                  <option value="Breakfast">Breakfast</option>
                  <option value="Dessert">Dessert</option>
                  <option value="Main Dishes">Main Dishes</option>
                  <option value="Pasta">Pasta</option>
                  <option value="Salads">Salads</option>
                  <option value="Sauces">Sauces</option>
                  <option value="Side Dishes">Side Dishes</option>
                  <option value="Snacks">Snacks</option>
                  <option value="Soups">Soups</option>
                </select>
              </li>
              <li>
                <strong>Cuisine</strong><br>

                 <select name="cuisine">
                  <option value="">All</option>
                  <option value="American">American</option>
                  <option value="Chinese">Chinese</option>
                  <option value="Filipino">Filipino</option>
                  <option value="French">French</option>
                  <option value="Fusion">Fusion</option>
                  <option value="Greek">Greek</option>
                  <option value="Italian">Italian</option>
                  <option value="Japenese">Japanese</option>
                  <option value="Korean">Korean</option>
                  <option value="Malaysian">Malaysian</option>
                  <option value="Mediterranean">Mediterranean</option>
                  <option value="Mexican">Mexican</option>
                  <option value="Middle Eastern">Middle Eastern</option>
                  <option value="Others">Others</option>
                  <option value="Singaporean">Singaporean</option>
                  <option value="Spanish">Spanish</option>
                  <option value="Thai">Thai</option>
                </select>
              </li>
            </ul>
          </div>
          
         </form>
        </aside>
        
        <div class="border2"></div>
        <center><a id="searchrecipe" class="button" href="#searchrecipe" onclick="getAllIngredients()" >Search recipes!</a></center>
        
        <br>

        <span class="copyright">
          <span class="left"><br>
            &copy; Copyright 2014 - All Rights Reserved - <a href="#">De La Salle University</a>
          </span>
          <span class="right"><br>
            Design by <a href="http://www.priteshgupta.com">PriteshGupta.com</a>
            <br><br><br>
          </span>
        </span>
      </footer>
    </div>
  </body>
</html>