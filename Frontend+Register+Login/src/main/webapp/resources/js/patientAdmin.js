const patientContainer = document.querySelector('#patient-container')
const patientDetail = document.querySelector('#patient-details')
const patientURL = `http://localhost:8080/patients`
let allPatients = []

document.addEventListener('DOMContentLoaded', function () {
    fetchPatients();
    patientContainer.addEventListener('click', (e) => {
        //if click view
        if (e.target.dataset.action === 'view') {
            console.log('press view')
            // get info from the chosen patient
            const patientData = allPatients.find((patient) => {
                return patient.id == e.target.dataset.id
            })
            console.log(patientData.username)
            // set info to the modal
            patientDetail.innerHTML = ''
            patientDetail.innerHTML +=
                `
                <table class="table">
                    <h4>${patientData.username}</h4>
                    <tr><td>Name: </td><td>${patientData.fname} ${patientData.lname}</td></tr>
                    <tr><td>Gender: </td><td>${patientData.gender}</td></tr>
                    <tr><td>Date of Birth: </td><td>${patientData.dob}</td></tr>
                    <tr><td>Address: </td><td>${patientData.address}</td></tr>
                    <tr><td>Email: </td><td>${patientData.email}</td></tr>
                    <tr><td>Phone: </td><td>${patientData.phone}</td></tr>
                    <tr><td>Allergies: </td><td>${patientData.allergies}</td></tr>
                    <tr><td>Blood Type: </td><td>${patientData.bloodType}</td></tr>
                    <tr><td>Health Status: </td><td>${patientData.healthStatus}</td></tr>
                    <tr><td>Medical History: </td><td>${patientData.medicalHistory}</td></tr>
                </table>
                `

        }
    })
})

//fetch Patients
function fetchPatients() {
    patientContainer.innerHTML = ''
    fetch(`${patientURL}`)
        .then(response => response.json())
        .then(function (doc) {
            //sort by doctor id small to large
            let patient = doc.filter(d => !(d.id == null)).sort((a, b) => parseFloat(a.id) - parseFloat(b.id));
            for (var i = 0; i < patient.length; i++) {
                allPatients = patient
                var listItem = document.createElement('tr');
                var view = `<button  class="btn btn-outline-primary" data-id="${patient[i].id}" id="view-${patient[i].id}" data-action="view" data-toggle="modal" data-target="#myModal">Details</button>`
                listItem.innerHTML +=
                    `
                    <td>${patient[i].username}</td>
                    <td>${patient[i].fname} ${patient[i].lname}</td>
                    <td>${patient[i].email}</td>
                    <td>${patient[i].phone}</td>
                    <td>${view}</td>
                    `

                patientContainer.appendChild(listItem);
            }
        })
}
