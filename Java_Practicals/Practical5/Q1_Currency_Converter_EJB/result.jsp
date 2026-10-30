<%@ page import="javax.naming.*" %>
<%@ page import="ejb.CurrencyConverter" %>
<html>
<body>
    <h2>Currency Conversion Result</h2>
    <%
        double amount = Double.parseDouble(request.getParameter("amount"));
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        InitialContext context = new InitialContext();
        CurrencyConverter converter = (CurrencyConverter) context.lookup(
                "java:global/Practical5a/CurrencyConverter");
        double result = converter.convert(amount, from, to);
    %>
    Amount: <%= amount %><br><br>
    From: <%= from %><br><br>
    To: <%= to %><br><br>
    Converted Amount: <%= result %>
</body>
</html>
