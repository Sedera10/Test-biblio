<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des prêts | BIBLIO-TECHNO</title>
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
            <span class="ms-auto nav-link">Administrateur</span>
        </nav>

        <main class="content">
            <div class="container-fluid glass-container">
                <h2 class="mb-4">Recherche des prêts</h2>
                <form method="get" action="${pageContext.request.contextPath}/pret/liste" class="row g-3 mb-4">
                    <div class="col-md-3">
                        <label class="form-label">Adhérent :</label>
                        <select name="idAdherent" class="form-select">
                            <option value="">-- Tous --</option>
                            <c:forEach items="${adherents}" var="a">
                                <option value="${a.id}" ${param.idAdherent == a.id ? 'selected' : ''}>${a.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Date début après :</label>
                        <input type="date" name="dateDebut" value="${param.dateDebut}" class="form-control" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Date retour avant :</label>
                        <input type="date" name="dateFin" value="${param.dateFin}" class="form-control" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">État :</label>
                        <select name="etat" class="form-select">
                            <option value="">-- Tous --</option>
                            <option value="non_rendu" ${param.etat == 'non_rendu' ? 'selected' : ''}>Non rendus</option>
                            <option value="rendu" ${param.etat == 'rendu' ? 'selected' : ''}>Rendus</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-funnel"></i> Filtrer</button>
                    </div>
                </form>

                <h2 class="mb-3">Liste des prêts</h2>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
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
                        </thead>
                        <tbody>
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
                                            <c:when test="${p.rendu}"><span class="badge bg-success">✔ Rendu</span></c:when>
                                            <c:otherwise><span class="badge bg-danger">❌ Non rendu</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <c:if test="${not empty sessionScope.admin}">
                                        <td>
                                            <c:if test="${!p.rendu}">
                                                <form method="get" action="${pageContext.request.contextPath}/prolongement/form" class="d-inline">
                                                    <input type="hidden" name="idAdherent" value="${p.adherent.id}" />
                                                    <input type="hidden" name="idPret" value="${p.id}" />
                                                    <button type="submit" class="btn btn-sm btn-outline-primary">Prolonger</button>
                                                </form>
                                                <form method="post" action="${pageContext.request.contextPath}/pret/rendre" class="d-inline">
                                                    <input type="hidden" name="idPret" value="${p.id}" />
                                                    <!-- Bouton qui affiche le formulaire de rendu -->
                                                    <button type="button" class="btn btn-sm btn-outline-primary" onclick="afficherFormulaireRendu('${p.id}')">
                                                        Rendre
                                                    </button>

                                                    <!-- Formulaire caché pour choisir la date de rendu -->
                                                    <div id="form-rendu-${p.id}" style="display:none;" class="mt-2">
                                                        <form method="post" action="${pageContext.request.contextPath}/pret/rendre">
                                                            <input type="hidden" name="idPret" value="${p.id}" />
                                                            <label for="dateRendu-${p.id}">Date de rendu :</label>
                                                            <input type="date" name="dateRendu" id="dateRendu-${p.id}" class="form-control mb-2" required />
                                                            <button type="submit" class="btn btn-sm btn-success">OK</button>
                                                            <button type="button" class="btn btn-sm btn-secondary" onclick="cacherFormulaireRendu('${p.id}')">Annuler</button>
                                                        </form>
                                                    </div>
                                                </form>
                                            </c:if>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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

    function afficherFormulaireRendu(id) {
        document.getElementById('form-rendu-' + id).style.display = 'block';
    }

    function cacherFormulaireRendu(id) {
        document.getElementById('form-rendu-' + id).style.display = 'none';
    }
</script>
</body>
</html>