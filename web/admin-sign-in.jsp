<%-- 
    Document   : admin-sign-in
    Created on : Apr 8, 2014, 8:48:17 PM
    Author     : cheskaalindao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
     if (session.getAttribute("id") != null) {
        response.sendRedirect(request.getContextPath() + "/admin-index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Sign in</title>
        <script src="<%=request.getContextPath()%>/js/jquery-1.10.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/sign-in.js" type="text/javascript"></script>

        <link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="css/base.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="css/recipe.css" rel="stylesheet" type="text/css" media="screen" />

        <script type="text/javascript" src="js/jquery.js"></script>
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
                    <li><a href="admin-sign-in.jsp" class="current">Sign-in</a></li>
                  </ul>
                </nav>

                <hgroup class="intro">
                  <h1 class="title">Recipe Finder</h1>
                  <h3 class="tagline">where recipe finding is made easier</h3>
                </hgroup>

                <div class="reservations"><br />
                  <hr class="hr-solid" />
                      <form class="form-signin" id="signin-form" method="post" action="LoginServlet">
                        <span class="phone-number">
                          <input type="text" id="username" name="username" placeholder="Username"> <br>
                          <input type="password" id="username" name="password" placeholder="Password">
                        </span>
                        <hr class="hr-dashed" />
                        <center><div class="email-us"> <button type="submit" class="button">Sign-in</button> </div></center>
                      </form>
                </div>
            </header>
        </div>
    </body>
</html>
