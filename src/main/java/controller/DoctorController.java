package controller;

import model.Doctor;


import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.util.List;

@RestController
@Transactional
public class DoctorController {

    @Autowired
    private SessionFactory sessionFactory;

    @CrossOrigin
    @RequestMapping(path = "/doctors", method = RequestMethod.GET)
    public List<Doctor> getDoctor() {
        return this.sessionFactory.getCurrentSession().createQuery("from Doctor").list();

    }

    @CrossOrigin
    @RequestMapping(path = "/doctors/{userName}", method = RequestMethod.GET)
    public List<Doctor> getDoctorbyUser(@PathVariable String userName) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Doctor where userName=:userName");
        query.setString("userName", userName);
        return query.list();
    }

    @CrossOrigin
    @RequestMapping(path = "/doctors", method = RequestMethod.POST)
    public int add(@RequestBody Doctor doctor) {
        this.sessionFactory.getCurrentSession().saveOrUpdate(doctor);
        return doctor.getId();
    }

    @CrossOrigin
    @RequestMapping(path = "/doctors/{id}", method = RequestMethod.DELETE)
    public void deleteDoctor(@PathVariable int id) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Doctor where id=:id");
        query.setInteger("id", id);

        Doctor doctor = (Doctor) query.uniqueResult();

        this.sessionFactory.getCurrentSession().delete(doctor);
    }

    @CrossOrigin
    @RequestMapping(path = "/doctors/{id}", method = RequestMethod.PUT)
    public void updateDoctor(@PathVariable int id, @RequestBody Doctor doctor) {
        Query query = this.sessionFactory.getCurrentSession().createQuery("from Doctor where id=:id");
        ;
        //query.setInteger("id", id);
        doctor.setId(id);
        this.sessionFactory.getCurrentSession().update(doctor);
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
