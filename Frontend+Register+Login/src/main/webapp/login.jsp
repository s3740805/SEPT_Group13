<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="utf-8">
      <title>Log in with your account</title>
      <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
      <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
  </head>

  <body>

    <div class="container">
        <div>
            <div style="text-align: center">
                <img src="https://image.flaticon.com/icons/svg/2957/2957872.svg" alt="logo" style="width:60px;"><h1>Doctor Appointment Booking System</h1>
            </div>
            <br>
            <form method="POST" action="${contextPath}/login" class="form-signin" style="background-color:white; border-radius: 5px">
                <h2 class="form-heading">Login</h2>
                <div style="font-size: 18px">Welcome! Please login to continue.</div>

                <div class="form-group ${error != null ? 'has-error' : ''}">
                    <span style="color: #2e6da4">${message}</span>
                    <input name="username" type="text" class="form-control" placeholder="Username"
                           autofocus="true"/>
                    <input name="password" type="password" class="form-control" placeholder="Password"/>
                    <span>${error}</span>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <button class="btn btn-lg btn-primary btn-block" type="submit">Log In</button>
                    <h5 class="text-center">New user? <a href="${contextPath}/registration">Register here.</a></h5>
                </div>
            </form>
        </div>

    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
  </body>
</html>
