package modelos;

public class Alumno {
    long id;
    String nombre;
    String apellidos;
    long groupID;
    String groupName;
    public Alumno(){
        this(0,"","",0,"");
    }

    public Alumno(long id, String nombre, String apellidos, long groupID, String groupName){
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.groupID=groupID;
        this.groupName=groupName;
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

    public String getGroupName() {
        return groupName;
    }
    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public String toString() {
        return String.format("ID: %d, Nombre: %s, Apellidos: %s, Nombre Grupo: %s", this.id, this.nombre, this.apellidos,this.groupName);
    }
}
