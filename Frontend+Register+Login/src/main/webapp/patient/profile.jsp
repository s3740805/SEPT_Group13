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
<div class="container">
    <div id="id_profile"></div>
    <div id="profile"></div>
    <div id='edit-profile'>
        <form id="profile-form">
            <div class="input-group mb-3">
                <input id="edit-fname" class="form-control" placeholder="First name">
                <input id="edit-lname" class="form-control" placeholder="Last name">
                <input type="email" name="email" id="edit-email" class="form-control" placeholder="Email">
                <div class="input-group-prepend">
                    <input class="btn btn-outline-primary" onclick="editProfile()" type="submit" value="Edit Profile">
                </div>
            </div>
        </form>
    </div>

</div>
</body>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            let state = sessionStorage.getItem("state");
            getPatient(state)
        })
        function getPatient(username) {
            let profile = document.getElementById('profile')
            let id = document.getElementById('id_profile')
            profile.innerHTML = ''
            id.innerHTML = ''
            fetch(`http://localhost:8080/patients/`+username)
                .then(response => response.json())
                .then(function (doc) {
                    id.value = doc.id;
                    profile.innerHTML += '<div>' + doc.username + '</div>';
                    profile.innerHTML += '<div>' + doc.fname + '</div>';
                    profile.innerHTML += '<div>' + doc.lname + '</div>';
                    profile.innerHTML += '<div>' + doc.email + '</div>';

                })
        }
        function editProfile() {
            let state2 = sessionStorage.getItem("state");
            let editfname = document.getElementById('edit-fname').value;
            let editlname = document.getElementById('edit-lname').value;
            let editemail = document.getElementById('edit-email').value;
            let id = document.getElementById('id_profile')
            fetch(`http://localhost:8080/patients/`+state2, {
                method: 'PUT',
                body: JSON.stringify({
                    id : parseInt(id.value),
                    name: null,
                    password: null,
                    fname: editfname,
                    lname: editlname,
                    dob: null,
                    gender: null,
                    address: null,
                    email: editemail,
                    phone: null,
                    allergies: null,
                    bloodType: null,
                    healthStatus: null,
                    medicalHistory: null
                }),
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
        }
    </script>


</html>
