package modelos;

public class Grupo {
    long id;
    String curso;
    String headTeacherName;

    public Grupo(){
        this(0,"","");
    }

    public Grupo(long id,String curso, String headTeacherName){
        this.id=id;
        this.curso=curso;
        this.headTeacherName=headTeacherName;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return curso;
    }
    public void setName(String curso) {
        this.curso = curso;
    }
    public String getHeadTeacherName() {
        return headTeacherName;
    }
    public void setHeadTeacherName(String headTeacherName) {
        this.headTeacherName = headTeacherName;
    }
    @Override
    public String toString() {
        return String.format("ID: %d, Nombre: %s, Profesor Cabecera: %s", this.id, this.curso, this.headTeacherName);
    }
}
