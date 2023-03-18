<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="connection.ConnectionPool" %>
<!--FALTA OPTIMIZAR ESTOS IMPORTS PARA QUE SE USEN LOS CORRECTOS-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grupos</title>
</head>
<body>
    <%
    String url=(String)session.getAttribute("url");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    try{%>
        <form method="post" action="controlGrupos.jsp">
            <input type="hidden" value="create" name="mode">
            <input type="submit" value="Crear">
        </form>
    <%
        GruposService gService = new GruposService(pool.getConnection());
        for (Grupo gp : gService.requestAll()) {
            out.print("<span>"+gp.toString()+"</span><br><form method='get' action='controlGrupos.jsp'>"+
                "<input type='hidden' value='edit' name='mode' /><input type='hidden' name='id' value='"+gp.getId()+"'/>"+
                "<input type='hidden' name='name' value='"+gp.getName()+"'/><input type='hidden' name='headTeacher' value='"+gp.getHeadTeacherName()+"'/>"+
                "<input type='submit' value='Editar'/></form>"+
                "<form method='get' action='controlGrupos.jsp'>"+
                    "<input type='hidden' value='delete' name='mode' /><input type='hidden' name='id' value='"+gp.getId()+"'/>"+
                    "<input type='submit' value='Borrar'/></form>");
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
<form method="get" action="index.jsp">
    <input type="hidden" name="userName" value=<%=session.getAttribute("userName")%>>
    <input type="hidden" name="password" value=<%=session.getAttribute("password")%>>
    <input type="hidden" name="trying" value="access">
    <input type="submit" value="Volver">
</form>
</body>
</html>