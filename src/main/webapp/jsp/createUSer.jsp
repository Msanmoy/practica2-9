<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 3/12/23
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="org.iesvdm.proyecto_jsp_jdbc.EncryptPass" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    String user = null;
    String pass = null;
    boolean flagValidaUserNull = false;
    boolean flagValidaUserBlank = false;
    boolean flagValidaPassNull = false;
    boolean flagValidaPassBlank = false;
    try {

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("user"));
        flagValidaUserNull = true;
        //CONTRACT nonBlank:
        if (request.getParameter("user").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaUserBlank = true;
        user = request.getParameter("user");

        Objects.requireNonNull(request.getParameter("pass"));
        flagValidaPassNull = true;

        if (request.getParameter("pass").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaPassBlank = true;
        pass = EncryptPass.hashPassword(request.getParameter("pass"));

    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaUserNull || !flagValidaUserBlank) {
            session.setAttribute("error", "Error en usuario");
        } else if (!flagValidaPassNull || !flagValidaPassBlank) {
            session.setAttribute("error", "Error en contraseña");
        }
        valida = false;
    }
    // FIN CÓDIGO DE VALIDACIÓN DE PARÁMETROS

    // AHORA VALIDAMOS USUARIO REPETIDO:
    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet resultUser = null;

        try {
            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/proyectoJSP", "root", "user");

            // Buscamos
            String sql = "SELECT * FROM password WHERE user = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            resultUser = ps.executeQuery();

            if(resultUser.next()){
                session.setAttribute("error", user + " ya está en uso");
            }else{
                // Si no está repetido lo grabamos en base de datos:
                ps = conn.prepareStatement("INSERT INTO password VALUES (? , ?)");

                int idx = 1;
                ps.setString(idx++, user);
                ps.setString(idx, pass);

                ps.executeUpdate();
                session.setAttribute("success", user + " creado correctamente");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            try {
                resultUser.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }
    }

    // Devuelvo siempre a formulario para mostrar el error o avisar de éxito:
    response.sendRedirect("listUsers.jsp");
%>

</body>
</html>