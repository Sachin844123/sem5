package com.guestbook.servlet;

import com.guestbook.model.Guestbook;
import com.guestbook.util.HibernateUtil;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet("/guestbook")
public class GuestbookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String message = request.getParameter("message");

        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Guestbook guest = new Guestbook(name, message);
            session.save(guest);
            transaction.commit();
            out.println("<h2>Guestbook Entry Successful</h2>");
            out.println("<p>Name: " + name + "</p>");
            out.println("<p>Message: " + message + "</p>");
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            out.println("<h2>Guestbook Entry Failed</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            session.close();
        }
    }
}
