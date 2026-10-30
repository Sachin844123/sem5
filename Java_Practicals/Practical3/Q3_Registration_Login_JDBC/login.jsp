<html>
<body>
    <h2>Login</h2>
    <form action="process.jsp" method="post">
        Username: <input type="text" name="username"><br><br>
        Password: <input type="password" name="password"><br><br>
        <input type="hidden" name="action" value="login">
        <input type="submit" value="Login">
    </form>
    <br>
    <a href="index.jsp">Register</a>
</body>
</html>
