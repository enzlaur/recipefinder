<%-- 
    Document   : ingredient-options
    Created on : Apr 13, 2014, 6:30:53 PM
    Author     : cheskaalindao
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DatabaseTransactions.IngredientsDataContext"%>
<%
    /* Parameters */
    String ingredientPageParam = request.getParameter("page");
    int ingredientPage = 1;
    if(ingredientPageParam != null) { ingredientPage = Integer.parseInt(ingredientPageParam) ; } 
    
    String keyword = request.getParameter("keyword");
    if(keyword == null || keyword == ""){ keyword = ""; }
    
    String ingredientPageSizeParam = request.getParameter("page-size");
    int pageSize = 10;
    if(ingredientPageSizeParam != null) { pageSize = Integer.parseInt(ingredientPageSizeParam) ; }
    
    /* Get page data */
    ResultSet ingredientList = IngredientsDataContext.getIngredientList(keyword, ingredientPage, pageSize);
    int resultCount = IngredientsDataContext.getIngredientListCount(keyword);
    
    /* Paging info */
    double totalPages = Math.ceil(resultCount / pageSize);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <title>Ingredients</title>

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
        <div>
            <div class="border"></div>
            <form method="get">
                <input type="text" name="keyword" value="<%=keyword %>" />
                <input class="button" type="submit" value="Find" />
            </form>
            <div class="border2"></div>

            <br/>

        <table>
            <thead>
                <tr>
                    <th><center><h6>Name</h6></center></th>
                    <th><center><h6>Category</h6></center></th>
                </tr>
            </thead>
            <tbody>
                <% while(ingredientList.next()){ %>
                <tr>
                    <td style="border:1px dotted #9c5959; text-align: center">
                        <span style="display:none" class="ingredient-id"><%=ingredientList.getString("id") %></span>
                        <a class="ingredient-name" href="#"><%=ingredientList.getString("name") %></a>
                    </td>
                    <td width="39%" style="border:1px dotted #9c5959; text-align: center"><span class="ingredient-category"><%=ingredientList.getString("category") %></span></td>
                </tr>
                <% } %>
            </tbody>
            <tfoot>
                <tr>
                    <td>
                        <br/><br/>
                        <% for(int pageStep = 1; pageStep < totalPages; pageStep++){ %>
                            <% if(pageStep == ingredientPage){ %>
                                <b><%=pageStep %></b>
                            <% } else{ %>
                                <a href="?keyword=<%=keyword %>&page=<%=pageStep %>&page-size=<%=pageSize %>"><%=pageStep %></a>
                            <% } %>
                        <% } %>
                    </td>
                </tr>
            </tfoot>
        </table>

        </div>
     
        <script>
            $(function(){
                $(".ingredient-name").on("click", ingredientNameClicked);
                
            })
            
            function ingredientNameClicked(e){
                e.preventDefault();
                var $row = $(e.currentTarget).closest("tr"); 
                var ingId = $row.find(".ingredient-id").text();
                var ingName = $row.find(".ingredient-name").text();
                var ingCategory = $row.find(".ingredient-category").text();
                opener.ingredientOptionsCallback(ingId, ingName, ingCategory);
                window.close();
                return false;
            }
            
        </script>
    </body>
</html>
