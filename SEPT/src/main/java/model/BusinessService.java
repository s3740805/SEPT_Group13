package model;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name = "businessService")
@JsonIdentityInfo(scope = BusinessService.class,
  generator = ObjectIdGenerators.PropertyGenerator.class, 
  property = "id")
public class BusinessService {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne
    // @JsonIgnore
    private Business business;
    
    @Column
    private String description;
    
    @Column
    private String workingHours;
    
    @Column
    private ArrayList<String> employees;

    @OneToMany(mappedBy = "businessService", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Booking> bookings;

    public BusinessService() {
    }
    
    public BusinessService(String description) {
		this.description = description;
	}

	public BusinessService(int id, Business business, String description, String workingHours,
			ArrayList<String> employees, List<Booking> bookings) {
		super();
		this.id = id;
		this.business = business;
		this.description = description;
		this.workingHours = workingHours;
		this.employees = employees;
		this.bookings = bookings;
	}



	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    public ArrayList<String> getEmployees() {
        return employees;
    }

    public void setEmployees(ArrayList<String> employees) {
        this.employees = employees;
    }

    public List<Booking> getBookings() {
        return bookings;
    }

    public void setBookings(List<Booking> bookings) {
        this.bookings = bookings;
    }
}
