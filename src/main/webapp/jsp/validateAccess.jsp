<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 2/12/23
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body class="bg-light">
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    boolean encontrado = false;
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
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("user").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaUserBlank = true;
        user = request.getParameter("user");

        Objects.requireNonNull(request.getParameter("pass"));
        flagValidaPassNull = true;

        if (request.getParameter("pass").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaPassBlank = true;
        pass = request.getParameter("pass");

    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaUserNull || !flagValidaUserBlank) {
            session.setAttribute("error", "Error en usuario");
        } else if (!flagValidaPassNull || !flagValidaPassBlank) {
            session.setAttribute("error", "Error en contraseña");
        }
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet resultUser = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/proyectoJSP", "root", "user");

            String sql = "SELECT * FROM password WHERE user = " +
                    "?" + //user
                    " and pass = ?"; //pass

            System.out.println(sql);

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setString(idx++, user);
            ps.setString(idx++, pass);

            resultUser = ps.executeQuery();

            if(resultUser.next()){
                System.out.println(resultUser.getString("user"));
                System.out.println(resultUser.getString("pass"));
                session.setAttribute("user", user); // IDentificamos usuario

%>
            <%-- MUESTRO VENTANA ACCESO CORRECTO: --%>
            <div class="container bg-white">
                <div class="row border-bottom">
                    <div class="col-12 h2">Control de Acceso</div>
                </div>
            </div>
            <div class="container bg-light">
                <form method="get" action="pyramidForm.jsp">
                    <div class="row body mt-2">
                        Icono
                    </div>
                    <div class="row body mt-2">
                        Acceso permitido a la aplicación
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
            </div>
<%
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

    } else {

        // Devuelvo a formulario para mostrar el error:
        response.sendRedirect("../index.jsp");
    }
%>

</body>
</html>