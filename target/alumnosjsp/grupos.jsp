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
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Grupos</title>
</head>
<body>
    <%
    String url=(String)session.getAttribute("url");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    try{
        GruposService gService = new GruposService(pool.getConnection());
        %>

        <div class="table">
            <div class="th">
                <div class="td">Nombre</div>
                <div class="td">Tutor</div>
                <div class="td"></div>
                <div class="td">
                    <div class="td">
                        <form method="get" action="controlGrupos.jsp">
                            <input type="hidden" value="create" name="mode">
                                <button type="submit" class="submit students">
                                    <i class="fa fa-user-plus" aria-hidden="true"></i>
                                </button>
                        </form>
                    </div>
                </div>
            </div>

        <% for (Grupo gp : gService.requestAll()) { %>
    
            <div class="tr">
                <div class="td"><%= gp.getName()%></div>
                <div class="td"><%= gp.getHeadTeacherName()%></div>
                <div class="td">
                <form method='get' action='controlGrupos.jsp'>
                <input type='hidden' value='edit' name='mode'/><input type='hidden' name='id' value=<%=gp.getId()%>>
                <input type='hidden' name='name' value=<%=gp.getName()%>><input type='hidden' name='headTeacher' value=<%=gp.getHeadTeacherName()%>>
                <button type="submit" class="submit students">
                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                </button>
                </form>
            </div>
            <div class="td">
                <form method='get' action='controlGrupos.jsp'>
                    <input type='hidden' value='delete' name='mode'/><input type='hidden' name='id' value=<%=gp.getId()%>>
                    <button type="submit" class="submit students">
                        <i class="fa fa-trash" aria-hidden="true"></i>
                    </button>
                </form>
            </div>
            </div>
        <% } %>
    </div>

    <%}catch (SQLException e) {%>
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
    }
%>


<div>
    <form method="get" action="index.jsp">
        <input type="hidden" name="userName" value=<%=session.getAttribute("userName")%>>
        <input type="hidden" name="password" value=<%=session.getAttribute("password")%>>
        <input type="hidden" name="trying" value="access">
        <div class="backButton">
            <button type="submit main"  >
                <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
            </button>
        </div>
    </form>
</div>

</body>
</html>