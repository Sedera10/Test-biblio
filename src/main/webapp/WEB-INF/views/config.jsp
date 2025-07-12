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
        <title>Config | BIBLIO-TECHNO</title>
    
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
                <div class="container mt-4">
                    <h2>Configuration du système</h2>
                
                    <!-- ==== Règle de Report Jour Férié / Fermé ==== -->
                    <div class="card mt-4">
                        <div class="card-header bg-warning">
                            <strong>Règle de report en cas de jour férié ou week-end</strong>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/config/calendrier" method="post">
                                <div class="form-group">
                                    <label for="choix">Si un prêt tombe sur un jour fermé, la date de retour est :</label>
                                    <select class="form-control" name="choix" id="choix">
                                        <option value="apres" ${regleReport.choix == 'apres' ? "selected" : ""}>Reportée après</option>
                                        <option value="avant" ${regleReport.choix == 'avant' ? "selected" : ""}>Avancée avant</option>
                                    </select>
                                </div>
                                <button class="btn btn-primary mt-2" type="submit">Mettre à jour</button>
                            </form>
                        </div>
                    </div>
                
                    <!-- ==== Règles de prêt === -->
                    <div class="card mt-5">
                        <div class="card-header bg-info text-white">
                            <strong>Règles de prêt (durée selon type)</strong>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Type Adhérent</th>
                                        <th>Type Prêt</th>
                                        <th>Durée (jours)</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="regle" items="${reglePrets}">
                                        <tr>
                                            <td>${regle.id}</td>
                                            <td>${regle.typeAdherent}</td>
                                            <td>${regle.typePret}</td>
                                            <td>${regle.dureeJours}</td>
                                            <td>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/config/updateReglePret" style="display:inline-flex;">
                                                    <input type="hidden" name="id" value="${regle.id}" />
                                                    <input type="number" name="dureeJours" value="${regle.dureeJours}" class="form-control form-control-sm" style="width: 100px; margin-right: 5px;" />
                                                    <button class="btn btn-sm btn-success" type="submit">Modifier</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
              </main>
          </div>
      </div>
    
      <!-- JavaScript -->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
      <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    </body>
</html>
