package modelos;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class AlumnosService {
    Connection conn;
    public AlumnosService(Connection conn){
        this.conn = conn;
    }

    public ArrayList<Alumno> requestAll() throws SQLException{
        Statement statement = null;
        ArrayList<Alumno> result = new ArrayList<Alumno>();
        statement = this.conn.createStatement();   
        String sql = "SELECT id, nombre, apellidos, grupo FROM alumnos";
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // Recorrido del resultado de la consulta
        while(querySet.next()) {
            long id = querySet.getInt("id");
            String nombre = querySet.getString("nombre");
            String apellidos = querySet.getString("apellidos");
            long groupID = querySet.getInt("grupo");
            
            result.add(new Alumno(id, nombre, apellidos,groupID));
        } 
        statement.close();    
        return result;
    }

    public Alumno requestById(long id) throws SQLException{
        Statement statement = null;
        Alumno result = null;
        statement = this.conn.createStatement();    
        String sql = String.format("SELECT id, nombre, apellidos, grupo FROM alumnos WHERE id=%d", id);
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // Recorrido del resultado de la consulta
        if(querySet.next()) {
            String nombre = querySet.getString("nombre");
            String apellidos = querySet.getString("apellidos");
            long groupID=querySet.getInt("grupo");
            result = new Alumno(id, nombre, apellidos,groupID);
        }
        statement.close();    
        return result;
    }

    public long create(String nombre, String apellidos,long groupID) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql ;
        if(groupID==0){
             sql = String.format("INSERT INTO alumnos (nombre, apellidos,grupo) VALUES ('%s', '%s',null)", nombre, apellidos);
        }else{
             sql = String.format("INSERT INTO alumnos (nombre, apellidos,grupo) VALUES ('%s', '%s','%s')", nombre, apellidos,groupID);
        }
        // Ejecución de la consulta
        // ES UN ENTERO YA QUE DEVUELVE EL NUMERO DE FILAS AFECTADAS
        long affectedRows = statement.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);

        // SI NO HAY FILAS AFECTADAS DA 0
        if (affectedRows == 0) {
            throw new SQLException("Creating user failed, no rows affected.");
        }
        try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                long id = generatedKeys.getLong(1);
                statement.close();
                return id;
            }
            else {
                // CERRAMOS EL statement
                statement.close();
                // DEVOLVEMOS EL ERROR YA QUE NO HABRÍA DETECTADO LA ID
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        }
    }

    public long create(String nombre, String apellidos,int groupID) throws SQLException{
        return create(nombre, apellidos, (long)groupID);
    }

    public long update(long id, String nombre, String apellidos,long groupID) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql;
        if(groupID==0){
            sql = String.format("UPDATE alumnos SET nombre = '%s', apellidos = '%s', grupo=null  WHERE id=%d", nombre, apellidos, id);
        }else{
        sql = String.format("UPDATE alumnos SET nombre = '%s', apellidos = '%s', grupo='%s' WHERE id=%d", nombre, apellidos,groupID, id);
    }
        // Ejecución de la consulta
        long affectedRows = statement.executeUpdate(sql);
        statement.close();
        if (affectedRows == 0)
            throw new SQLException("Creating user failed, no rows affected.");
        else
            return affectedRows;
    }

    public long update(long id, String nombre, String apellidos,int groupID) throws SQLException{
        return update(id, nombre, apellidos, (long) groupID);
    }

    public boolean delete(long id) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("DELETE FROM alumnos WHERE id=%d", id);
        // Ejecución de la consulta
        int result = statement.executeUpdate(sql);
        statement.close();
        return result==1;
    }
    
    public boolean delete(int id) throws SQLException{
        return delete((long)id);
    }
}
