<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--boostrap--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>

    <style>
        body {
            padding-top: 3.5rem;
        }
    </style>
</head>
<body>
<jsp:include page="../_navigation.jsp"></jsp:include>
<div class="container">
    <div id="bookingBody" class="container-fluid">
        <h1>Booking Form</h1>
        <div class="container">
            <%--<input id="inputID" type="text" class="form-control" placeholder="Enter your patient ID" required/>--%>
            <%--<br>--%>
            <label for="doctors">
                Select a doctor:
            </label>
            <select id="doctors" name="doctors" required>

            </select>
            <br>
            <label for="appointmentDate">
                Select a date:
            </label>
            <input type="date" value="2020-08-01" id="appointmentDate" name="appointmentDate" required>
            <br>
            <label for="times">
                Select a time:
            </label>
            <select id="times" name="times" required>
                <option value="09:00:00">9:00 - 9:30</option>
                <option value="09:30:00">9:30 - 10:00</option>
                <option value="10:00:00">10:00 - 10:30</option>
                <option value="10:30:00">10:30 - 11:00</option>
                <option value="11:00:00">11:00 - 11:30</option>
                <option value="11:30:00">11:30 - 12:00</option>
                <option value="12;00:00">12:00 - 12:30</option>
                <option value="12:30:00">12:30 - 13:00</option>
                <option value="13:00:00">13:00 - 13:30</option>
                <option value="13:30:00">13:30 - 14:00</option>
                <option value="14:00:00">14:00 - 14:30</option>
                <option value="14:30:00">14:30 - 15:00</option>
                <option value="15:00:00">15:00 - 15:30</option>
                <option value="15:30:00">15:30 - 16:00</option>
                <option value="16:00:00">16:00 - 16:30</option>
                <option value="16:30:00">16:30 - 17:00</option>
                <option value="17:00:00">17:00 - 17:30</option>
                <option value="17:30:00">17:30 - 18:00</option>
                <option value="18:00:00">18:00 - 18:30</option>
                <option value="18:30:00">18:30 - 19:00</option>
                <option value="19:00:00">19:00 - 19:30</option>
                <option value="19:30:00">19:30 - 20:00</option>
            </select>

            <br>

                <button class="btn btn-primary" type="submit" onclick="checkAvailable()" value="Book Appointment">Book Appointment</button>

            <br>

        </div>
    </div>
</div>
</body>
</html>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        getDoctors();
    })

    function checkAvailable() {
        let state = sessionStorage.getItem("state");
        let doctorID = document.getElementById('doctors').value.split('.')[0];
        let date = document.getElementById('appointmentDate').value;
        let time = document.getElementById('times').value;
        // console.log ( patientID , patientName,doctorID,date,time)
        let booked = false;
        fetch('http://localhost:8080/bookings')
            .then(res => res.json())
            .then(json => {
                for (let i = 0; i < json.length; i++) {
                    // console.log(doctorID === json[i].doctor_id.toString())
                    // console.log(time === json[i].time.toString())
                    // console.log(date === json[i].date.toString())
                    if (doctorID === json[i].doctor_id.toString()
                        && date === json[i].date.toString()
                        && time === json[i].time.toString()) {
                        booked = true;
                        alert("Cannot confirm booking. Please choose a different date/time/doctor")
                        break;
                    }
                }
            }).then(() => {
            if (booked === false) {
                fetch('http://localhost:8080/bookings', {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: "POST",
                    body: JSON.stringify({doctor_id: doctorID, time: time, date: date, userName: state})

                })
                alert('Booked successfully')
            }
        })
    }
    function getDoctors() {
        let doctorList = document.getElementById('doctors')
        doctorList.innerHTML = ''
        fetch('http://localhost:8080/doctors')
            .then(res => res.json())
            .then(json => {
                for (let i = 0; i < json.length; i++) {
                    let id = json[i].id
                    doctorList.innerHTML += '<option>' + id + '. ' + json[i].name + '</option>'
                }
            })
    }


</script>