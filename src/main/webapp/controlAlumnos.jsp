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
    <title>Control</title>
</head>
<body>
    <%
     String mode=request.getParameter("mode");
     ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    //boton de se creo satisfactoriamente + volver a la lista de alumnos + obtener parametro que sale en el metodo y si 
    //funcionó perfectamente sale el mensaje y de lo contrario error.


     try{
        AlumnosService aService = new AlumnosService(pool.getConnection());
        GruposService gService = new GruposService(pool.getConnection());

        String op=request.getParameter("op");
        if(op!=null&&op.equals("create")){
            try{
                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                int groupId=Integer.parseInt(request.getParameter("ID Grupo"));
                aService.create(name,surnames,0);
                mode="confirm";
                out.print("<span>Se ha creado el usuario "+name+" "+surnames+"</span>");
                out.print("<form method=\"post\" action=\"alumnos.jsp\"><input type=\"submit\" value=\"volver\"></form>");
            }catch (Exception e) {
            e.printStackTrace();
    } finally {
        pool.closeAll();
    }
        }else if(op!=null&&op.equals("edit")){
            try{
                int id=Integer.parseInt(request.getParameter("id"));
                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                aService.update(id,name,surnames,0);
                mode="confirm";
                out.print("<span>Se ha editado el usuario "+name+" "+surnames+"</span>");
                out.print("<form method=\"post\" action=\"alumnos.jsp\"><input type=\"submit\" value=\"volver\"></form>");
            }catch (Exception e) {
            e.printStackTrace();
    } finally {
        pool.closeAll();
    }
        }
        if (mode != null && mode.equals("create")){

   %>

    <form method="get" action="controlAlumnos.jsp">
        <input type="hidden" name="op" value="create">
        <input type="text" name="nombre" required>
        <input type="text" name="apellidos" required>
        <input type="submit" value="Crear">
    </form>
    <%}else if( mode != null&&mode.equals("edit")){
        int id=Integer.parseInt(request.getParameter("id"));
        String name=request.getParameter("name");
        String surnames=request.getParameter("surnames");
        %>
        <form method="get" action="controlAlumnos.jsp">
            <input type="hidden" name="op" value="edit">
            <input type="text" name="nombre" value=<%=name%> required>
            <input type="text" name="apellidos" value=<%=surnames%> required>
            <input type="submit" value="Confirmar">
        </form>


     <%}else if(mode != null&&mode.equals("delete")){%>


        <%}
        
     }catch (SQLException e) {
        e.printStackTrace();
    } finally {
        pool.closeAll();
    }%>
 
</body>
</html>