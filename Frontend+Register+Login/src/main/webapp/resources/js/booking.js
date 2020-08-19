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
                doctorList.innerHTML += '<option>' + id + '. ' + json[i].name + " -- <i> " + json[i].email + " </i> " +  '</option>'
            }
        })
}

