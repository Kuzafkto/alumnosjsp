<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="connection.ConnectionPool" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matriculacion</title>
</head>
<body>
    <%
    String mode=request.getParameter("mode");
    String url=(String)session.getAttribute("url");
    out.print("test");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
   
    try{
        AlumnosService aService = new AlumnosService(pool.getConnection());
        GruposService gService = new GruposService(pool.getConnection());
    
    
        if(mode!=null && mode.equals("assign")){
            for (Grupo gp : gService.requestAll()) {
                out.print("<span>"+gp.toString()+"</span><br><form method='get' action='controlAlumnos.jsp'>"+
                    "<input type='hidden' value='assign' name='op' />"+
                    "<input type='hidden' name='id' value='"+Long.parseLong(request.getParameter("id"))+"'/>"+
                    "<input type='hidden' name='nombre' value='"+request.getParameter("nombre")+"'/>"+
                    "<input type='hidden' name='apellidos' value='"+request.getParameter("apellidos")+"'/>"+
                    "<input type='hidden' name='id_grupo' value='"+gp.getId()+"'/>"+
                    "<input type='submit' value='Matricular'/></form>");                    
            }    
            out.print("<form method='post' action='matriculacion.jsp'><input type='submit' value='Volver'></form>");
        }else{
            for (Alumno al : aService.requestAll()) {
                out.print("<span>"+al.toString()+"</span><br>"+
                "<form method='get' action='matriculacion.jsp'>"+
                    "<input type='hidden' value='assign' name='mode' />"+
                    "<input type='hidden' name='id' value='"+al.getId()+"'/>"+
                    "<input type='hidden' name='nombre' value='"+al.getNombre()+"'/>"+
                    "<input type='hidden' name='apellidos' value='"+al.getApellidos()+"'/>"+
                    "<input type='hidden' name='id_grupo' value='"+al.getGroupID()+"'/>"+
                    "<input type='submit' value='Matricular'/></form>"+
    
                        "<form method='get' action='controlAlumnos.jsp'>"+
                        "<input type='hidden' value='unassign' name='op' />"+
                        "<input type='hidden' name='id' value='"+al.getId()+"'/>"+
                        "<input type='hidden' name='nombre' value='"+al.getNombre()+"'/>"+
                        "<input type='hidden' name='apellidos' value='"+al.getApellidos()+"'/>"+
                        "<input type='submit' value='Desmatricular'/></form>");
            } 
             
      out.print("<form method='get' action='index.jsp'>"+
        "<input type='hidden' name='userName' value='"+session.getAttribute("userName")+"'/>"+
        "<input type='hidden' name='password' value='"+session.getAttribute("password")+"'/>"+
        "<input type='hidden' name='trying' value='access'/>"+
        "<input type='submit' value='Volver'></form>");
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