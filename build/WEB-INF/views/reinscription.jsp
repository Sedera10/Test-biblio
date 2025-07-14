<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Réinscription | BIBLIO-TECHNO</title>
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
        
        .glass-form {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(6px);
            border-radius: 0.5rem;
            padding: 2rem;
            max-width: 650px;
            margin: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        label {
            font-weight: 500;
            color: var(--dark-blue);
        }
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/navbar.jsp" />

    <div class="main">
        <nav class="navbar navbar-expand navbar-light shadow-sm">
            <a class="sidebar-toggle js-sidebar-toggle"><i class="bi bi-list fs-4"></i></a>
            <span class="ms-auto nav-link">Bienvenue <strong>Adhérent</strong></span>
        </nav>

        <main class="content">
            <div class="glass-form">
                <h3 class="mb-4">Réinscription</h3>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <!-- Cas 1 : sessionAdherent (réinscription simple depuis compte) -->
                <c:if test="${not empty sessionScope.adherent}">
                    <form action="${pageContext.request.contextPath}/adherent/reinscription" method="post">
                        <input type="hidden" name="id" value="${sessionScope.adherent.id}" />

                        <div class="mb-3">
                            <label class="form-label">Nom :</label>
                            <p>${sessionScope.adherent.nom}</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type :</label>
                            <p>${sessionScope.adherent.typeAdherent.nom}</p>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle"></i> Valider la réinscription
                            </button>
                        </div>
                    </form>
                </c:if>

                <!-- Cas 2 : pas connecté (formulaire d'inscription complet) -->
                <c:if test="${empty sessionScope.adherent}">
                    <form action="${pageContext.request.contextPath}/adherent/reinscription" method="post">
                        <div class="mb-3">
                            <label for="adherent" class="form-label">Adherent :</label>
                            <select class="form-select" name="id" id="adherent" required>
                                <option value="">Nom de l'adherent</option>
                                <c:forEach items="${adherents}" var="ad">
                                    <option value="${ad.id}">${ad.nom}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-person-plus"></i> Valider la réinscription
                            </button>
                        </div>
                    </form>
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