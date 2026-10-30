<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>JSTL Demo</title>
</head>
<body>
    <h2>JSTL Demonstration</h2>
    <form method="post">
        Enter Name: <input type="text" name="name" required><br><br>
        Enter Age: <input type="number" name="age" required><br><br>
        <input type="submit" value="Submit">
    </form>
    <br>
    <c:if test="${not empty param.name}">
        Name: <c:out value="${param.name}"/><br><br>
        Age: <c:out value="${param.age}"/><br><br>
        <c:if test="${param.age >= 18}">
            You are eligible to vote.
        </c:if>
        <c:if test="${param.age < 18}">
            You are not eligible to vote.
        </c:if>
    </c:if>
</body>
</html>
