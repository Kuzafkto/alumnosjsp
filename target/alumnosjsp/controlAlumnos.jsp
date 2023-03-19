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
     String mode=request.getParameter("mode");
     ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");

     try{
        AlumnosService aService = new AlumnosService(pool.getConnection());

        String op=request.getParameter("op");
        if(op!=null&&op.equals("create")){

                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                aService.create(name,surnames,0); 
                %>

                <div class="menuContainer confirm">
                    <h1>Se ha creado el usuario</h1>
                    <div>
                        <div class="menuButton">
                            <form method="POST" action="alumnos.jsp">
                                <div class="submit main">
                                    <button type="submit main" class="btn btn-back">
                                        <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
        <%}else if(op!=null&&(op.equals("edit")||op.equals("unassign")||op.equals("assign"))){
                long id=Long.parseLong(request.getParameter("id"));
                String name=request.getParameter("nombre");
                String surnames=request.getParameter("apellidos");
                if(op.equals("assign")){
                    Long groupID=Long.parseLong(request.getParameter("id_grupo"));
                    aService.update(id,name,surnames,groupID);%>

                    <div class="menuContainer confirm">
                        <h1>Se ha matriculado el usuario</h1>
                        <div>
                            <div class="menuButton">
                                <form method="POST" action="matriculacion.jsp">
                                    <div class="submit main">
                                        <button type="submit main" class="btn btn-back">
                                            <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                   <%}else{
                    aService.update(id,name,surnames,0);
                    if(op.equals("edit")){%>

                        <div class="menuContainer confirm">
                            <h1>Se ha editado el usuario</h1>
                            <div>
                                <div class="menuButton">
                                    <form method="POST" action="alumnos.jsp">
                                        <div class="submit main">
                                            <button type="submit main" class="btn btn-back">
                                                <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
    
                   <%}else{%>

                    <div class="menuContainer confirm">
                        <h1>Se ha desmatriculado el usuario</h1>
                        <div>
                            <div class="menuButton">
                                <form method="POST" action="matriculacion.jsp">
                                    <div class="submit main">
                                        <button type="submit main" class="btn btn-back">
                                            <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <% }
                }

        }else if(op!=null&&op.equals("delete")){

                long id=Long.parseLong(request.getParameter("id"));
                aService.delete(id); %>
                <div class="menuContainer confirm">
                    <h1>Se ha borrado el usuario</h1>
                    <div>
                        <div class="menuButton">
                            <form method="POST" action="alumnos.jsp">
                                <div class="submit main">
                                    <button type="submit main" class="btn btn-back">
                                        <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            <%}
        if (mode != null && mode.equals("create")){

   %>

   <div class="menuContainer">
    <form method="POST" action="controlAlumnos.jsp">
    <input type="hidden" name="op" value="create">
    <div class="item-input">
        <input type="text" name="nombre" required>
    </div>
    <div class="item-input">
        <input type="text" name="apellidos" required>
    </div>
    <div class="submit students">
        <button type="submit" class="btn btn-students submit students check">
            <i class="fa fa-check-square" aria-hidden="true"></i>
        </button>
    </div>
    </form>

    <div class="menuButton">
        <form method="POST" action="alumnos.jsp">
            <div class="submit main">
                <button type="submit main" class="btn btn-back">
                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                </button>
            </div>
        </form>
    </div>

   </div>
    <%}else if( mode != null&&mode.equals("edit")){
        long id=Long.parseLong(request.getParameter("id"));
        String name=request.getParameter("name");
        String surnames=request.getParameter("surnames");
        %>


        <div class="menuContainer">
        <form method="POST" action="controlAlumnos.jsp">
            <input type="hidden" name="op" value="edit">
            <input type="hidden" name="id" value=<%=id%> required>
            <div class="item-input">
                <input type="text" name="nombre" value=<%=name%> required>
            </div>
            <div class="item-input">
                <input type="text" name="apellidos" value=<%=surnames%> required>
            </div>
            <div class="submit students">
                <button type="submit" class="btn btn-students submit students check">
                    <i class="fa fa-check-square" aria-hidden="true"></i>
                </button>
            </div>
            </form>
        
            <div class="menuButton">
                <form method="POST" action="alumnos.jsp">
                    <div class="submit main">
                        <button type="submit main" class="btn btn-back">
                            <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                        </button>
                    </div>
                </form>
            </div>
           </div>

     <%}else if(mode != null&&mode.equals("delete")){
        long id=Long.parseLong(request.getParameter("id"));
        %>
        <div class="menuContainer">
            <form method="POST" action="controlAlumnos.jsp">
                <input type="hidden" name="op" value="delete">
                <input type="hidden" name="id" value=<%=id%> required>
                <div class="submit students">
                    <button type="submit" class="btn btn-students submit students check">
                        <i class="fa fa-check-square" aria-hidden="true"></i>
                    </button>
                </div>
                </form>
                <div class="menuButton">
                    <form method="POST" action="alumnos.jsp">
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
            <div>
                <div class="menuButton">
                    <form method="POST" action="alumnos.jsp">
                        <div class="submit main">
                            <button type="submit main" class="btn btn-back">
                                <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
    </div>
    <%} finally {
        pool.closeAll();
    }%>
    
</body>
</html>