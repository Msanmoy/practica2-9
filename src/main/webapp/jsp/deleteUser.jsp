<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 3/12/23
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    boolean encontrado = false;
    String user = null;
    boolean flagValidaUserNull = false;
    boolean flagValidaUserBlank = false;

    try {
        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("user"));
        flagValidaUserNull = true;
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("user").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaUserBlank = true;
        user = request.getParameter("user");

    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaUserNull || !flagValidaUserBlank) {
            session.setAttribute("error", "Error al borrar");
        }
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/proyectoJSP", "root", "user");

            String sql = "DELETE FROM password WHERE user = ?"; //user
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.executeUpdate();
            session.setAttribute("success", "Usuario borrado correctamente");

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
            session.setAttribute("error", "No se ha podido borrar");

        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

    }
    // Devuelvo siempre a la lista para informar:
    response.sendRedirect("listUsers.jsp");
%>

</body>
</html>