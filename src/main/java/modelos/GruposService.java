package modelos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class GruposService {
    Connection conn;
    public GruposService(Connection conn){
        this.conn = conn;
    }

    public ArrayList<Grupo> requestAll() throws SQLException{
        Statement statement = null;
        ArrayList<Grupo> result = new ArrayList<Grupo>();
        statement = this.conn.createStatement();   
        String sql = "SELECT id, curso, IFNULL(profesor,'Sin_Profesor') as 'profesor' FROM grupos";
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // Recorrido del resultado de la consulta
        while(querySet.next()) {
            long id = querySet.getInt("id");
            String curso = querySet.getString("curso");
            String prof = querySet.getString("profesor");
            result.add(new Grupo(id, curso,prof));
        } 
        statement.close();    
        return result;
    }

    public Grupo requestById(long id) throws SQLException{
        Statement statement = null;
        Grupo result = null;
        statement = this.conn.createStatement();    
        String sql = String.format("SELECT id, curso, IFNULL(profesor,'Sin_Profesor') as 'profesor' FROM grupos WHERE id=%d", id);
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // Recorrido del resultado de la consulta
        if(querySet.next()) {
            String curso = querySet.getString("curso");
            String prof = querySet.getString("profesor");
            result = new Grupo(id, curso,prof);
        }
        statement.close();    
        return result;
    }

    public long create(String curso, String prof) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql;
        if(prof.equals("")){
             sql = String.format("INSERT INTO grupos (curso, profesor) VALUES ('%s',null)", curso);
        }else{
             sql = String.format("INSERT INTO grupos (curso, profesor) VALUES ('%s', '%s')", curso,prof);
        }
        // Ejecución de la consulta
        long affectedRows = statement.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
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
                statement.close();
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        }
    }

    public long update(long id, String curso, String prof) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("UPDATE grupos SET curso = '%s', profesor = '%s' WHERE id=%d", curso, prof, id);
        // Ejecución de la consulta
        long affectedRows = statement.executeUpdate(sql);
        statement.close();
        if (affectedRows == 0)
            throw new SQLException("Creating user failed, no rows affected.");
        else
            return affectedRows;
    }

    public boolean delete(long id) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("DELETE FROM grupos WHERE id=%d", id);
        // Ejecución de la consulta
        int result = statement.executeUpdate(sql);
        statement.close();
        return result==1;
    }
}
