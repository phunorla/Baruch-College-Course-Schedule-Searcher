<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

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
<script type="text/javascript" src="jquery-1.8.2.js"></script>

<script type="text/javascript" src="jquery.ui.autocomplete.js"></script>

<script>
        $("#prof").autocomplete("list.jsp");
    </script>
   

</head>


<body>

		
<!-- wrapper -->
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<!-- main -->
<div id="main">

<form method="get" action="scheduleresults.jsp" action="coursedetails.jsp">

    <div align="center">
     <p class="errormsg"><b><font color="#FF0000">You must select a semester and either a discipine, course number, day, time, and/or instructor.
		</font></b> </p>

      
      <table id="search" summary="This table contains search options for the schedule of classes.">
       
  
	  <tbody>
        <tr>
          <th><label for="semester">Semester:</label></th>
          <td><select id="semester" name="semester">
          <option selected="selected">Select</option>
          <%
	Connection conn=null;
	try
	{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, myusername, mypassword);

		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM SEMESTER_SR order by SEMESTER_NAME ASC");
		
		while (rs.next()){
			out.println("<Option value=" + rs.getString("SEMESTER_NAME") + ">" + rs.getString("SEMESTER_NAME"));
		}
	}
	   catch(SQLException e)
	   {
	      out.println("SQLException: " + e.getMessage() + "<BR>");
	      while((e = e.getNextException()) != null)
	         out.println(e.getMessage() + "<BR>");
	   }
	   catch(ClassNotFoundException e)
	   {
	      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	   }
	   finally
	   {
	      if(conn != null)
	      {
	         try
	         {
	            conn.close();
	         }
	         catch (Exception ignored) {}
	      }
	   }
%>
             
			  
          </select></td>
        </tr>
        <tr>
          <th>Dept:</th>
          <td><select name="department" size="1">
          <option selected="selected">Select</option>
          
          
           <%
	try
	{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, myusername, mypassword);

		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM DEPT_SR order by dept_name asc");
		
		while (rs.next()){
			out.println("<Option value=" + rs.getString("DEPT_NAME") + ">" + rs.getString("DEPT_NAME"));
		}
	}
	   catch(SQLException e)
	   {
	      out.println("SQLException: " + e.getMessage() + "<BR>");
	      while((e = e.getNextException()) != null)
	         out.println(e.getMessage() + "<BR>");
	   }
	   catch(ClassNotFoundException e)
	   {
	      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	   }
	   finally
	   {
	      if(conn != null)
	      {
	         try
	         {
	            conn.close();
	         }
	         catch (Exception ignored) {}
	      }
	   }
%>
          
			
			</select></td>
        </tr>
        <tr>
          <th>Discipline:</th>
          <td><select name="discipline" size="1">
          <option selected="selected">Select</option>
          
          
                <%
	try
	{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, myusername, mypassword);

		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM DISCIPLINE_SR order by disc_abbreviation asc");
		
		while (rs.next()){
			out.println("<Option value=" + rs.getString(1)+ ">" + rs.getString(1));
		}
	}
	   catch(SQLException e)
	   {
	      out.println("SQLException: " + e.getMessage() + "<BR>");
	      while((e = e.getNextException()) != null)
	         out.println(e.getMessage() + "<BR>");
	   }
	   catch(ClassNotFoundException e)
	   {
	      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	   }
	   finally
	   {
	      if(conn != null)
	      {
	         try
	         {
	            conn.close();
	         }
	         catch (Exception ignored) {}
	      }
	   }
%>
          
          
			</select></td>
        </tr>
        <tr>
          <th>Division</th>
          <td>
          
            <label for="undergraduate">Undergraduate </label><input type="checkbox" id="undergraduate" value="U" name="div_undr" checked>
            <br>
            <label for="graduate">Graduate</label><input type="checkbox" id="gradaute" value="G" name="div_grad" unchecked>
          
          </td>
        </tr>
        <tr>
          <th><label for="number">Course number:</label></th>
          <td><input id="number" size="10" name="number" maxlength="5" type="text"></td>
        </tr>
        <tr>
          <th><label for="days">Days:</label></th>
          <td><select id="days" name="week">
              <option value="">Select	All </option>
              <option value="M">Mon </option>
              <option value="MTW">Mon-Tue-Wed </option>
              <option value="MTWF">Mon-Tue-Wed-Fri </option>
              <option value="MTWTH">Mon-Tue-Wed-Thr </option>
              <option value="MW">Mon-Wed </option>
              <option value="MWTH">Mon-Wed-Thr </option>
              <option value="MTH">Mon-Thr </option>
              <option value="T">Tue </option>
              <option value="TWF">Tue-Wed-Fri </option>
              <option value="TWTH">Tue-Wed-Thu </option>
              <option value="TTH">Tue-Thr </option>
              <option value="TF">Tue-Fri </option>
              <option value="W">Wed </option>
              <option value="TH">Thr </option>
              <option value="F">Fri </option>
              <option value="S">Sat </option>
              <option value="SU">Sun </option>
              <option value="HTBA">HTBA</option>
          </select></td>
        </tr>
        <tr>
          <th><label for="time">Time:</label></th>
          <td><select id="time" name="time_a_b">
              <option value="">Select	All </option>
              <option>before </option>
              <option>after </option>
              <option>around </option>
            </select>
            <select name="time">
              <option value="">Select	All </option>
              <option value="07:00AM">7:00am </option>
              <option value="08:00AM">8:00am </option>
              <option value="09:00AM">9:00am </option>
              <option value="10:00AM">10:00am </option>
              <option value="11:00AM">11:00am </option>
              <option value="12:00PM">12:00pm </option>
              <option value="01:00PM">1:00pm </option>
              <option value="02:00PM">2:00pm </option>
              <option value="03:00PM">3:00pm </option>
              <option value="04:00PM">4:00pm </option>
              <option value="05:00PM">5:00pm </option>
              <option value="06:00PM">6:00pm </option>
              <option value="07:00PM">7:00pm </option>
              <option value="08:00PM">8:00pm </option>
              <option value="09:00PM">9:00pm </option>
            </select>          </td>
        </tr>
        <tr>
          <th><label for="instructor">Instructor:</label></th>
          <td><input id="prof" size="30" name="prof" type="text" pattern="^([a-zA-Z_\s\-]*)$"></td>
          
        </tr>
      </tbody>
      </table>
    </div>
    <p align="center">
      <input value="Start Search" type="submit">
   </p>
 
</form>

</div>
<!-- /main -->
</div>
<!-- /wrapper -->
</body>

</html>
