Enterprise Java Practicals (Corrected Codes)
===========================================

All codes cleaned of syntax errors. Original logic kept.
Folder names clearly show: Practical Number + Question Number + Topic Name

===========================================
COMPLETE STRUCTURE + DATABASE INFO
===========================================

Practical1/
  Q1_User_Registration_JDBC/                ← Uses Database (userdb.users)
      index.html
      RegisterServlet.java
      db_setup.sql

  Q2_Simple_Login_Servlet/                  ← No Database (hardcoded admin/12345)
      index.html
      LoginServlet.java

Practical2/
  Q1_RequestDispatcher_Password_Validation/ ← No Database (hardcoded password = "servlet")
      index.html
      ValidateServlet.java
      WelcomeServlet.java

  Q2_Cookie_Visit_Counter/                  ← No Database
      index.html
      VisitCounter.java

  Q3_Session_Management/                    ← No Database
      index.html
      SessionDemo.java

Practical3/
  Q1_JSP_Implicit_Objects/                  ← No Database
      index.html
      implicitObjects.jsp

  Q2_Form_Display_Validation/               ← No Database
      index.jsp
      display.jsp

  Q3_Registration_Login_JDBC/               ← Uses Database (jspdb.register)
      index.jsp
      login.jsp
      process.jsp
      db_setup.sql

Practical4/
  Q1_Update_Registration_JDBC/              ← Uses Database (jspdb.registration)
      index.jsp
      update.jsp
      db_setup.sql

  Q2_Expression_Language_EL/                ← No Database
      el.jsp

  Q3_JSTL_Demo/                             ← No Database
      index.jsp

Practical5/
  Q1_Currency_Converter_EJB/                ← No Database
      index.html
      result.jsp
      CurrencyConverter.java

  Q2_Room_Reservation_EJB/                  ← No Database
      index.html
      result.jsp
      RoomReservationBean.java

  Q3_Shopping_Cart_Stateful_EJB/            ← No Database
      index.html
      cart.jsp
      ShoppingCartBean.java

Practical6/
  Q1_Singleton_Visit_Counter/               ← No Database
      index.html
      ServletCount.java
      client.java

  Q2_Visitor_Statistics_Remote_EJB/         ← Uses Database (mydb.userstat)
      index.html
      VisitorStatRemote.java
      VisitorStat.java
      client.java
      db_setup.sql

Practical7/                                 ← Uses Database (guestbookdb) - pure JPA
  index.jsp
  Guestbook.java
  GuestbookServlet.java
  persistence.xml
  db_setup.sql

Practical8/                                 ← Uses Database (guestbookdb) - Hibernate
  index.jsp
  Guestbook.java
  GuestbookServlet.java
  HibernateUtil.java
  hibernate.cfg.xml
  db_setup.sql

===========================================
WHICH PRACTICALS USE DATABASE?
===========================================
✓ Practical 1 - Q1   → userdb.users
✓ Practical 3 - Q3   → jspdb.register
✓ Practical 4 - Q1   → jspdb.registration
✓ Practical 6 - Q2   → mydb.userstat
✓ Practical 7        → guestbookdb
✓ Practical 8        → guestbookdb

All above folders contain ready-to-run db_setup.sql file.

Default credentials in codes: root / root
(Change according to your MySQL)

===========================================
Good luck!
===========================================
