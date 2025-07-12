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
        <title>Liste prêts | BIBLIO-TECHNO</title>
    
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
                <h2>Recherche des prêts</h2>
                <form method="get" action="${pageContext.request.contextPath}/pret/liste">
                    <label>Adhérent :</label>
                    <select name="idAdherent">
                        <option value="">-- Tous --</option>
                        <c:forEach items="${adherents}" var="a">
                            <option value="${a.id}" ${param.idAdherent == a.id ? 'selected' : ''}>${a.nom}</option>
                        </c:forEach>
                    </select>

                    <label>Date début après :</label>
                    <input type="date" name="dateDebut" value="${param.dateDebut}" />

                    <label>Date retour avant :</label>
                    <input type="date" name="dateFin" value="${param.dateFin}" />

                    <label>État :</label>
                    <select name="etat">
                        <option value="">-- Tous --</option>
                        <option value="non_rendu" ${param.etat == 'non_rendu' ? 'selected' : ''}>Non rendus</option>
                        <option value="rendu" ${param.etat == 'rendu' ? 'selected' : ''}>Rendus</option>
                    </select>

                    <input type="submit" value="Filtrer"/>
                </form>

                <h2>Liste des prêts</h2>
                <table border="1">
                    <tr>
                        <th>Adhérent</th>
                        <th>Livre</th>
                        <th>Exemplaire</th>
                        <th>Date début</th>
                        <th>Date retour</th>
                        <th>Type prêt</th>
                        <th>État</th>
                        <c:if test="${not empty sessionScope.admin}">
                            <th>Actions</th>
                        </c:if>
                    </tr>

                    <c:forEach items="${prets}" var="p">
                        <tr>
                            <td>${p.adherent.nom}</td>
                            <td>${p.exemplaire.livre.titre}</td>
                            <td>${p.exemplaire.id}</td>
                            <td>${p.dateDebut}</td>
                            <td>${p.dateRetour}</td>
                            <td>${p.typePret.type}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.rendu}">✔ Rendu</c:when>
                                    <c:otherwise>❌ Non rendu</c:otherwise>
                                </c:choose>
                            </td>

                            <c:if test="${not empty sessionScope.admin}">
                                <td>
                                    <c:if test="${!p.rendu}">
                                        <form method="get" action="${pageContext.request.contextPath}/prolongement/form" style="display:inline;">
                                            <input type="hidden" name="idAdherent" value="${p.adherent.id}" />
                                            <input type="hidden" name="idPret" value="${p.id}" />
                                            <button type="submit">Prolonger</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/pret/rendre" style="display:inline;">
                                            <input type="hidden" name="idPret" value="${p.id}" />
                                            <button type="submit">Rendre</button>
                                        </form>
                                    </c:if>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
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
