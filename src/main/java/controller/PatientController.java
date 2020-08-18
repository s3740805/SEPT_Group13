package controller;

import model.Patient;

import java.sql.Time;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.util.List;

@RestController
@Transactional
public class PatientController {

    @Autowired
    private SessionFactory sessionFactory;

    // patient
    @CrossOrigin
    @RequestMapping(path = "/patients", method = RequestMethod.GET)
    public List<Patient> getPatients() {
        return this.sessionFactory.getCurrentSession().createQuery("from Patient").list();

    }

    @CrossOrigin
    @RequestMapping(path = "/patients", method = RequestMethod.POST)
    public int add(@RequestBody Patient patient) {
        this.sessionFactory.getCurrentSession().saveOrUpdate(patient);
        return patient.getId();
    }

    @CrossOrigin
    @RequestMapping(path = "/patients/{id}", method = RequestMethod.DELETE)
    public void deletePatient(@PathVariable int id) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Patient where id=:id");
        query.setInteger("id", id);

        Patient patient = (Patient) query.uniqueResult();

        this.sessionFactory.getCurrentSession().delete(patient);
    }

//    @CrossOrigin
//    @RequestMapping(path = "/patients/{id}", method = RequestMethod.PUT)
//    public void updatePatient(@PathVariable int id, @RequestBody Patient patient) {
//        Query query =this.sessionFactory.getCurrentSession().createQuery("from Patient where id=:id");;
//        //query.setInteger("id", id);
//        patient.setId(id);
//        this.sessionFactory.getCurrentSession().update(patient);
//    }

    @CrossOrigin
    @RequestMapping(path = "/patients/{username}", method = RequestMethod.PUT)
    public void updatePatientbyUser(@PathVariable String username, @RequestBody Patient patient) {
        Query query = this.sessionFactory.getCurrentSession().createQuery("from Patient where username=:username");
        patient.setUsername(username);
        this.sessionFactory.getCurrentSession().update(patient);
    }

    @CrossOrigin
    @RequestMapping(path = "/patients/{username}", method = RequestMethod.GET)
    public Patient getPatientbyUser(@PathVariable String username) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Patient where username=:username");
        query.setString("username", username);
        Patient patient = (Patient) query.uniqueResult();
        return patient;
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
