package modelos;

public class Alumno {
    long id;
    String nombre;
    String apellidos;
    long groupID;
 
    public Alumno(){
        this(0,"","",0);
    }

    public Alumno(long id, String nombre, String apellidos,long groupID){
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.groupID=groupID;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getGroupID() {
        return groupID;
    }

    
    public void setGroupID(long groupID) {
        this.groupID = groupID;
    }

    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }


    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    @Override
    public String toString() {
        return String.format("ID: %d, Nombre: %s, Apellidos: %s, ID Grupo: %s", this.id, this.nombre, this.apellidos,this.groupID);
    }
}
