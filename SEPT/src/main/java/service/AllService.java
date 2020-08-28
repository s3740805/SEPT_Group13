package service;

import model.*;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CoT on 10/14/17.
 */
@Transactional
@Service
public class AllService {

    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    
    //Assign Services

    //Businesses
    public List<Business> getAllBusinesses(){
        return sessionFactory.getCurrentSession().createQuery("from Business").list();
    }

    public Business getBusiness(int businessId){
        return (Business) sessionFactory.getCurrentSession().get(Business.class, businessId);
    }
    
    public void saveBusiness(Business business){
        sessionFactory.getCurrentSession().save(business);
    }
    
    public void updateBusiness(Business business){
        sessionFactory.getCurrentSession().update(business);
    }
    
    public void deleteBusiness(int  businessId){
        Business business = getBusiness(businessId);
        sessionFactory.getCurrentSession().delete(business);
    }

    
    //Customer
    public List<Customer> getAllCustomers(){
        return sessionFactory.getCurrentSession().createQuery("from Customer").list();
    }

    public Customer getCustomer(int customerId){
        return (Customer) sessionFactory.getCurrentSession().get(Customer.class, customerId);
    }
    
    public Customer getCustomerByUsername(String username) {
    	Query query = sessionFactory.getCurrentSession().createQuery("from Customer s where s.username like :username");
    	query.setString("username", "%"+username+"%");
    	return (Customer) query.uniqueResult();
    }
    
    public void saveCustomer(Customer customer){
        sessionFactory.getCurrentSession().save(customer);
    }

    public void updateCustomer(Customer customer){
        sessionFactory.getCurrentSession().update(customer);
    }

    public void deleteCustomer(int customerId){
        Customer customer = getCustomer(customerId);
        sessionFactory.getCurrentSession().delete(customer);
    }
    
    public boolean customerExists(String username) {
    	return getCustomerByUsername(username) != null;
    }
}
