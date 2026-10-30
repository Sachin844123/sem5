<!DOCTYPE html>
<html>
<head>
    <title>Website Feedback</title>
</head>

<body>

<h2>Website Visitor Feedback</h2>

<form action="feedback" method="post">

    Name:
    <input type="text" name="name" required>

    <br><br>

    Email:
    <input type="email" name="email" required>

    <br><br>

    Feedback:
    <br>
    <textarea name="feedback" rows="5" cols="40" required></textarea>

    <br><br>

    <input type="submit" value="Submit Feedback">

</form>

</body>
</html>