<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    String url=(String)session.getAttribute("url");
    String userName=(String)session.getAttribute("userName");
    String password=(String)session.getAttribute("password");
    ConnectionPool pool=(ConnectionPool)session.getAttribute("pool");
    try{
        AlumnosService aService = new AlumnosService(pool.getConnection());
        GruposService gService = new GruposService(pool.getConnection());
        
        for (Grupo gp : gService.requestAll()) {
            out.print("<span>"+gp.toString()+"</span><br>");
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