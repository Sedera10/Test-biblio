<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Adhérents | BIBLIO-TECHNO</title>
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
        
        .glass-container {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(6px);
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .card-header {
            background-color: var(--dark-blue);
            color: var(--pure-white);
        }
        
        .btn-outline-primary {
            color: var(--teal);
            border-color: var(--teal);
        }
        
        .btn-outline-primary:hover {
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
            <span class="ms-auto nav-link">Bienvenue <strong>Administrateur</strong></span>
        </nav>

        <main class="content">
            <div class="container-fluid glass-container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="mb-0">Liste des Adhérents</h3>
                    <a href="${pageContext.request.contextPath}/adherent/ajouter" class="btn btn-primary">
                        <i class="bi bi-person-plus-fill"></i> Ajouter un Adhérent
                    </a>
                </div>

                <c:if test="${empty adherents}">
                    <div class="alert alert-warning">Aucun adhérent trouvé.</div>
                </c:if>

                <c:if test="${not empty adherents}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nom</th>
                                    <th>Email</th>
                                    <th>Type</th>
                                    <th>Date inscription</th>
                                    <th>Pénalités (€)</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="a" items="${adherents}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${a.nom}</td>
                                        <td>${a.email}</td>
                                        <td>${a.typeAdherent.nom}</td>
                                        <td><fmt:formatDate value="${a.inscription}" pattern="dd/MM/yyyy"/></td>
                                        <td>${a.penalites}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/api/adherents/${a.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/adherent/modifier/${a.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/adherent/supprimer/${a.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Supprimer cet adhérent ?');">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
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