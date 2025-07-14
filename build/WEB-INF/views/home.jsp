<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | BIBLIO-TECHNO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app2.css" rel="stylesheet">
    <style>
        /* Style spécifique à la page dashboard */
        .content {
            padding: 2rem;
            min-height: calc(100vh - 60px);
            background-image: url('/Biblio/resources/img/fond3.jpg');
            background-size: cover;         
            background-repeat: no-repeat;  
            background-position: center;
            background-attachment: fixed;
        }
        
        .summary-card {
            border-left: 4px solid var(--teal);
            transition: transform 0.2s ease;
        }
        
        .summary-card:hover {
            transform: translateY(-4px);
        }
        
        .summary-card .bi {
            font-size: 1.5rem;
            color: var(--teal);
        }
        
        .card {
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .card-header {
            background-color: var(--dark-blue);
            color: var(--pure-white);
            border-bottom: none;
            font-weight: 600;
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
                <!-- Summary Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card summary-card h-100">
                            <div class="card-body glass-background">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-muted"><i class="bi bi-book me-2"></i> Livres</h5>
                                        <p class="card-text fs-4 fw-bold">${totalLivres}</p>
                                    </div>
                                    <div class="bg-light p-3 rounded">
                                        <i class="bi bi-book text-teal"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card summary-card h-100">
                            <div class="card-body glass-background">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-muted"><i class="bi bi-book me-2"></i> Prêts</h5>
                                        <p class="card-text fs-4 fw-bold">${totalPrets}</p>
                                    </div>
                                    <div class="bg-light p-3 rounded">
                                        <i class="bi bi-book text-teal"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card summary-card h-100">
                            <div class="card-body glass-background">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-muted"><i class="bi bi-book me-2"></i> Reservations</h5>
                                        <p class="card-text fs-4 fw-bold">${reservationsActives}</p>
                                    </div>
                                    <div class="bg-light p-3 rounded">
                                        <i class="bi bi-book text-teal"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card summary-card h-100">
                            <div class="card-body glass-background">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-muted"><i class="bi bi-book me-2"></i> Abonnés</h5>
                                        <p class="card-text fs-4 fw-bold">${totalAdherents}</p>
                                    </div>
                                    <div class="bg-light p-3 rounded">
                                        <i class="bi bi-book text-teal"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Autres cartes de résumé... -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>

                    <c:if test="${not empty erreur}">
                        <div class="alert alert-danger">${erreur}</div>
                    </c:if>
                </div>

                <!-- Tableau des réservations -->
                <div class="card shadow-sm">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-list-check me-2"></i> Réservations en cours</h5>
                    </div>
                    <div class="card-body glass-background">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Adhérent</th>
                                        <th>Livre</th>
                                        <th>Date réservation</th>
                                        <th>Type prêt</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${reservations}">
                                        <tr>
                                            <td>${r.adherent.nom}</td>
                                            <td>${r.livre.titre}</td>
                                            <td>${r.dateReservation}</td>
                                            <td>${r.typePret.type}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.dateFinReservation == null}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Terminée</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${!r.valide}">
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/reservations/valider" style="display:inline;">
                                                        <input type="hidden" name="id" value="${r.id}" />
                                                        <button class="btn btn-success btn-sm"><i class="bi bi-check-circle"></i> Approuver</button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/reservations/annuler" style="display:inline;">
                                                        <input type="hidden" name="id" value="${r.id}" />
                                                        <button class="btn btn-danger btn-sm"><i class="bi bi-x-circle"></i> Annuler</button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${r.valide}">
                                                    <span class="text-success">Validée</span>
                                                </c:if>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
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