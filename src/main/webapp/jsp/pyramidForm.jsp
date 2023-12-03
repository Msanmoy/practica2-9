<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 2/12/23
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body class="bg-light">
<div class="container bg-white">
    <div class="row border-bottom">
        <div class="col-12 h2">Pinta una pirámide</div>
    </div>
</div>
<div class="container bg-light">
    <form method="post" action="printPyramid.jsp">
        <div class="row body mt-2">
            <div class="col-md-6 align-self-center">Altura</div>
            <div class="col-md-6 align-self-center"><input type="number" name="altura"/></div>
        </div>
        <div class="row mt-2">
            <div class="col-md-6">
                &nbsp;
            </div>
            <div class="col-md-6 align-self-center">
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
        <div class="col-6">
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