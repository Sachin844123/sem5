<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Expression Language</title>
    </head>

    <body>

        <h1>Expression Language Example</h1>

        <h3>Arithmetic Operations</h3>

        Addition: ${10 + 20}
        <br>

        Subtraction: ${20 - 10}
        <br>

        Multiplication: ${10 * 5}
        <br>

        Division: ${20 / 5}
        <br><br>


        <h3>Relational Operations</h3>

        10 is greater than 5:
        ${10 > 5}
        <br>

        10 is equal to 10:
        ${10 == 10}
        <br><br>


        <h3>Logical Operations</h3>

        Both conditions are true:
        ${10 > 5 && 20 > 10}
        <br>

        At least one condition is true:
        ${10 > 20 || 20 > 10}
        <br><br>


        <h3>String Values</h3>

        Name:
        ${"Vashishta"}
        <br>

        College:
        ${"ABC College"}
        <br><br>


        <h3>EL with Request Parameters</h3>

        <form method="post">

            Enter Name:
            <input type="text" name="name">

            <br><br>

            Enter Age:
            <input type="text" name="age">

            <br><br>

            <input type="submit" value="Submit">

        </form>

        <br>

        Name:
        ${param.name}

        <br>

        Age:
        ${param.age}

    </body>
</html>