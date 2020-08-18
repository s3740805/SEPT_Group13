const doctorContainer = document.querySelector('#doctor-container')
const doctorEditor = document.querySelector('#edit-form')
const doctorURL = `http://localhost:8080/doctors`
const doctorForm = document.querySelector('#doctor-form')
let allDoctors = []
const booking = document.querySelector('#booking')

document.addEventListener('DOMContentLoaded', function () {

    //fetchDoctor
    fetchDoctors();


    //add new Doctors
    doctorForm.addEventListener('submit', (e) => {
        e.preventDefault()
        console.log(e.target)
        const nameInput = doctorForm.querySelector('#name').value
        const emailInput = doctorForm.querySelector('#email').value
        const descInput = doctorForm.querySelector('#description').value
        fetch(`${doctorURL}`, {
            method: 'POST',
            body: JSON.stringify({
                name: nameInput,
                email: emailInput,
                description: descInput
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(response => {
            doctorForm.querySelector('#name').value = '', doctorForm.querySelector('#email').value = '', doctorForm.querySelector('#description').value = '',
                alert('New doctor have been added successfully.')
            fetchDoctors()
        })

    })

    //addEventlistener to 2 button edit and delete
    doctorContainer.addEventListener('click', (e) => {
        //if click edit
        if (e.target.dataset.action === 'edit') {
            //go to top of page
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
            console.log('press edit')
            //get targeted doctor id
            const doctorData = allDoctors.find((doctor) => {
                return doctor.id == e.target.dataset.id
            })
            //show edit form
            document.getElementById('spoiler').style.display = 'block';
            self = this;
            doctorEditor.innerHTML = '';
            doctorEditor.innerHTML += `
            <div id='edit-doctor'>
                <form id="doctor-form">
                    <div class="input-group mb-3">
                    <input required id="edit-name" value="${doctorData.name}" class="form-control">
                    <input required type="email" name="email" id="edit-email" value="${doctorData.email}" class="form-control">
                    <input required id="edit-description" value="${doctorData.description}" class="form-control">
                    <div class="input-group-prepend">
                    <input class="btn btn-outline-primary" type="submit" value="Edit Doctor">
                    <a onclick="CloseInput()" aria-label="Close" data-toggle="tooltip" data-placement="top" title="Close edit">&#10006;</a>
                    </div>
                    </div>
                </form>
            </div>`
            console.log(doctorData)
            //addEventlistener to submit button
            const editForm = document.querySelector(`#edit-doctor`)
            editForm.addEventListener("submit", (e) => {
                event.preventDefault()
                const nameInput = document.querySelector("#edit-name").value
                const emailInput = document.querySelector("#edit-email").value
                const descInput = document.querySelector("#edit-description").value
                //const editedDoctor = document.querySelector(`#doctor-${doctorData.id}`)
                fetch(`${doctorURL}/${doctorData.id}`, {
                    method: 'PUT',
                    body: JSON.stringify({
                        name: nameInput,
                        email: emailInput,
                        description: descInput
                    }),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(response => {
                    //refresh the form
                    document.querySelector("#edit-name").value = '', document.querySelector("#edit-email").value = '', document.querySelector("#edit-description").value = '',
                        //success alert
                        alert('Doctor information have been updated successfully.')
                    fetchDoctors()
                })
            })
            //if click delete
        } else if (e.target.dataset.action === 'delete') {
            if (confirm('Do you want to delete this doctor?')) {
                console.log('press delete')
                fetch(`${doctorURL}/${e.target.dataset.id}`, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(response => fetchDoctors())
            }
        }
        // else if (e.target.dataset.action === 'booking') {
        //     console.log('booking')
        //     fetch(`http://localhost:8080/bookings`)
        //         .then(response => response.json())
        //         .then(function (doc) {
        //             let book = doc.filter(d => (d.doctor_id == e.target.dataset.id))
        //             for (var i = 0; i < book.length; i++) {
        //                 booking.innerHTML+= book[i].id;
        //             }
        //         })
        //
        // }

    })
})

//close edit form button
function CloseInput() {
    document.getElementById('spoiler').style.display = 'none';
    doctorEditor.innerHTML = '';
}

//fetch Doctors
function fetchDoctors() {
    doctorContainer.innerHTML = ''
    fetch(`${doctorURL}`)
        .then(response => response.json())
        .then(function (doc) {
            //sort by doctor id small to large
            let doctor = doc.filter(d => !(d.id == null)).sort((a, b) => parseFloat(a.id) - parseFloat(b.id));
            for (var i = 0; i < doctor.length; i++) {
                allDoctors = doctor
                var n = doctor[i].name;
                var listItem = document.createElement('tr');
                var deleteLink = `<button class="btn btn-outline-primary" data-id="${doctor[i].id}" id="edit-${doctor[i].id}" data-action="edit">Edit</button>`
                var editLink = `<button  class="btn btn-outline-primary" data-id="${doctor[i].id}" id="delete-${doctor[i].id}" data-action="delete">Delete</button>`
                //var booking = `<button  class="btn btn-outline-primary" data-id="${doctor[i].id}" id="bookinhg-${doctor[i].id}" data-action="booking">Show Bookings</button>`
                //var b = `<div id="booking"></div>`
                listItem.innerHTML += '<td>' + doctor[i].name + '</td>';
                listItem.innerHTML += '<td>' + doctor[i].email + '</td>';
                listItem.innerHTML += '<td>' + doctor[i].description + '</td>';
                //listItem.innerHTML += '<td>' + booking  + b + '</td>';
                listItem.innerHTML += '<td>' + deleteLink + editLink + '</td>';
                doctorContainer.appendChild(listItem);
            }
        })
}
