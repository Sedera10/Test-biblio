<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>

    <script>
        function changeRole() {
            const typePret = document.getElementsByClassName("links");
        }

        window.onload = toggleDates;
    </script>
</head>
<body>
    <h2>Inscription</h2>

    <c:if test="${not empty erreur}">
        <p style="color:red">${erreur}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p style="color:green">${message}</p>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/signin">
        <input type="hidden" name="role" value="adherent">

        <label>Nom :</label><br/>
        <input type="text" name="nom" required /><br/>

        <label>Email :</label><br/>
        <input type="email" name="email" required /><br/>

        <label>Mot de passe :</label><br/>
        <input type="password" name="motDePasse" required /><br/><br/>

        <c:if test="${not empty typesAdherent}">
            <label>Profil :</label><br/>
            <c:forEach items="${typesAdherent}" var="t">
                ${t.nom}
                <input type="radio" name="typeAdherent" value="${t.nom}">
            </c:forEach>
        </c:if>
        <div class="links" >
            <ul>
                <li><a href="">en tant qu'admin ?</a></li>
                <li><p>Déjà inscrit ? <a href="${pageContext.request.contextPath}/login">Se connecter</a></p></li>
            </ul>
        </div>
        
        <input type="submit" value="S'incrire"/> 
    </form>
</body>
</html>
