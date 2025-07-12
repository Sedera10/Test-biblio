<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>test</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion de pénalité | BIBLIO-TECHNO</title>

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
            <h1>Connexion Bibliothecaire</h1>
          </main>
      </div>
  </div>

  <!-- JavaScript -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</body>
</html>
