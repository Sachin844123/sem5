package com.guestbook.servlet;

import com.guestbook.entity.Guestbook;
import java.io.IOException;
import java.io.PrintWriter;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/guestbook")
public class GuestbookServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("GuestbookPU");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String message = request.getParameter("message");

        EntityManager em = emf.createEntityManager();

        try {

            Guestbook guest = new Guestbook(name, message);

            em.getTransaction().begin();

            em.persist(guest);

            em.getTransaction().commit();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<html>");
            out.println("<head><title>Guestbook</title></head>");
            out.println("<body>");

            out.println("<h2>Guestbook Entry Recorded Successfully!</h2>");

            out.println("<p><b>Name:</b> " + name + "</p>");
            out.println("<p><b>Message:</b> " + message + "</p>");

            out.println("<br>");
            out.println("<a href='index.jsp'>Back to Guestbook</a>");

            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {

            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            response.setContentType("text/html");

            PrintWriter out = response.getWriter();

            out.println("<h2>Guestbook Entry Failed</h2>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");

        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}