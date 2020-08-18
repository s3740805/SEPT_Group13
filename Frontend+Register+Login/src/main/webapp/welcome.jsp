<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Home</title>
    <%--<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">--%>
    <%--boostrap--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <style>
        body {
            padding-top: 3.5rem;
        }
    </style>

</head>

<body>
    <jsp:include page="_navigation.jsp"></jsp:include>
  <div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <h2>Welcome <span id="name" value="${pageContext.request.userPrincipal.name}">${pageContext.request.userPrincipal.name}</span> | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>
    </c:if>
  </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <script>
      sessionStorage.setItem("state", document.getElementById('name').getAttribute('value'))
      let state = sessionStorage.getItem("state");
      let havePatient = false;
      fetch('http://localhost:8080/patients')
          .then(res => res.json())
          .then(json => {
              for (let i = 0; i < json.length; i++) {
                  if (state === json[i].username || state === "admin") {
                      havePatient = true;
                      break;
                  }
              }
          }).then(() => {
          if (havePatient === false) {
              fetch('http://localhost:8080/patients', {
                  headers: {
                      'Accept': 'application/json',
                      'Content-Type': 'application/json'
                  },
                  method: "POST",
                  body: JSON.stringify({username: state})

              })
          }
      })
  </script>

  <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
