<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 2/12/23
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body id="body-gatos">
<%
    String imagenUrl = "../gatito.jpg";
    //CÓDIGO DE VALIDACIÓN
    boolean valida = false;
    int altura = -1;

    try {
        altura = Integer.parseInt(request.getParameter("altura"));

        if(altura > 1){ // Mínimo para poder pintar la pirámide
            valida = true;
        }else{
            session.setAttribute("error", "Cantidad demasiado pequeña");
            response.sendRedirect("pyramidForm.jsp");
        }

    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        for (int i = 1; i <= altura; i++) {
%>
        <div class="pyramid-row">
<%
            for (int j = 1; j <= i; j++) {
%>
        <img src="<%= imagenUrl %>" alt="*" width="50" height="50">
<%
            }
%>
        </div>
        <br>
<%
        }
    }else{
            session.setAttribute("error", "Valor incorrecto");
            response.sendRedirect("pyramidForm.jsp");
        }
%>

</body>
</html>