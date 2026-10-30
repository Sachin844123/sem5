package com.feedback.servlet;

import com.feedback.model.Feedback;
import com.feedback.util.HibernateUtil;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String feedbackText = request.getParameter("feedback");

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        Transaction transaction = null;

        try {

            transaction = session.beginTransaction();

            Feedback feedback =
                    new Feedback(name, email, feedbackText);

            session.save(feedback);

            transaction.commit();

            out.println("<h2>Feedback Stored Successfully</h2>");
            out.println("<p>Name: " + name + "</p>");
            out.println("<p>Email: " + email + "</p>");
            out.println("<p>Feedback: " + feedbackText + "</p>");

        } catch (Exception e) {

            if (transaction != null) {
                transaction.rollback();
            }

            out.println("<h2>Feedback Storage Failed</h2>");
            out.println("<p>" + e.getMessage() + "</p>");

        } finally {

            session.close();
        }
    }
}