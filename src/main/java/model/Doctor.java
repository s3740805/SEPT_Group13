package model;

import javax.persistence.*;

@Entity
@Table(name="doctor")
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column
    private String name;
    private String email;
    private String description;

    public Doctor() {
    }

    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email;}

    public void setEmail(String email) { this.email = email;}

    public String getDescription() { return description;}

    public void setDescription(String description) { this.description = description;}
}
