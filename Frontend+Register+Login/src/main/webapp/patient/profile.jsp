<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
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
    <title>Profile</title>
</head>
<body>
<jsp:include page="../_navigation.jsp"></jsp:include>
<%--Patient Profile Table--%>
<div class="container">
    <div id="id_profile"></div>
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 toppad" >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title" id="patientUserName"></h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class=" col-md-6 col-lg-6 ">
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td>First Name:</td>
                                    <td id="FirstName"><td/>
                                </tr>
                                <tr>
                                    <td>Last Name:</td>
                                    <td id="LastName"></td>
                                </tr>
                                <tr>
                                    <td>Date of Birth:</td>
                                    <td id="DOB"></td>
                                </tr>

                                <tr>
                                <tr>
                                    <td>Gender:</td>
                                    <td id="Gender"></td>
                                </tr>
                                <tr>
                                    <td>Home Address:</td>
                                    <td id="Address"></td>
                                </tr>
                                <tr>
                                    <td>Email:</td>
                                    <td id="Email"><a href="mailto:info@support.com"></a></td>
                                </tr>
                                <td>Phone Number:</td>
                                <td id="Phone"></td>

                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <div class=" col-md-4 col-lg-4 ">
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td>Blood Type:</td>
                                    <td id="bloodType"></td>
                                </tr>
                                <tr>
                                    <td>Allergies:</td>
                                    <td id="allergies"></td>
                                </tr>
                                <tr>
                                    <td>Medical History:</td>
                                    <td id="medicalHistory"></td>
                                </tr>

                                <tr>
                                <tr>
                                    <td>Health Status:</td>
                                    <td id="healthStatus"></td>
                                </tr>
                                </tbody>
                            </table>
                            <div id="save"></div>
                        </div>

                        <span class="pull-right">
                        <a id="editButton" data-original-title="Edit this user" data-toggle="tooltip" type="button" class="btn btn-sm btn-warning" onclick="patientEdit();changeVisibility()"><i class="glyphicon glyphicon-edit"></i>Edit</a>
                        <a id ="back"></a>
                    </span>
                    </div>


                </div>

            </div>
        </div>
    </div>
</div>
</div>
</body>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        let state = sessionStorage.getItem("state");
        getPatient(state);
    })
    // Show Patient Profile
    function getPatient(username) {
        let FirstName = document.getElementById('FirstName')
        let LastName = document.getElementById('LastName')
        let DOB = document.getElementById('DOB')
        let Gender = document.getElementById('Gender')
        let Address = document.getElementById('Address')
        let Email = document.getElementById('Email')
        let Phone = document.getElementById('Phone')
        let allergies =document.getElementById('allergies')
        let bloodType =document.getElementById('bloodType')
        let healthStatus=document.getElementById('healthStatus')
        let medicalHistory=document.getElementById('medicalHistory')
        fetch(`http://localhost:8080/patients/`+username)
            .then(response => response.json())
            .then(function (doc) {
                FirstName.innerHTML += '<div>' +  doc.fname + '</div>';
                LastName.innerHTML += '<div>' +  doc.lname + '</div>';
                DOB.innerHTML ='<div>' + doc.dob+'</div>';
                Gender.innerHTML += '<div>' +  doc.gender + '</div>';
                Address.innerHTML += '<div>' +  doc.address + '</div>';
                Email.innerHTML += '<div>' +  doc.email + '</div>';
                Phone.innerHTML += '<div>' +  doc.phone + '</div>';
                allergies.innerHTML+= '<div>' +  doc.allergies + '</div>';
                bloodType.innerHTML+= '<div>' +  doc.bloodType + '</div>';
                healthStatus.innerHTML+= '<div>' +  doc.healthStatus + '</div>';
                medicalHistory.innerHTML+= '<div>' +  doc.medicalHistory + '</div>';



            })
    }
// Edit Patient Profile
    function patientEdit() {
        let state1 = sessionStorage.getItem("state");
        document.getElementById("FirstName").innerHTML = `<form action="process-action.html" ><input type="text" id="edit_fname" required></form>`
        document.getElementById("LastName").innerHTML = `<input type="text" id="edit_lname">`
        document.getElementById("DOB").innerHTML = `<input type="date" name="datemax" max = "2020-08-24" id="edit_dob">`
        document.getElementById("Gender").innerHTML =
            `<select id="edit_gender">
                  <option value="Male">Male</option>
                  <option value="Female">Female</option>
                  <option value="Other">Other</option>
              </select>`
        document.getElementById("Address").innerHTML= `<input type="text" id="edit_address">`
        document.getElementById("Email").innerHTML= `<input type="email" name="email" id="edit_email">`
        document.getElementById("Phone").innerHTML= `<input maxlength="11"  id="edit_phone">`
        document.getElementById("bloodType").innerHTML=`
              <select id="edit_bloodType">
                  <option value="A">A</option>
                  <option value="B">B</option>
                  <option value="O">O</option>
                  <option value="AB">AB</option>
                  <option value="Don't know">Don't know</option>
              </select>`
        document.getElementById("allergies").innerHTML= `<input type="text" id="edit_allergies">`
        document.getElementById("healthStatus").innerHTML= `<input type="text" id="edit_healthStatus">`
        document.getElementById("medicalHistory").innerHTML= `<input type="text" id="edit_medicalHistory">`
        document.getElementById("save").innerHTML+= `<button type="submit" class="btn btn-success" onclick="validateForm()">Save</button>`
        document.getElementById("back").innerHTML+=`<a data-toggle="tooltip" type="button" class="btn btn-sm btn-danger" href="profile.jsp"><i class="glyphicon glyphicon-remove"></i>Back</a>`

        fetch(`http://localhost:8080/patients/`+state1)
            .then(response => response.json())
            .then(function (doc) {
                document.getElementById("edit_fname").value = doc.fname;
                document.getElementById("edit_lname").value = doc.lname;
                document.getElementById("edit_dob").value = doc.dob;
                document.getElementById("edit_email").value= doc.email;
                document.getElementById("edit_gender").value = doc.gender;
                document.getElementById("edit_address").value = doc.address;
                document.getElementById("edit_phone").value = doc.phone;
                document.getElementById("edit_bloodType").value = doc.bloodType;
                document.getElementById("edit_allergies").value= doc.allergies;
                document.getElementById("edit_healthStatus").value= doc.healthStatus;
                document.getElementById("edit_medicalHistory").value= doc.medicalHistory;

            })

    }

// Save Patient Profile
    function editProfile() {
        let state2 = sessionStorage.getItem("state");
        let editFirstName = document.getElementById('edit_fname').value
        let editLastName = document.getElementById('edit_lname').value
        let editDOB = document.getElementById('edit_dob').value
        let editGender = document.getElementById('edit_gender').value
        let editAddress = document.getElementById('edit_address').value
        let editEmail = document.getElementById('edit_email').value
        let editPhone = document.getElementById('edit_phone').value
        let editBloodType = document.getElementById('edit_bloodType').value
        let editAllergies = document.getElementById('edit_allergies').value
        let editHealthStatus = document.getElementById('edit_healthStatus').value
        let editMedicalHistory = document.getElementById('edit_medicalHistory').value


        let id = document.getElementById('id_profile')
        if (confirm("Are you sure want to change your information")){
            fetch(`http://localhost:8080/patients/`+state2, {
                method: 'PUT',
                body: JSON.stringify({
                    id : parseInt(id.value),
                    name: null,
                    password: null,
                    fname: editFirstName,
                    lname: editLastName,
                    address:editAddress,
                    dob:editDOB,
                    gender: editGender,
                    bloodType:editBloodType,
                    phone:editPhone,
                    email:editEmail,
                    allergies:editAllergies,
                    healthStatus:editHealthStatus,
                    medicalHistory:editMedicalHistory
                }),
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            }).then(res => getPatient(username))
            location.reload()
        }
    }
    function changeVisibility() {
        document.getElementById("editButton").style.visibility = "hidden";
    }

    // Validation input
    function validateForm()  {
        var letters = /^[A-Za-z]+$/; // This value for checking the letter
        var fn = document.getElementById("edit_fname").value;
        var ln = document.getElementById("edit_lname").value;
        var ad = document.getElementById("edit_address").value;
        var el=document.getElementById('edit_email').value;
        var character = el.indexOf("@");
        var dot = el.lastIndexOf(".");
        var pe = document.getElementById('edit_phone').value;
        var testphone = isNaN(pe); // This is checking the number



        // Checking null value
        if(fn == "") {
            alert("Please enter your First Name");
            document.getElementById("edit_fname").style.borderColor = "red";// focus on wrong value
            return false;
        }
        if(fn.match(letters) ){
        }else {
            alert("Please input alphabet characters only")
            document.getElementById("edit_fname").style.borderColor = "red";// focus on wrong value
            return false;}
        // Checking null value
        if(ln == "") {
            alert("Please enter your Last Name");
            document.getElementById("edit_lname").style.borderColor = "red";// focus on wrong value
            return false;
        }
        if(ln.match(letters) ){
        }else {
            alert("Please input alphabet characters only")
            document.getElementById("edit_lname").style.borderColor = "red";// focus on wrong value
            return false;}
        // Checking null value
        if(ad == ""){
            alert("Please enter your Address");
            document.getElementById("edit_address").style.borderColor = "red";// focus on wrong value
            return false
        }
        // Checking null value
        if(el == ""){
            alert("Please enter your Email");
            document.getElementById("edit_email").style.borderColor = "red";// focus on wrong value
            return false;
        }
        if((character <1) || (dot<character+2) || (dot+2>el.length)) {
            alert("Wrong email");
            document.getElementById("edit_email").style.borderColor = "red";// focus on wrong value
            return false;
        }
        // Checking null value
        if (pe ==""){
            alert("Please enter your phone number");
            document.getElementById("edit_phone").style.borderColor = "red";// focus on wrong value
            return false;
        }
        if( testphone == true)  {
            alert("Please input number only!");
            document.getElementById("edit_phone").style.borderColor = "red";// focus on wrong value
            return false;
        }
        if (pe.length < 10){
            alert("Phone number must have 10 numbers")
            document.getElementById("edit_phone").style.borderColor = "red";// focus on wrong value
            return false;
        }



        editProfile();

        return true;
    }
</script>


</html>
