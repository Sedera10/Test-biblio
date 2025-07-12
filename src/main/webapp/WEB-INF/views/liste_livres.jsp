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
        <title>Liste livres | BIBLIO-TECHNO</title>
    
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
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
                <h2>Liste des Livres</h2>
                <a href="${pageContext.request.contextPath}/livres/ajouter" class="btn btn-primary mb-3">Ajouter un Livre</a>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Titre</th>
                            <th>Auteur</th>
                            <th>ISBN</th>
                            <th>Prêt Domicile</th>
                            <th>Limite d’âge</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="livre" items="${livres}">
                            <tr>
                                <td>${livre.titre}</td>
                                <td>${livre.auteur}</td>
                                <td>${livre.isbn}</td>
                                <td><c:choose>
                                        <c:when test="${livre.pretDomicile}">Oui</c:when>
                                        <c:otherwise>Non</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${livre.limiteAge}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
              </main>
          </div>
      </div>
    
      <!-- JavaScript -->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
      <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    </body>
</html>
