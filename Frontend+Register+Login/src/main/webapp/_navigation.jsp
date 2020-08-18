<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!--Navigation-->
<div id="navigation">
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-info">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
                <img src="https://image.flaticon.com/icons/svg/2957/2957872.svg" alt="logo" style="width:40px;">
            </a>

            <div class="collapse navbar-collapse" id="navbarsExampleDefault">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                            Admin
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="/admin/doctor">Doctor</a>
                            <a class="dropdown-item" href="#">Link 2</a>
                            <a class="dropdown-item" href="#">Link 3</a>
                        </div>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbardrop 2" data-toggle="dropdown">
                            Patient
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="/patient/booking">Book an appointment</a>
                            <a class="dropdown-item" href="/patient/profile">Profile</a>
                            <a class="dropdown-item" href="#">Link 3</a>
                        </div>
                    </li>


                </ul>
            </div>
            <div class="my-2 my-lg-0">
                <c:if test="${pageContext.request.userPrincipal.name != null}">
                    <form id="logoutForm" method="POST" action="${contextPath}/logout">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                    <span class="mr-sm-2">${pageContext.request.userPrincipal.name}</span>
                    <button class="btn btn-outline-dark my-2 my-sm-0" onclick="document.forms['logoutForm'].submit()">Logout</button>
                </c:if>
            </div>
        </div>
    </nav>
    <!--header image-->
    <div class="jumbotron"
         style="background-image: url(https://static.wixstatic.com/media/85baeb_d155e10f3b8d4aff829822a4b828a58a~mv2_d_2800_1273_s_2.jpg); background-size: cover; height: 300px">
        <div class="container">
            <h1>Doctor Appointment Booking System</h1>
        </div>
    </div>
</div>
<!--end of Navigation-->