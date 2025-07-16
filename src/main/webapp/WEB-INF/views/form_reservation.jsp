<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Réserver | BIBLIO-TECHNO</title>
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
            max-width: 700px;
            margin: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        label {
            font-weight: 500;
            color: var(--dark-blue);
        }
    </style>
    <script>
        function toggleDates() {
            const typePret = document.querySelector('input[name="typePret"]:checked');
            const dateFinDiv = document.getElementById("dateFinDiv");

            if (typePret && typePret.value === "domicile") {
                dateFinDiv.style.display = "block";
            } else {
                dateFinDiv.style.display = "none";
            }
        }
        window.onload = toggleDates;
    </script>
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
            <div class="glass-form">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <h3 class="mb-4">Formulaire de réservation</h3>
                <form action="${pageContext.request.contextPath}/reservation/reserver" method="post">
                    <div class="mb-3">
                        <label class="form-label">Adhérent :</label>
                        <select class="form-select" name="idAdherent" required>
                            <c:forEach items="${adherents}" var="a">
                                <option value="${a.id}">${a.nom}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Livre :</label>
                        <select class="form-select" name="idLivre" required>
                            <c:forEach items="${livres}" var="e">
                                <option value="${e.id}">${e.titre}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Type de prêt :</label><br/>
                        <c:forEach items="${typesPret}" var="t">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="typePret" value="${t.type}"
                                       onclick="toggleDates()" ${t.type == 'surplace' ? 'checked' : ''} />
                                <label class="form-check-label">${t.type}</label>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Date début :</label>
                        <input type="date" class="form-control" name="dateReservation" required />
                    </div>

                    <div class="mb-3" id="dateFinDiv" style="display: none;">
                        <label class="form-label">Date fin :</label>
                        <input type="date" class="form-control" name="dateFinReservation" />
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Valider la réservation
                        </button>
                    </div>
                </form>
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