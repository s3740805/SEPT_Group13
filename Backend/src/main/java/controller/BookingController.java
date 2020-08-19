package controller;

import model.Booking;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.util.List;

@RestController
@Transactional
public class BookingController {

    @Autowired
    private SessionFactory sessionFactory;

    //booking
    @CrossOrigin
    @RequestMapping(path = "/bookings", method = RequestMethod.GET)
    public List<Booking> getBooking() {
        return this.sessionFactory.getCurrentSession().createQuery("from Booking").list();

    }

    @CrossOrigin
    @RequestMapping(path = "/bookings", method = RequestMethod.POST)
    public int add(@RequestBody Booking booking) {
        this.sessionFactory.getCurrentSession().saveOrUpdate(booking);
        return booking.getId();
    }

    @CrossOrigin
    @RequestMapping(path = "/bookings/{id}", method = RequestMethod.DELETE)
    public void deleteBooking(@PathVariable int id) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Booking where id=:id");
        query.setInteger("id", id);

        Booking booking = (Booking) query.uniqueResult();

        this.sessionFactory.getCurrentSession().delete(booking);
    }



    @CrossOrigin
    @RequestMapping(path = "/bookings/{userName}", method = RequestMethod.GET)
    public List<Booking> getBookingbyUser(@PathVariable String userName) {
        Query query = this.sessionFactory.getCurrentSession()
                .createQuery("from Booking where userName=:userName");
        query.setString("userName", userName);
        return query.list();
    }


    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
