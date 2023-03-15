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
    <title>Alumnos</title>
</head>
<body>
    <%
    String url=(String)session.getAttribute("url");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    try{
        AlumnosService aService = new AlumnosService(pool.getConnection());
        GruposService gService = new GruposService(pool.getConnection());
    %>
        <form method="post" action="controlAlumnos.jsp">
            <input type="hidden" value="create" name="mode">
            <input type="submit" value="Crear">
        </form>

    <%
      //out.print("<button onclick=\"window.location.href='controlAlumnos.jsp?mode=\"create\"'\">Agregar</button>");
    //out.print("<button onclick=\"window.location.href='controlAlumnos.jsp';session.setAttribute("mode","create");\">Agregar</button>");
        /* tienes que tener en cada administrador (ejemplo controlAlumnosjsp) todos los metodos del crud
        sin tener en cuenta la matriculacion, la cual tendrá su propia administracion, para cada uno se pasara el parametro
        mode que indicara en que modo inicia el programa */

        for (Alumno al : aService.requestAll()) {
            out.print("<span>"+al.toString()+"</span><br><form method='get' action='controlAlumnos.jsp'>"+
                "<input type='hidden' value='edit' name='mode' /><input type='hidden' name='id' value='"+al.getId()+"'/>"+
                "<input type='hidden' name='name' value='"+al.getNombre()+"'/><input type='hidden' name='surnames' value='"+al.getApellidos()+"'/>"+
                "<input type='submit' value='Editar'/></form>");
            
                    //estoy tratando de poder meter en el form los valores para poder en el editar poner en el controlAlumnosjsp
                    //value un valor by default
        } 
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