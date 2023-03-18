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
    <title>Acceso</title>
</head>
<body>
    <%
        String trying=request.getParameter("trying");
        if(trying!=null && trying.equals("access")){
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
                out.print("<form method='get' action='alumnos.jsp'><div class='submit'><input type='submit' value='Alumnos'></div></form>");
                out.print("<form method='get' action='grupos.jsp'><div class='submit'><input type='submit' value='Grupos'></div></form>");
                out.print("<form method='get' action='matriculacion.jsp'><div class='submit'><input type='submit' value='Matriculación'></div></form>");
                out.print("<form method='get' action='index.jsp'><div class='submit'><input type='submit' value='Salir'></div></form>");
            }catch (SQLException e) {
                out.print("<span>NO funciona</span>");
                out.print("<span>"+e.toString()+"</span>");
                out.print("<span>"+e.getStackTrace().toString()+"</span>");
                out.print("<form method='get' action='index.jsp'><div class='submit'><input type='submit' value='Reintentar'></div></form>");
                e.printStackTrace();
            } finally {
                pool.closeAll();
            }
        }else{

      
    %>
    <div class="indexBlock">        
        <form method="get" action="index.jsp">
            <input type="hidden" name="trying" value="access">
            <div class="item-input">
                <input type="text" name="userName">
            </div>
            <div class="item-input">
                <input type="password" name="password">
            </div>
            <div class="submit">
                <input type="submit" value="Acceder">
            </div>
        </form>
    </div>
    
    <%}%>
</body>
</html>