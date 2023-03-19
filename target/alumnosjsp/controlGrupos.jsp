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
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

    try{
        GruposService gService = new GruposService(pool.getConnection());

       op=request.getParameter("op");

        if(op!=null&&op.equals("create")){
                 name=request.getParameter("nombre");
                 head=request.getParameter("proCab");
                gService.create(name,head);%>

                <div class="menuContainer confirm">
                    <h1>Se ha creado el grupo</h1>
                    <div>
                        <div class="menuButton">
                            <form method="get" action="grupos.jsp">
                                <div class="submit main">
                                    <button type="submit main" class="btn btn-back">
                                        <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
        <%}else if (mode != null && mode.equals("create")){%>


  <div class="menuContainer">
    <form method="get" action="controlGrupos.jsp">
    <input type="hidden" value="create" name="mode">
       <input type="hidden" name="op" value="create">
    <div class="item-input">
        <input type="text" name="nombre" required>
    </div>
    <div class="item-input">
        <input type="text" name="proCab" >
    </div>
    <div class="submit students">
        <button type="submit" class="btn btn-students submit students check">
            <i class="fa fa-check-square" aria-hidden="true"></i>
        </button>
    </div>
    </form>

    <div class="menuButton">
        <form method="get" action="grupos.jsp">
            <div class="submit main">
                <button type="submit main" class="btn btn-back">
                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                </button>
            </div>
        </form>
    </div>

   <%}else if(op!=null&&op.equals("edit")){
            id=Long.parseLong(request.getParameter("id"));
            name=request.getParameter("nombre");
            head=request.getParameter("proCab");
            gService.update(id,name,head);%>


            <div class="menuContainer confirm">
                <h1>Se ha editado el grupo</h1>
                <div>
                    <div class="menuButton">
                        <form method="get" action="grupos.jsp">
                            <div class="submit main">
                                <button type="submit main" class="btn btn-back">
                                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
    <%}else if( mode != null&&mode.equals("edit")){
        id=Long.parseLong(request.getParameter("id"));
        name=request.getParameter("name");
        head=request.getParameter("headTeacher");
       %>

       <div class="menuContainer">
        <form method="get" action="controlGrupos.jsp">
            <input type="hidden" name="mode" value="edit">
           <input type="hidden" name="op" value="edit">
           <input type="hidden" name="id" value=<%=id%> required>
            <div class="item-input">
                <input type="text" name="nombre" value=<%=name%> required>
            </div>
            <div class="item-input">
                <input type="text" name="proCab" value=<%=head%>>
            </div>
            <div class="submit students">
                <button type="submit" class="btn btn-students submit students check">
                    <i class="fa fa-check-square" aria-hidden="true"></i>
                </button>
            </div>
            </form>
        
            <div class="menuButton">
                <form method="get" action="grupos.jsp">
                    <div class="submit main">
                        <button type="submit main" class="btn btn-back">
                            <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                        </button>
                    </div>
                </form>
            </div>
           </div>


    <%}else if(op!=null&&op.equals("delete")){
        id=Long.parseLong(request.getParameter("id"));
        try{
            gService.delete(id);
        }catch(SQLException e){
            out.print("<span>"+e.toString()+"</span>");
        }
     %>

        <div class="menuContainer confirm">
            <h1>Se ha borrado el grupo</h1>
            <div>
                <div class="menuButton">
                    <form method="get" action="grupos.jsp">
                        <div class="submit main">
                            <button type="submit main" class="btn btn-back">
                                <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    <%}else if(mode != null&&mode.equals("delete")){
        id=Long.parseLong(request.getParameter("id"));
       %>
       <div class="menuContainer">
        <form method="get" action="controlGrupos.jsp">
            <input type="hidden" name="op" value="delete">
            <input type="hidden" name="id" value=<%=id%> required>
            <div class="submit students">
                <button type="submit" class="btn btn-students submit students check">
                    <i class="fa fa-check-square" aria-hidden="true"></i>
                </button>
            </div>
            </form>
            <div class="menuButton">
                <form method="get" action="grupos.jsp">
                    <div class="submit main">
                        <button type="submit main" class="btn btn-back">
                            <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                        </button>
                    </div>
                </form>
            </div>
           </div>
       <%}
       
    }catch (SQLException e) {%>
        <div class="menuContainer error">
            <h1>ERROR</h1>
            <h2>Mensaje de error:</h2> 
            <span><%out.print(" "+e.toString());%></span>
        <div class="backButton">
            <form method='get' action='grupos.jsp'>
                <div class='submit'>
                    <input type='submit' value='Volver'>
                </div>
            </form>
        </div>
    </div>
   <%} finally {
       pool.closeAll();
   }%>
</body>
</html>