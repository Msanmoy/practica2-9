<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/fontawesome/css/fontawesome.css">
    <link href="css/fontawesome/css/brands.css" rel="stylesheet">
    <link href="css/fontawesome/css/solid.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body class="bg-light">
<div class="container bg-white">
    <div class="col-6 border-bottom">
        <div class="col h2">Control de Acceso</div>
    </div>
</div>
<div class="container bg-light">
    <form method="post" action="jsp/validateAccess.jsp">
        <div class="row mt-2">
            <div class="col align-self-center">
                <i class="fa-solid fa-circle-user"></i>
                <input type="text" name="user" placeholder="Usuario"/>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col align-self-center">
                <i class="fa-solid fa-lock"></i>
                <input type="text" name="pass" placeholder="Contraseña"/>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col align-self-right">
                <input class="btn btn-primary align-self-right" type="submit" value="ACEPTAR"></i>
            </div>
        </div>
    </form>
    <%
        //                                                 v---- RECOGER MENSAJE DE ERROR DEL ÁMBITO request
        String error = (String)session.getAttribute("error");
//            v---- SI ESTÁ PRESENTE INFORMAR DEL ERROR
        if (error != null) {
    %>
    <div class="row mt-2">
        <div class="col-4 align-self-center">
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
<script src="js/bootstrap.bundle.js" ></script>
</body>
</html>