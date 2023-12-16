<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 3/12/23
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body>
<div class="container">
<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/proyectoJSP","root", "user");
        Statement s = conn.createStatement();

        ResultSet listado = s.executeQuery ("SELECT * FROM password");
%>
<table>
    <tr><th> Usuario </th><th> Contraseña </th></tr>
    <%
        String usuarioNuevo = (String)session.getAttribute("user");

        while (listado.next()) {
    %>
    <tr>
        <td>
            <%= listado.getString("user")%>
        </td>
        <td>
             * * * * *
            <!-- //listado.getString("pass") -->
        </td>
        <td>
            <form method="post" action="deleteUser.jsp">
                <input type="hidden" name="user" value="<%=listado.getString("user") %>"/>
                <input type="submit" value="borrar">
            </form>
        </td>
    </tr>
    <%
        } // while
        conn.close();
    %>
</table>
<%
    //                                                 v---- RECOGER MENSAJE DE ERROR DEL ÁMBITO request
    String error = (String)session.getAttribute("error");
    String success = (String)session.getAttribute("success");
//            v---- SI ESTÁ PRESENTE INFORMAR DEL ERROR
    if (error != null || success != null) {
        String ErrorAlertClass = "class=\"alert alert-danger alert-dismissible fade show\"";
        String SuccessAlertClass = "class=\"alert alert-success alert-dismissible fade show\"";

%>
<div class="row mt-2">
    <div class="col-4 align-self-center">
        <div <%= (error!=null)?ErrorAlertClass:SuccessAlertClass%>>
            <strong><%= (error!=null)?"Error!":"Hecho!"%></strong> <%= (error!=null)?error:success%>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</div>
<%
        session.removeAttribute("error");
        session.removeAttribute("success");
    }
    }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
%>
<form method="post" action="createUSer.jsp">
    <div class="row mt-4">
        <div class="col-6">
            <i class="fa-solid fa-circle-user"></i>
            <input type="text" name="user" placeholder="Usuario"/>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-6">
            <i class="fa-solid fa-lock"></i>
            <input type="text" name="pass" placeholder="Contraseña"/>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col align-self-center">
            <input class="btn btn-primary align-self-center" type="submit" value="AÑADIR USUARIO"></i>
        </div>
    </div>
</form>
</div>
<script src="../js/bootstrap.bundle.js" ></script>
</body>
</html>