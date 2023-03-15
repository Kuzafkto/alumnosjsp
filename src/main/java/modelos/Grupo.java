package modelos;

public class Grupo {
    long id;
    String name;
    String headTeacherName;

    public Grupo(){
        this(0,"","");
    }

    public Grupo(long id,String name, String headTeacherName){
        this.id=id;
        this.name=name;
        this.headTeacherName=headTeacherName;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getHeadTeacherName() {
        return headTeacherName;
    }
    public void setHeadTeacherName(String headTeacherName) {
        this.headTeacherName = headTeacherName;
    }
    @Override
    public String toString() {
        return String.format("ID: %d, Nombre: %s, Profesor Cabecera: %s", this.id, this.name, this.headTeacherName);
    }
}
