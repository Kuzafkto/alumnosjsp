<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="connection.ConnectionPool" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<body>
    <%
        String url = "jdbc:mysql://127.0.0.1:3306/alumnos";
        session.setAttribute("url",url);
        session.setAttribute("userName",request.getParameter("userName"));
        session.setAttribute("password",request.getParameter("password"));
        String usuario = request.getParameter("userName");
        String clave =request.getParameter("password");
        ConnectionPool pool = new ConnectionPool(url, usuario, clave);
        session.setAttribute("pool",pool);
        try{
            AlumnosService aService = new AlumnosService(pool.getConnection());
            GruposService gService = new GruposService(pool.getConnection());
            out.print("<button onclick=\"window.location.href='alumnos.jsp'\">Alumnos</button>");
            out.print("<button onclick=\"window.location.href='grupos.jsp'\">Grupos</button>");
            out.print("<button onclick=\"window.location.href='matriculacion.jsp'\">Matriculación</button>");
        }catch (SQLException e) {
            out.print("<span>NO funciona</span>");
            out.print("<span>"+e.toString()+"</span>");
            out.print("<span>"+e.getStackTrace().toString()+"</span>");

            e.printStackTrace();
        } finally {
            pool.closeAll();
        }
    %>
</body>
</html>