<%@ page import="java.sql.*" %>
<%

// 
//--CHECK_OracleSID
//select * from all_services

String driver = "oracle.jdbc.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String myusername = "cis4160"; //YOur oracle ID
String mypassword = "cis4160"; //YOur oracle Pass
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Baruch College</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link REL="icon" href="http://www.baruch.cuny.edu/favicon.ico">
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/baruch_interior.css" />
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/application.css" />
<link href="schedule.css" rel="stylesheet" type="text/css" />

</head>

<body>
<!-- wrapper -->
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<!-- main -->
<div id="main">


<table id="details" summary="This table contains details about each course.">
<caption>
Schedule of Classes Course Details 
</caption>  
  <tr>
    <th scope="row">Semester:</th>
    <td><%out.println(request.getParameter("semester"));%> </td>
  </tr>
  <tr>
    <th scope="row">Course - Title:</th>
    <td><%out.println(request.getParameter("course")+" - "+request.getParameter("number")+ " "+request.getParameter("title"));%></td>
  </tr>
  <tr>
    <th scope="row">Code:</th>
    <td><%out.println(request.getParameter("code"));%> </td>
  </tr>
  <tr>
    <th scope="row">Section:</th>
    <td><%out.println(request.getParameter("section"));%></td>
  </tr>
  <tr>
    <th scope="row">Department:</th>
    <td><%out.println(request.getParameter("dept"));%></td>
  </tr>
  <tr>
    <th scope="row">Division:</th>
    <td><%out.println(request.getParameter("div")); %></td>
  </tr>
  <tr>
    <th scope="row">Dates:</th>
    <td><%out.println(request.getParameter("sdate")+" - "+request.getParameter("edate"));%></td>
  </tr>
  <tr>
    <th scope="row">Seats Available:</th>
    <td><%out.println(request.getParameter("seats"));%></td>
  </tr>
  <tr>
    <th scope="row">Meeting - Day &amp; Time, Building &amp; Room, Instructor: </th>
    <td><%out.println(request.getParameter("days")+", "+request.getParameter("stime")+request.getParameter("ampm")+"-"+request.getParameter("etime")+request.getParameter("ampm")+", "+request.getParameter("building")+" "+request.getParameter("room")+", "+request.getParameter("prof"));%></td>
  </tr>
  
  <tr>
    <th scope="row">Credit Hours: </th>
    <td> <%out.println(request.getParameter("credits"));%></td>
  </tr>
  <tr>
    <th scope="row">Description:</th>
    <td><%out.println(request.getParameter("description"));%></td>
  </tr>
  <tr>
    <th scope="row">Course Comments: </th>
    <td><%out.print((request.getParameter("comments")== null) ? "" : request.getParameter("comments")); %></td>
 </tr>
  <tr>
    <th scope="row">Prerequisite:</th>
    <td><%out.println(request.getParameter("prereq"));%></td>
  </tr>
</table>

</div>
<!-- /main -->
</div>
<!-- /wrapper -->
</body>
</html>
