<%--
  Created by IntelliJ IDEA.
  User: manup
  Date: 12/12/2024
  Time: 22:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
    <link rel="stylesheet" href="../css/fontawesome/css/fontawesome.css">
    <link href="../css/fontawesome/css/brands.css" rel="stylesheet">
    <link href="../css/fontawesome/css/solid.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body class="bg-light">
<div class="container bg-white">
    <div class="col-6 border-bottom">
        <div class="col h2">Pinta una pirámide</div>
    </div>
</div>
<div class="container bg-light">
    <form method="post" action="printPyramid.jsp">
        <div class="row mt-2">
            <div class="col align-self-center">
                <i class="fa-solid fa-up-down"></i>
                <input type="number" name="altura" placeholder="Altura"/>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col align-self-right">
                <input class="btn btn-primary" type="submit" value="ACEPTAR">
            </div>
        </div>
    </form>
    <%
        String error = (String)session.getAttribute("error");
//            v---- SI ESTÁ PRESENTE INFORMAR DEL ERROR
        if (error != null) {
    %>
    <div class="row mt-2">
        <div class="col align-self-center">
            <div class="alert alert-danger alert-dismissible fade show">
                <strong>Error!</strong> <%=error%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    </div>
    <%
            session.removeAttribute("error");
        }
    %>
</div>
<script src="../js/bootstrap.bundle.js" ></script>
</body>
</html>