<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prêter | BIBLIO-TECHNO</title>
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
            max-width: 600px;
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
            <span class="ms-auto nav-link">Administrateur</span>
        </nav>

        <main class="content">
            <div class="glass-form">
                <h2 class="mb-4">Formulaire de Prêt</h2>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/pret/valider" method="post">
                    <div class="mb-3">
                        <label class="form-label">Adhérent</label>
                        <select name="idAdherent" class="form-select" required>
                            <c:forEach items="${adherents}" var="a">
                                <option value="${a.id}">${a.nom}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Exemplaire</label>
                        <select name="idLivre" class="form-select" required>
                            <c:forEach items="${livres}" var="e">
                                <option value="${e.id}">Livre : ${e.titre} (id:${e.id})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label d-block">Type de prêt</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="typePret" value="surplace" id="local" checked>
                            <label class="form-check-label" for="local">Local</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="typePret" value="domicile" id="domicile">
                            <label class="form-check-label" for="domicile">À domicile</label>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date pret :</label>
                        <input type="date" class="form-control" name="datePret"/>
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Valider le prêt
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