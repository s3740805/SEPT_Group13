const doctorContainer = document.querySelector('#doctor-container')
const doctorEditor = document.querySelector('#edit-form')
const doctorURL = `http://localhost:8080/doctors`
const doctorForm = document.querySelector('#doctor-form')
let allDoctors = []
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
        }).then(response => fetchDoctors())

    })
    doctorContainer.addEventListener('click', (e) => {
        if (e.target.dataset.action === 'edit') {
            console.log('press edit')
            const doctorData = allDoctors.find((doctor) => {
                return doctor.id == e.target.dataset.id
            })
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
                    <a onclick="CloseInput()" aria-label="Close">&#10006;</a>
                    </div>
                    </div>
                </form>
            </div>`
            console.log(doctorData)
            const editForm = document.querySelector(`#edit-doctor`)
            editForm.addEventListener("submit", (e) => {
                event.preventDefault()
                const nameInput = document.querySelector("#edit-name").value
                const emailInput = document.querySelector("#edit-email").value
                const descInput = document.querySelector("#edit-description").value
                const editedDoctor = document.querySelector(`#doctor-${doctorData.id}`)
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
                }).then(response => fetchDoctors())
            }) 
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

    })
})
function CloseInput(editButton) {
    document.getElementById('spoiler').style.display = 'none';
    doctorEditor.innerHTML = '';
}
function fetchDoctors() {
    doctorContainer.innerHTML = ''
    fetch(`${doctorURL}`)
        .then(response => response.json())
        .then(function (doctor) {
            for (var i = 0; i < doctor.length; i++) {
                allDoctors = doctor
                var n = doctor[i].name;
                var listItem = document.createElement('tr');
                var deleteLink = `<button class="btn btn-outline-primary" data-id="${doctor[i].id}" id="edit-${doctor[i].id}" data-action="edit">Edit</button>`
                var editLink = `<button  class="btn btn-outline-primary" data-id="${doctor[i].id}" id="delete-${doctor[i].id}" data-action="delete">Delete</button>`
                listItem.innerHTML += '<td>' + doctor[i].name + '</td>';
                listItem.innerHTML += '<td>' + doctor[i].email + '</td>';
                listItem.innerHTML += '<td>' + doctor[i].description + '</td>';
                listItem.innerHTML += '<td>' + deleteLink + editLink + '</td>';
                doctorContainer.appendChild(listItem);

            }
        })
}