# COSC2101 SEPT

# Doctor Appointment Booking System

### Group 13
> * Nguyen Le Thuy Linh
> * Nguyen Phuoc Cuong
> * Truong Phu Cuong
> * Le Ngoc Danh

### Backend using:
* MySQL
* Spring MVC
* Hibernate

### Before running:
- Go to file `.../config/AppConfig.java` and make changes based on your database.    
```
  dataSource.setDriverClassName("com.mysql.jdbc.Driver");
  dataSource.setUrl("jdbc:mysql://localhost:[your port]/[your schema]");
  dataSource.setUsername([your username]);
  dataSource.setPassword([your password]);
```
### Running:
- Open terminal
```
  cd [your path to ../Backend]
  mvn clean install
  mvn jetty:run
```

`Access through:` http://localhost:8080/ + [database name]


    
   
