<%-- 
    Document   : index
    Created on : Apr 7, 2014, 11:40:07 PM
    Author     : cheskaalindao
--%>

<%@page import="classes.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DatabaseTransactions.RecipeDataContext"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Categories> beverage;
    ArrayList<Categories> condiment;
    ArrayList<Categories> fruit;
    ArrayList<Categories> meat;
    ArrayList<Categories> poultry;
    ArrayList<Categories> rice;
    ArrayList<Categories> seafood;
    ArrayList<Categories> herb;
    ArrayList<Categories> vegetable;
    ArrayList<Categories> dairy;
    ArrayList<Categories> pastry;
    ArrayList<Categories> noodle;
    ArrayList<Categories> nut;
    
    //extra comment for testing hue hue
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
    
    float arrSize;
    int col;
    
%>
<!DOCTYPE HTML>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Recipe Finder</title>

    <link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/base.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/recipe.css" rel="stylesheet" type="text/css" media="screen" />

    <script type="text/javascript" src="js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.pikachoose.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/searchrecipe.js"></script>
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
            <li><a href="index.jsp" class="current">Home</a></li>
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

          <form action="recipes.jsp"> <!--search recipe-->
            <span class="phone-number">
              <input type="text" name="search" placeholder="Recipe Name"> <br>
            </span>
            <hr class="hr-dashed" />
            <div class="email-us"> <button type="submit" class="button">Find recipe</button> </div>
          </form>
        </div>
      </header>

      <div class="wrapper">
        <div class="clear"></div>
        <div class="border"></div>
        
        <div class="home-widget">
          <h3>Ingredients</h3>
          <img src="images/home/1.jpg" width="300" alt="" />
          <p>
            Find recipes that contain all the ingredients of your choice! <br><br>
            <strong>Tip:</strong> Why not search for recipes that contain some of the ingredients that you have at home and know what else you have to buy to fulfill your dish?
          </p>
        </div>

        <div class="home-widget">
          <h3>Budget</h3>
          <img src="images/home/2.jpg" width="300" alt="" />
          <p>
            Find recipes that fit your budget! <br><br>
            <strong>Tip:</strong> Why not search for recipes that can serve more people with the budget you have?
          </p>
        </div>

        <div class="home-widget">
          <h3>Preferences</h3>
          <img src="images/home/3.jpg" width="300" alt="" />
          <p>
            Find recipes under your preferences, may it be a meal type or cuisine! <br><br>
            <strong>Tip:</strong> Why not search for recipes that can actually both?
          </p>
        </div>

        <div class="border2"></div> <br>
        
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
                                <% 
                                    if( !beverage.isEmpty() ){
                                      arrSize = beverage.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories beverages = beverage.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories beverage" value="<%=beverages.getName()%>"> <%=beverages.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !condiment.isEmpty() ){
                                      arrSize = condiment.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories condiments = condiment.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories condiment" value="<%=condiments.getName()%>"> <%=condiments.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !fruit.isEmpty() ){
                                      arrSize = fruit.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories fruits = fruit.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories fruit" value="<%=fruits.getName()%>"> <%=fruits.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !meat.isEmpty() ){
                                      arrSize = meat.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories meats = meat.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories meat" value="<%=meats.getName()%>"> <%=meats.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !poultry.isEmpty() ){
                                      arrSize = poultry.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories poultries = poultry.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories poultry" value="<%=poultries.getName()%>"> <%=poultries.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !rice.isEmpty() ){
                                      arrSize = rice.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories rices = rice.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories rice" value="<%=rices.getName()%>"> <%=rices.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !seafood.isEmpty() ){
                                      arrSize = seafood.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories seafoods = seafood.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories seafood" value="<%=seafoods.getName()%>"> <%=seafoods.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !herb.isEmpty() ){
                                      arrSize = herb.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories herbs = herb.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories herb" value="<%=herbs.getName()%>"> <%=herbs.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !vegetable.isEmpty() ){
                                      arrSize = vegetable.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories vegetables = vegetable.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories vegetable" value="<%=vegetables.getName()%>"> <%=vegetables.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !dairy.isEmpty() ){
                                      arrSize = dairy.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories dairies = dairy.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories dairy" value="<%=dairies.getName()%>"> <%=dairies.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !pastry.isEmpty() ){
                                      arrSize = pastry.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories pastries = pastry.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories pastry" value="<%=pastries.getName()%>"> <%=pastries.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !noodle.isEmpty() ){
                                      arrSize = noodle.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories noodles = noodle.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories noodle" value="<%=noodles.getName()%>"> <%=noodles.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
                                <% 
                                    if( !nut.isEmpty() ){
                                      arrSize = nut.size();
                                      col = (int) Math.ceil(arrSize/5);
                                        for(int ctr = 0 ; ctr < col ; ctr ++){
                                            
                                            int start = ctr * 5;
                                            float stop = start + 5;
                                            if( stop > arrSize){
                                                stop = arrSize;
                                            }
                                %>      
                                       <td>
                                <%            for( int ctr2 = start ; ctr2 < stop ; ctr2++ ){
                                                Categories nuts = nut.get(ctr2);
                                %>
                                        <input type="checkbox" class="categories nut" value="<%=nuts.getName()%>"> <%=nuts.getName()%><br>

                                <%          }
                                %>
                                       </td>
                                <%       }
                                    }
                                %>
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
      </div>

      <footer>
        <center><a id="searchrecipe" class="button" href="javascript:void(0)" onclick="getAllIngredients()" >Search recipes!</a></center>
        <div class="border"></div>
        <div class="clear"></div>

        <div class="border2"></div>
        <br />
        
        <span class="copyright">
          <span class="left"><br>
            &copy; Copyright 2012 - All Rights Reserved - <a href="#">Domain Name</a>
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