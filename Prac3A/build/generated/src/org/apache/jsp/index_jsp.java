package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\"\n");
      out.write("              content=\"text/html; charset=UTF-8\">\n");
      out.write("\n");
      out.write("        <title>JSP Implicit Objects</title>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <h1>JSP Implicit Objects</h1>\n");
      out.write("\n");
      out.write("        <h2>Request Object</h2>\n");
      out.write("\n");
      out.write("        Request Method:\n");
      out.write("        ");
      out.print( request.getMethod() );
      out.write("\n");
      out.write("        <br>\n");
      out.write("\n");
      out.write("        Request URI:\n");
      out.write("        ");
      out.print( request.getRequestURI() );
      out.write("\n");
      out.write("        <br>\n");
      out.write("\n");
      out.write("        Server Name:\n");
      out.write("        ");
      out.print( request.getServerName() );
      out.write("\n");
      out.write("        <br>\n");
      out.write("\n");
      out.write("        Server Port:\n");
      out.write("        ");
      out.print( request.getServerPort() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Response Object</h2>\n");
      out.write("\n");
      out.write("        Content Type:\n");
      out.write("        ");
      out.print( response.getContentType() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Out Object</h2>\n");
      out.write("\n");
      out.write("        ");

            out.println("This message is displayed using out object.");
        
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Session Object</h2>\n");
      out.write("\n");
      out.write("        Session ID:\n");
      out.write("        ");
      out.print( session.getId() );
      out.write("\n");
      out.write("        <br>\n");
      out.write("\n");
      out.write("        Is New Session:\n");
      out.write("        ");
      out.print( session.isNew() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Application Object</h2>\n");
      out.write("\n");
      out.write("        Context Path:\n");
      out.write("        ");
      out.print( application.getContextPath() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Config Object</h2>\n");
      out.write("\n");
      out.write("        Servlet Name:\n");
      out.write("        ");
      out.print( config.getServletName() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>PageContext Object</h2>\n");
      out.write("\n");
      out.write("        Page Class:\n");
      out.write("        ");
      out.print( pageContext.getPage().getClass().getName() );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <h2>Page Object</h2>\n");
      out.write("\n");
      out.write("        Page Class:\n");
      out.write("        ");
      out.print( page.getClass().getName() );
      out.write("\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
