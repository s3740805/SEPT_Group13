// Whenever load the page
document.addEventListener('DOMContentLoaded', function () {
    getDoctors();
})

// Remove error message
function appointmentDateErrorOk(){
    document.getElementById("appointmentDateError").style.display = "none"
    document.getElementById("appointmentDateErrorFuture").style.display = "none"
    document.getElementById("appointmentDate").style.boxShadow = ""
}
// Check booking that have booked or not
function checkAvailable() {
    let state = sessionStorage.getItem("state");
    let doctorID = document.getElementById('doctors').value.split('.')[0];
    let date = document.getElementById('appointmentDate').value;
    let today = new Date()
    let bookingDate = new Date (date.split('-')[0],parseInt(date.split('-')[1]) - 1,
        parseInt((date.split('-')[2])) + 1)
    // if the date be booked is less than today, show error
    if (bookingDate < today){
        document.getElementById("appointmentDateError").style.display = "block"
        document.getElementById("appointmentDate").style.boxShadow = "0 0 5px red"
        return
    }
    else {
        // if the date be booked is over one week in advanced
        today.setDate(today.getDate() + 7)
        if (bookingDate > today){
            document.getElementById("appointmentDateErrorFuture").style.display = "block"
            document.getElementById("appointmentDate").style.boxShadow = "0 0 5px red"
            return
        }
        else{
            appointmentDateErrorOk()
        }
    }

    let time = document.getElementById('times').value;
    // console.log ( patientID , patientName,doctorID,date,time)
    let booked = false;
    // GET booking to check
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
        // If have not been booked => POST
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
            // Go back to home page ?!
            window.location.replace("/")
        }
    })
}

// GET doctors for the form
function getDoctors() {
    let doctorList = document.getElementById('doctors')
    doctorList.innerHTML = ''
    fetch('http://localhost:8080/doctors')
        .then(res => res.json())
        .then(json => {
            for (let i = 0; i < json.length; i++) {
                let id = json[i].id
                doctorList.innerHTML += '<option>' + id + '. ' + json[i].name + " -- <i> " + json[i].email + " </i> " +  '</option>'
            }
        })
}

