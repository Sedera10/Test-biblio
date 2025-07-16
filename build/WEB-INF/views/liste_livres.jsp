<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Livres | BIBLIO-TECHNO</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app2.css" rel="stylesheet">
    <style>
        .content {
            padding: 2rem;
            min-height: calc(100vh - 60px);
            background-image: url('${pageContext.request.contextPath}/resources/img/fond3.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }
        
        .glass-box {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(6px);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .livre-title {
            background-color: var(--dark-blue);
            color: var(--pure-white);
            padding: 1rem;
            border-radius: 0.5rem 0.5rem 0 0;
        }
        
        .table thead th {
            background-color: var(--teal);
            color: var(--pure-white);
        }
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <div class="main">
        <nav class="navbar navbar-expand navbar-light shadow-sm">
            <a class="sidebar-toggle js-sidebar-toggle"><i class="bi bi-list fs-4"></i></a>
            <span class="ms-auto nav-link">Bienvenue sur <strong>Biblio-Techno</strong></span>
        </nav>

        <main class="content">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Liste des Livres et Exemplaires</h2>
                    <a href="${pageContext.request.contextPath}/livres/ajouter" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> Ajouter un Livre
                    </a>
                </div>

                <c:forEach var="livre" items="${livres}">
                    <div class="glass-box">
                        <h4 class="livre-title">${livre.titre} — <small>${livre.auteur}</small></h4>
                        <p class="mb-3"><strong>ISBN :</strong> ${livre.isbn} | <strong>Limite d'âge :</strong> ${livre.limiteAge} ans | <strong>Prêt domicile :</strong> 
                            <c:choose>
                                <c:when test="${livre.pretDomicile}">Oui</c:when>
                                <c:otherwise>Non</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/api/livres/{a.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye"></i>
                                            </a>

                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID Exemplaire</th>
                                        <th>État</th>
                                        <th>Statut</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ex" items="${livre.exemplaires}">
                                        <tr>
                                            <td>${ex.id}</td>
                                            <td>${ex.etat}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ex.disponible}">
                                                        <span class="badge bg-success">Disponible</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Indisponible</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelector('.js-sidebar-toggle')?.addEventListener('click', () => {
        document.querySelector('.wrapper')?.classList.toggle('sidebar-collapsed');
    });
</script>
</body>
</html>