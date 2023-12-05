
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="HallTicket.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String qrValue = request.getParameter("qr");


    Connection con = SQLconnection.getconnection();
    Statement st1 = con.createStatement();
    try {
        ResultSet rs1 = st1.executeQuery("SELECT * FROM hall_ticket_requests where  unique_id='" + qrValue + "' AND htstatus='Approved'");
        System.out.println("Check 1 Pass");
        if (rs1.next()) {
            response.sendRedirect("TicketVerification.jsp?Passed");
        } else {
            response.sendRedirect("TicketVerification.jsp?Failed");
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
