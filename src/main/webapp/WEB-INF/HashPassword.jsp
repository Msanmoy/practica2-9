<%--
  Created by IntelliJ IDEA.
  User: hector
  Date: 3/12/23
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<%
    /**
     * Método que obtiene el hash de una password, por
     ejemplo, dado password = admin, devuelve:
     8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f
     2ab448a918
     * @param password
     * @return hash de encriptación del password
     * @throws NoSuchAlgorithmException
     */
    public static String hashPassword(String password) throwsNoSuchAlgorithmException {
    MessageDigest digest;
    digest = MessageDigest.getInstance("SHA-256");
    byte[] encodedhash = digest.digest(
    password.getBytes(StandardCharsets.UTF_8));
    return bytesToHex(encodedhash);
    }

    private static String bytesToHex(byte[] byteHash) {
    StringBuilder hexString = new StringBuilder(2 *
    byteHash.length);
    for (int i = 0; i < byteHash.length; i++) {
    String hex = Integer.toHexString(0xff &
    byteHash[i]);
    if(hex.length() == 1) {
    hexString.append('0');
    }
    hexString.append(hex);
    }
    return hexString.toString();
    }
%>
</body>
</html>
