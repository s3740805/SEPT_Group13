package model;

import javax.persistence.*;
import javax.swing.*;
import java.awt.*;
import java.sql.Date;


@Entity
@Table(name = "patient")
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column

    private String username;
    private String password;
    private String fname;
    private String lname;
    private String gender;
    private Date dob;
    private String bloodType;
    private String email;
    private Integer phone;
    private String address;
    private String allergies;
    private String medicalHistory;
    private String healthStatus;

    @Override
    public String toString() {
        return "Patient{" +
                "id='" + id + '\''+
                ", fname='" +fname + '\''+
                ", lname='" +lname + '\''+
                ", gender='" +gender + '\''+
                ", dob='" +dob + '\''+
                ", bloodType='" +bloodType + '\''+
                ", email='" +email + '\''+
                ", phone='" +phone + '\''+
                ", address='" +address + '\''+
                ", allergies='" +allergies + '\''+
                ", medicalHistory='" +medicalHistory + '\''+
                ", healthStatus='" +healthStatus + '\''+
                '}';
    }

    public Patient(String fname, String lname, String gender, String dob, String bloodType,
                   String email, Integer phone, String address, String allergies, String medicalHistory,
                   String healthStatus){
        this.fname = fname;
        this.lname = lname;
        this.gender = gender;
        this.dob = Date.valueOf(dob);
        this.bloodType = bloodType;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.allergies= allergies;
        this.medicalHistory= medicalHistory;
        this.healthStatus = healthStatus;
    }

    public Patient() {
    }

    // Patient UserName
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Patient Id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    //Patient FName
    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    //Patient Lname
    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }




    //Patient Gender
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    // Patient Password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Patient DOB
    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }


    // Blood Type
    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    //Email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    //Phone
    public Integer getPhone() {
        return phone;
    }

    public void setPhone(Integer phone) {
        this.phone = phone;
    }

    //Address
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // allergies
    public String getAllergies() {
        return allergies;
    }

    public void setAllergies(String allergies) {
        this.allergies = allergies;
    }

    // Medical History
    public String getMedicalHistory() {
        return medicalHistory;
    }

    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    //Health Status
    public String getHealthStatus() {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus) {
        this.healthStatus = healthStatus;
    }



}