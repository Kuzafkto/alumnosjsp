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

     try{
        AlumnosService aService = new AlumnosService(pool.getConnection());

        String op=request.getParameter("op");
        if(op!=null&&op.equals("create")){
            try{
                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                aService.create(name,surnames,0);
                out.print("<span>Se ha creado el usuario "+name+" "+surnames+"</span>");
                out.print("<form method=\"post\" action=\"alumnos.jsp\"><input type=\"submit\" value=\"volver\"></form>");
            }catch (SQLException e) {
            out.print("<span>Error</span><br>");
            out.print("<span>"+e.getStackTrace().toString()+"</span>");
            e.printStackTrace();
    } finally {
        pool.closeAll();
    }
        }else if(op!=null&&(op.equals("edit")||op.equals("unassign")||op.equals("assign"))){
            try{
                long id=Long.parseLong(request.getParameter("id"));
                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                if(op.equals("assign")){
                    Long groupID=Long.parseLong(request.getParameter("id_grupo"));
                    aService.update(id,name,surnames,groupID);
                    out.print("<span>Se ha matriculado el usuario "+name+" "+surnames+"</span>");
                    out.print("<form method=\"post\" action=\"matriculacion.jsp\"><input type=\"submit\" value=\"Volver\"></form>");
                }else{
                    aService.update(id,name,surnames,0);
                    if(op.equals("edit")){
                        out.print("<span>Se ha editado el usuario "+name+" "+surnames+"</span>");
                        out.print("<form method=\"post\" action=\"alumnos.jsp\"><input type=\"submit\" value=\"Volver\"></form>");
                    }else{
                        out.print("<span>Se ha desmatriculado el usuario "+name+" "+surnames+"</span>");
                        out.print("<form method=\"post\" action=\"matriculacion.jsp\"><input type=\"submit\" value=\"Volver\"></form>");

                    }
                }
            }catch (Exception e) {
            e.printStackTrace();
            out.print("<span>Error</span>");
    } finally {
        pool.closeAll();
    }
        }else if(op!=null&&op.equals("delete")){
            try{
                long id=Long.parseLong(request.getParameter("id"));
                aService.delete(id);
                out.print("<span>Se ha borrado el usuario</span>");
                out.print("<form method=\"post\" action=\"alumnos.jsp\"><input type=\"submit\" value=\"volver\"></form>");
            }catch (Exception e) {
            e.printStackTrace();
            out.print("<span>Error</span>");
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
        long id=Long.parseLong(request.getParameter("id"));
        String name=request.getParameter("name");
        String surnames=request.getParameter("surnames");
        %>
        <form method="get" action="controlAlumnos.jsp">
            <input type="hidden" name="op" value="edit">
            <input type="hidden" name="id" value=<%=id%> required>
            <input type="text" name="nombre" value=<%=name%> required>
            <input type="text" name="apellidos" value=<%=surnames%> required>
            <input type="submit" value="Confirmar">
        </form>


     <%}else if(mode != null&&mode.equals("delete")){
        long id=Long.parseLong(request.getParameter("id"));
        %>
        <form method="get" action="controlAlumnos.jsp">
            <input type="hidden" name="op" value="delete">
            <input type="hidden" name="id" value=<%=id%> required>
            <input type="submit" value="Confirmar">
        </form>
        <%}if (mode!=null){%>
            <form method="get" action="alumnos.jsp">
                <input type="submit" value="Cancelar">
            </form>
        <%}
        
     }catch (SQLException e) {
        e.printStackTrace();
    } finally {
        pool.closeAll();
    }%>
    
</body>
</html>