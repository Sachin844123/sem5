<html>
<body>
    <h2>Registration</h2>
    <form action="process.jsp" method="post">
        Name: <input type="text" name="name"><br><br>
        Username: <input type="text" name="username"><br><br>
        Password: <input type="password" name="password"><br><br>
        City: <input type="text" name="city"><br><br>
        Country: <input type="text" name="country"><br><br>
        <input type="hidden" name="action" value="register">
        <input type="submit" value="Register">
    </form>
    <br>
    <a href="login.jsp">Login</a>
</body>
</html>
