<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Biblio-Techno</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet">

</head>
<body>
    <div class="login-container">
        <h2>Connexion</h2>

        <c:if test="${not empty erreur}">
            <div class="alert alert-danger">${erreur}</div>
        </c:if>

        <form action="login" method="post">
            <input type="hidden" name="role" id="roleInput" value="admin">

            <div class="mb-3">
                <label for="email" class="form-label">Adresse email</label>
                <input type="email" class="form-control" id="email" name="email" required placeholder="example@gmail.com">
            </div>

            <div class="mb-3">
                <label for="motDePasse" class="form-label">Mot de passe</label>
                <input type="password" class="form-control" id="motDePasse" name="motDePasse" required placeholder="Mot de passe">
            </div>

            <button type="submit" class="btn btn-primary w-100">Se connecter</button>

            <div class="links mt-3">
                <a href="#" id="toggleRole" class="toggle-role">En tant que client ?</a><br>
                <a href="${pageContext.request.contextPath}/signin">Créer un compte</a>
            </div>
        </form>
    </div>

    <script>
        const toggleLink = document.getElementById("toggleRole");
        const roleInput = document.getElementById("roleInput");

        toggleLink.addEventListener("click", function (e) {
            e.preventDefault();
            if (roleInput.value === "admin") {
                roleInput.value = "client";
                toggleLink.innerText = "En tant qu'admin ?";
            } else {
                roleInput.value = "admin";
                toggleLink.innerText = "En tant que client ?";
            }
        });
    </script>
</body>
</html>
