
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="HallTicket.SQLconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Hall Ticket Automation with Integrated QR Codes</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/table.css" rel="stylesheet">
        <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow  sticky-top p-0 navbar-fixed-top">
            <a href="#" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="StudentHome.jsp" class="nav-item nav-link active">Home</a>
                    <a href="HallTicketRequest.jsp" class="nav-item nav-link">Hall Ticket Request</a>
                    <a href="HTRequestStatus.jsp" class="nav-item nav-link">Request Status</a>
                    <a href="DownloadHallTicket.jsp" class="nav-item nav-link">Download Hall Ticket</a>
                </div>
                <a href="logout.jsp" class="btn btn-primary py-4 px-lg-5 d-none d-lg-block">Logout<i class="fa fa-lock ms-3"></i></a>
            </div>
        </nav>


        <!-- Header Start -->
        <div class="container-fluid bg-primary py-5 mb-5">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-lg-10 text-center">
                        <h1 class="display-3 text-white animated slideInDown">Hall Ticket Download</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb justify-content-center">
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>


        <!-- 404 Start -->
        <div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
            <div class="container text-center">
                <div class="row justify-content-center">

                    <%
                        String sid = session.getAttribute("sid").toString();
                        String rollno = session.getAttribute("rollno").toString();
                        String sname = session.getAttribute("sname").toString();
                        System.out.println("sid " + sid);
                        System.out.println("sid " + sid);
                        String department = session.getAttribute("department").toString();
                        String unique_id = session.getAttribute("unique_id").toString();
                        System.out.println(department);
                        System.out.println(unique_id);
                    %>    
                    <div id="content">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <h1 class="card-title text-center">College Exam Hall Ticket</h1>
                                    <p class="card-text text-center">Exam Date: September 10, 2023</p>
                                    <div class="row">
                                        <div class="col-md-4 text-center">
                                            <!-- Placeholder for student photo -->
                                            <img src="picture.jsp?id=<%=sid%>" alt="Student Photo" class="img-fluid student-photo" width="200px">
                                        </div>
                                        <div class="col-md-4">
                                            <p><strong>Name:</strong> <%=sname%></p>
                                            <p><strong>Roll Number:</strong><%=rollno%></p>
                                            <p><strong>Course:</strong> <%=department%></p>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <!-- Placeholder for QR code -->
                                            <img src="qrpic.jsp?id=<%=unique_id%>" alt="QR Code" class="img-fluid qr-code">
                                        </div>
                                    </div>
                                    <div class="mt-4">
                                        <h2 class="text-center">Exam Schedule</h2>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Subject</th>
                                                    <th>Date</th>
                                                    <th>Time</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String[] subjects = (String[]) session.getAttribute("subjects");
                                                    String[] labs = (String[]) session.getAttribute("labs");
                                                    String[] subjectDates = (String[]) session.getAttribute("subjectDates");
                                                    String[] labDates = (String[]) session.getAttribute("labDates");
                                                    String[] startTimes = (String[]) session.getAttribute("startTimes");
                                                    String[] endTimes = (String[]) session.getAttribute("endTimes");

                                                    for (int i = 0; i < subjects.length; i++) {
                                                %>
                                                <tr>
                                                    <td><%= subjects[i]%></td>
                                                    <td><%= subjectDates[i]%></td>
                                                    <td><%= convertTo12HourFormat(startTimes[i])%> - <%= convertTo12HourFormat(endTimes[i])%></td>
                                                </tr>
                                                <%
                                                    }
                                                    for (int i = 0; i < labs.length; i++) {
                                                %>
                                                <tr>
                                                    <td><%= labs[i]%> (Lab)</td>
                                                    <td><%= labDates[i]%></td>
                                                    <td><%= convertTo12HourFormat(startTimes[subjects.length + i])%> - <%= convertTo12HourFormat(endTimes[subjects.length + i])%></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                            <br><br><br>
                                            <button style="width: 200px" class="btn btn-success" id="downloadBtn">Download Image</button>                                       


                </div>
            </div>
        </div>
        <!-- 404 End -->
        <%!
            String convertTo12HourFormat(String militaryTime) {
                String standardTime = "";
                try {
                    SimpleDateFormat militaryFormat = new SimpleDateFormat("HH:mm");
                    SimpleDateFormat standardFormat = new SimpleDateFormat("hh:mm a");
                    Date militaryDate = militaryFormat.parse(militaryTime);
                    standardTime = standardFormat.format(militaryDate);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return standardTime;
            }
        %>



        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3"></h4>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3"></h4>
                        <div class="d-flex pt-2">
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3"></h4>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3"></h4>
                        <p></p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#"></a> All Right Reserved.
                            <a class="border-bottom" href="#"></a>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
        <script>
            const contentDiv = document.getElementById('content');
            const downloadBtn = document.getElementById('downloadBtn');

            downloadBtn.addEventListener('click', () => {
                // Use html2canvas to capture the content of the div
                html2canvas(contentDiv).then(canvas => {
                    // Convert the canvas content to a data URL
                    const dataUrl = canvas.toDataURL('image/png');

                    // Create a temporary anchor element for downloading
                    const downloadLink = document.createElement('a');
                    downloadLink.href = dataUrl;
                    downloadLink.download = '<%=rollno%>.png';

                    // Trigger a click on the anchor element to initiate download
                    downloadLink.click();
                });
            });
        </script>


    </body>
</html>
