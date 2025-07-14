<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - Biblio-Techno</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap et style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>
<body>
<div class="login-container" style="height: 590px;">
    <h2>Inscription</h2>

    <c:if test="${not empty erreur}">
        <div class="alert alert-danger">${erreur}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/adherent/inscription">
        <input type="hidden" name="role" id="roleInput" value="adherent">

        <div class="mb-3">
            <label for="nom" class="form-label">Nom</label>
            <input type="text" class="form-control" name="nom" id="nom" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Adresse email</label>
            <input type="email" class="form-control" name="email" id="email" required>
        </div>

        <div class="mb-3">
            <label for="motDePasse" class="form-label">Mot de passe</label>
            <input type="password" class="form-control" name="motDePasse" id="motDePasse" required>
        </div>

        <c:if test="${not empty typesAdherent}">
            <div id="typeAdherentBloc" class="mb-3">
                <label class="form-label">Profil (Adhérent) :</label><br/>
                <c:forEach items="${typesAdherent}" var="t">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="typeAdherent" value="${t.nom}" required>
                        <label class="form-check-label">${t.nom}</label>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <button type="submit" class="btn btn-primary w-100">S'inscrire</button>

        <div class="links mt-3">
            <a href="${pageContext.request.contextPath}/login">Déjà inscrit ? Se connecter</a>
        </div>
    </form>
</div>
</body>
</html>
