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
        <title>Add book | BIBLIO-TECHNO</title>
    
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
                <h2>Ajouter un Nouveau Livre</h2>

                <c:if test="${not empty message}">
                    <p style="color:green">${message}</p>
                </c:if>
                <c:if test="${not empty message}">
                    <p style="color:red">${erreur}</p>
                </c:if>
            
                <form action="${pageContext.request.contextPath}/livres/ajouter" method="post" class="mt-4">
                    <div class="mb-3">
                        <label>Titre :</label>
                        <input type="text" name="titre" class="form-control" required />
                    </div>
            
                    <div class="mb-3">
                        <label>Auteur :</label>
                        <input type="text" name="auteur" class="form-control" />
                    </div>
            
                    <div class="mb-3">
                        <label>Éditeur :</label>
                        <input type="text" name="editeur" class="form-control" />
                    </div>
            
                    <div class="mb-3">
                        <label>ISBN :</label>
                        <input type="text" name="isbn" class="form-control" required />
                    </div>
            
                    <div class="mb-3">
                        <label>Limite d’âge (optionnel) :</label>
                        <input type="number" name="limiteAge" class="form-control" min="0" />
                    </div>
            
                    <div class="mb-3">
                        <label>Autoriser prêt à domicile :</label><br/>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="pretDomicile" id="pretOui" value="true" checked>
                            <label class="form-check-label" for="pretOui">Oui</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="pretDomicile" id="pretNon" value="false">
                            <label class="form-check-label" for="pretNon">Non</label>
                        </div>
                    </div>        
            
                    <div class="mb-3">
                        <label>Nombre d'exemplaires :</label>
                        <input type="number" name="nbExemplaires" class="form-control" min="1" required />
                    </div>
            
                    <button type="submit" class="btn btn-success">Ajouter le livre</button>
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
