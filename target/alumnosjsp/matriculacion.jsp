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
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Matriculacion</title>
</head>
<body>
    <%
    String mode=request.getParameter("mode");
    String url=(String)session.getAttribute("url");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
   
    try{
        AlumnosService aService = new AlumnosService(pool.getConnection());
        GruposService gService = new GruposService(pool.getConnection());
    
    %>

        
        <% if(mode!=null && mode.equals("assign")){%>
            
    <div class="table">
        <div class="th">
            <div class="td">Nombre</div>
            <div class="td">Tutor</div>
            <div class="td"></div>
        </div>
            <%for (Grupo gp : gService.requestAll()) {%>

                <div class="tr">
                    <div class="td"><%= gp.getName()%></div>
                    <div class="td"><%= gp.getHeadTeacherName()%></div>
                    <div class="td">
                        <form method='POST' action='controlAlumnos.jsp'>
                            <input type='hidden' value='assign' name='op' />
                            <input type='hidden' name='id' value=<%=Long.parseLong(request.getParameter("id"))%>>
                            <input type='hidden' name='nombre' value=<%=request.getParameter("nombre")%>>
                            <input type='hidden' name='apellidos' value=<%=request.getParameter("apellidos")%>>
                            <input type='hidden' name='id_grupo' value=<%=gp.getId()%>>
                            <button type="submit" class="submit students">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                            </button>
                        </form> 
                </div>
                </div>
                   
            
            
            <%}%>
    </div>


    <div>
        <form method="POST" action="matriculacion.jsp">
            <div class="backButton">
                <button type="submit main">
                    <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                </button>
            </div>
        </form>
    </div>
        <%    
        }else{ %>

        <div class="table">
                <div class="th">
                    <div class="td">Nombre</div>
                    <div class="td">Apellidos</div>
                    <div class="td">Curso</div>
                    <div class="td"></div>
                    <div class="td"></div>
                </div>

            <% for (Alumno al : aService.requestAll()) { %>

                <div class="tr">
                    <div class="td"><%= al.getNombre()%></div>
                    <div class="td"><%= al.getApellidos()%></div>
                    <div class="td"><%= al.getGroupName()%></div>
                    <div class="td">
                        <form method='POST' action='matriculacion.jsp'>
                            <input type='hidden' value='assign' name='mode' >
                            <input type='hidden' name='id' value=<%=al.getId()%>>
                            <input type='hidden' name='nombre' value=<%=al.getNombre()%>>
                            <input type='hidden' name='apellidos' value=<%=al.getApellidos()%>>
                            <input type='hidden' name='id_grupo' value=<%=al.getGroupID()%>>
                            <button type="submit" class="submit students">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                            </button>
                        </form>
                    </div>

                    <div class="td">
                        <form method='POST' action='controlAlumnos.jsp'>
                            <input type='hidden' value='unassign' name='op'>
                            <input type='hidden' name='id' value=<%=al.getId()%>>
                            <input type='hidden' name='nombre' value=<%=al.getNombre()%>>
                            <input type='hidden' name='apellidos' value=<%=al.getApellidos()%>>
                            <button type="submit" class="submit students">
                                <i class="fa fa-minus-circle" aria-hidden="true"></i>
                            </button>
                        </form>
                    </div>
                </div>
            <%}%> 
        </div>

        <div>
            <form method="POST" action="index.jsp">
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
        <%}

    }catch (SQLException e) {%>
        <div class="menuContainer error">
            <h1>ERROR</h1>
            <h2>Mensaje de error:</h2> 
            <span><%out.print(" "+e.toString());%></span>
        <div class="backButton">
            <form method='POST' action='matriculacion.jsp'>
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
</body>
</html>