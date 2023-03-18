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
   long id=0;
   String name;
   String head;
   String op;
    String mode=request.getParameter("mode");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    //RECUERDA DESPUES DE QUE ESTO EN VEZ DE SER UNA VARIABLE DE SESION QUE SEA UNA NUEVA POOL CON EL nombre Y CONTRASEÑA DE usuario
    //PASADOS EN EL FORM POR SI ES QUE LA POOL SE DESCONECTA

    try{
        GruposService gService = new GruposService(pool.getConnection());

       op=request.getParameter("op");

       if (mode != null && mode.equals("create")){
        if(op!=null&&op.equals("create")){
                 name=request.getParameter("nombre");
                 head=request.getParameter("proCab");
                gService.create(name,head);
                out.print("<span>Se ha creado el grupo "+name+"</span>");
        }
  %>

   <form method="get" action="controlGrupos.jsp">
        <input type="hidden" value="create" name="mode">
       <input type="hidden" name="op" value="create">
       <input type="text" name="nombre" required>
       <input type="text" name="proCab" >
       <input type="submit" value="Crear">
   </form>
   <%}else if( mode != null&&mode.equals("edit")){
       id=Long.parseLong(request.getParameter("id"));
       name=request.getParameter("name");
       head=request.getParameter("headTeacher");

       if(op!=null&&op.equals("edit")){
            id=Long.parseLong(request.getParameter("id"));
            name=request.getParameter("nombre");
            head=request.getParameter("proCab");
            gService.update(id,name,head);
            out.print("<span>Se ha editado el grupo "+name+"</span>");
    }else
       %>
       <form method="get" action="controlGrupos.jsp">
        <input type="hidden" name="mode" value="edit">
           <input type="hidden" name="op" value="edit">
           <input type="hidden" name="id" value=<%=id%> required>
           <input type="text" name="nombre" value=<%=name%> required>
           <input type="text" name="proCab" value=<%=head%> >
           <input type="submit" value="Confirmar">
       </form>


    <%}else if(op!=null&&op.equals("delete")){
        id=Long.parseLong(request.getParameter("id"));
        gService.delete(id);
        out.print("<span>Se ha borrado el grupo</span>");
        
        %>
        <form method="get" action="grupos.jsp">
            <input type="submit" value="Volver">
        </form>

    <%} else if(mode != null&&mode.equals("delete")){
        id=Long.parseLong(request.getParameter("id"));
       %>
       <form method="get" action="controlGrupos.jsp">
           <input type="hidden" name="op" value="delete">
           <input type="hidden" name="id" value=<%=id%> required>
           <input type="submit" value="Confirmar">
       </form>
       <%}if(mode!=null){%>
        <form method="get" action="grupos.jsp">
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