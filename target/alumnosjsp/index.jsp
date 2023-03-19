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
    <%
    String trying=request.getParameter("trying");

    if(trying!=null && trying.equals("access")){
    %>
    <title>Menu</title>
    <%}else{%>
        <title>Acceso</title>
    <%}%>
</head>
<body>
    <% 
    
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
            %>
            <div class="menuContainer">
                <div class="menuRow">
                    <div class="menuButton">
                        <form method="POST" action="alumnos.jsp">
                            <div class="submit students">
                                <button type="submit main" class="btn btn-students">
                            <i class="fa fa-graduation-cap" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                        <h1>Alumnado</h1>
                    </div>


                    <div class="menuButton">
                        <form method="POST" action="grupos.jsp">
                            <div class="submit main">
                                <button type="submit main" class="btn btn-groups">
                                    <i class="fa fa-users" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                        <h1>Grupos</h1>
                    </div>

                    
                    <div class="menuButton">
                        <form method="POST" action="matriculacion.jsp">
                            <div class="submit main">
                                <button type="submit main" class="btn btn-register">
                                    <i class="fa fa-file-text" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                        <h1>Matriculación</h1>
                    </div>
                </div>

                <div>
                    <div class="menuButton">
                        <form method="POST" action="index.jsp">
                            <div class="submit main">
                                <button type="submit main" class="btn btn-back">
                                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
          
          
            <%}catch (SQLException e) {%>
                <div class="menuContainer error">
                        <h1>ERROR</h1>
                        <h2>Mensaje de error:</h2> 
                        <span><%out.print(" "+e.toString());%></span>
                    <div class="backButton">
                        <form method="POST" action="index.jsp">
                            <div class="submit main">
                                <button type="submit main" class="btn btn-back">
                                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            <%} finally {
                pool.closeAll();
            }
        }else{%>  
        <div class="menuContainer">
            <div class="title">
                <h1>Acceso</h1>
            </div>
            <form method="POST" action="index.jsp">
                <input type="hidden" name="trying" value="access">
                <div class="item-input">
                    <input type="text" name="userName" value="Usuario">
                </div>
                <div class="item-input">
                    <input type="password" name="password">
                </div>
                <div class="submit students">
                    <button type="submit" class="btn btn-students submit students check">
                        <i class="fa fa-check-square" aria-hidden="true"></i>
                    </button>
                </div>
            </form>
        </div>
    <%}%>
</body>
</html>