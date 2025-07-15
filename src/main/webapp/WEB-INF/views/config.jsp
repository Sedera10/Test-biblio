<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Config | BIBLIO-TECHNO</title>
    <meta charset="utf-8">
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
            <div class="container-fluid glass-container">
                <h2 class="mb-4">Configuration du système</h2>

                <!-- Règle de Report -->
                <div class="card mb-5">
                    <div class="card-header">
                        <strong>Règle de report en cas de jour férié ou week-end</strong>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/config/calendrier" method="post">
                            <div class="mb-3">
                                <label class="form-label">Si un prêt tombe sur un jour fermé, la date de retour est :</label>
                                <select class="form-select" name="choix" required>
                                    <option value="">---</option>
                                    <option value="apres" ${regleReport.choix == 'apres' ? "selected" : ""}>Reportée après</option>
                                    <option value="avant" ${regleReport.choix == 'avant' ? "selected" : ""}>Avancée avant</option>
                                </select>
                            </div>
                            <button class="btn btn-primary mt-3" type="submit">Mettre à jour</button>
                        </form>
                    </div>
                </div>

                <!-- Règles de prêt -->
                <div class="card">
                    <div class="card-header">
                        <strong>Règles de prêt (durée selon type)</strong>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
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
                                            <td>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/config/updateReglePret" class="d-flex gap-2">
                                                    <input type="hidden" name="id" value="${regle.id}" />
                                                    <input type="number" name="dureeJours" value="${regle.dureeJours}" class="form-control form-control-sm" style="width: 90px;" />
                                                    <button class="btn btn-sm btn-primary" type="submit">Modifier</button>
                                                </form>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                 <!-- Règles de réservation -->
                <div class="card mt-5">
                    <div class="card-header">
                        <strong>Règles de réservation (quota par type d’adhérent)</strong>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Type Adhérent</th>
                                    <th>Quota max</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="regle" items="${regleReservations}">
                                    <tr>
                                        <td>${regle.id}</td>
                                        <td>${regle.typeAdherent.nom}</td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/config/updateRegleReservation" class="d-flex gap-2">
                                                <input type="hidden" name="id" value="${regle.id}" />
                                                <input type="number" name="quotaMax" value="${regle.quotaMax}" class="form-control form-control-sm" style="width: 90px;" />
                                                <button type="submit" class="btn btn-sm btn-primary">Modifier</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Gestion des types d'adhérents -->
                <div class="card mt-5">
                    <div class="card-header">
                        <strong>Gestion des types d’adhérents</strong>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/config/typeAdherent" class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">Nom du type</label>
                                <input type="text" name="nom" class="form-control" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Quota de réservation</label>
                                <input type="number" name="quotaMax" class="form-control" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Jours de pénalité</label>
                                <input type="number" name="joursPenalite" class="form-control" required />
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">Ajouter/Mettre à jour</button>
                            </div>
                        </form>

                        <hr />

                        <h5 class="mt-4">Types enregistrés :</h5>
                        <ul class="list-group">
                            <c:forEach var="t" items="${typeAdherents}">
                               <li class="list-group-item">
                                <form method="post" action="${pageContext.request.contextPath}/admin/config/typeAdherent" class="row row-cols-lg-auto g-2 align-items-center">
                                    <div class="col">
                                        <input type="text" name="nom" class="form-control form-control-sm" value="${t.nom}" readonly />
                                    </div>
                                    <div class="col">
                                        <input type="number" name="quotaMax" class="form-control form-control-sm" value="${t.quotaMax}" />
                                    </div>
                                    <div class="col">
                                        <input type="number" name="joursPenalite" class="form-control form-control-sm" value="${t.joursPenalite}" />
                                    </div>
                                    <div class="col">
                                        <button class="btn btn-sm btn-primary" type="submit">Enregistrer</button>
                                    </div>
                                </form>
                            </li>

                            </c:forEach>
                        </ul>
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