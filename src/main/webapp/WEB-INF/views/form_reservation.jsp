<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>test</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Reserver | BIBLIO-TECHNO</title>
    
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">

        <script>
            function toggleDates() {
                const typePret = document.querySelector('input[name="typePret"]:checked');
                const dateFinDiv = document.getElementById("dateFinDiv");
    
                if (typePret && typePret.value === "domicile") {
                    dateFinDiv.style.display = "block";
                } else {
                    dateFinDiv.style.display = "none";
                }
            }
    
            window.onload = toggleDates;
        </script>
    </head>
    <body>
        <div class="wrapper">
          <!-- Sidebar -->
          <jsp:include page="/WEB-INF/views/navbar.jsp" />
    
          <div class="main">
              <!-- Navbar -->
              <nav class="navbar navbar-expand navbar-light navbar-bg">
                  <a class="sidebar-toggle js-sidebar-toggle">
                      <i class="hamburger align-self-center"></i>
                  </a>
    
                  <div class="navbar-collapse collapse">
                      <ul class="navbar-nav navbar-align">
                          <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                                  <span class="text-dark">Administrateur</span>
                              </a>
                          </li>
                      </ul>
                  </div>
              </nav>
    
              <main class="content">
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>

                <h2>Formulaire de reservation</h2>

                <form action="${pageContext.request.contextPath}/reservation/reserver" method="post">
                    <label>Adhérent :</label>
                    <select name="idAdherent" required>
                        <c:forEach items="${adherents}" var="a">
                            <option value="${a.id}">${a.nom}</option>
                        </c:forEach>
                    </select><br/>

                    <label>Livre :</label>
                    <select name="idLivre" required>
                        <c:forEach items="${livres}" var="e">
                            <option value="${e.id}">${e.titre} (id:${e.id})</option>
                        </c:forEach>
                    </select><br/>

                    <label>Type de prêt :</label><br/>
                    <c:forEach items="${typesPret}" var="t">
                        <input type="radio" name="typePret" value="${t.type}"
                            onclick="toggleDates()" 
                            ${t.type == 'surplace' ? 'checked' : ''}/> ${t.type}<br/>
                    </c:forEach>

                    <label>Date début :</label>
                    <input type="date" name="dateReservation" required/><br/>

                    <div id="dateFinDiv" style="display: none;">
                        <label>Date fin :</label>
                        <input type="date" name="dateFinReservation"/><br/>
                    </div>

                    <input type="submit" value="Valider la réservation"/>
                </form>
              </main>
          </div>
      </div>
    
      <!-- JavaScript -->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
      <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    </body>
</html>
