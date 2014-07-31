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

</head>

<body bgcolor="white">
<!-- wrapper -->
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<!-- main -->
<div id="main">


  <p>Search results are based on the following keywords:</p>
  <table id="criteria" summary="This table contains the search criteria. Results are listed in next table.">
    <tr>
      <td><strong>Semester</strong>: <% String sem=request.getParameter("semester"); out.println(sem);%></td>
      <td><strong>Days</strong>: <% String day=request.getParameter("week"); out.println(day);%></td>
    </tr>
    <tr>
      <td><strong>Department</strong>: <%out.println(request.getParameter("department"));%></td>
      <td><strong>Time</strong>: <% String timeab=request.getParameter("time_a_b"); out.println(timeab); out.println(" "); String time=request.getParameter("time"); out.println(time);%></td>
    </tr>
    <tr>
      <td><strong>Discipline</strong>: <%out.println(request.getParameter("discipline")); %></td>
      <td><strong>Course number</strong>: <%out.println(request.getParameter("number")); %></td>
    </tr>
    <tr>
      <td><strong>Division</strong>: <%out.print((request.getParameter("div_undr")== null) ? "" : request.getParameter("div_undr")); out.print(" "); out.print((request.getParameter("div_grad")== null) ? "" : request.getParameter("div_grad")); %></td>
      <td><strong>Instructor</strong>: <%out.println(request.getParameter("prof")); %> </td>
    </tr>
    </table>
     <%
   Connection conn = null;
   try
   {
	 Class.forName(driver);
	 conn = DriverManager.getConnection(url,myusername,mypassword);
     Statement stmt = conn.createStatement();
     Statement stmt2 = conn.createStatement();
     Statement stmt3=conn.createStatement();
     Statement stmt4=conn.createStatement();


     ResultSet upd = stmt.executeQuery("SELECT UPDATE_TIME from UPDATE_TIME_SR where semester='summer' or semester='spring'");
     upd.next();
     
     %>
  <font color="red">
  <p><b>The schedule was LAST&nbsp; updated: <%String updtime=upd.getString("UPDATE_TIME"); out.println(updtime); %></b></p>
  <p>Due to the dynamic nature of the registration process, not all courses listed as open will have space for new registrants.</p>
  </font></div>
<table id="results" method="get" action="coursedetails.jsp" bgcolor="white" summary="This table contains the search results for schedule of classes.">
  <caption>
  Schedule of Classes Search Results
  </caption>
  <thead>
    <tr>
      <th scope="col">Course</th>
      <th scope="col">Code</th>
      <th scope="col">Section</th>
      <th scope="col">Day &amp; Time </th>
      <th scope="col">Dates</th>
      <th scope="col">Bldg &amp; Rm </th>
      <th scope="col">Instructor</th>
      <th scope="col">Seats Avail </th>
      <th scope="col">Comments</th>
    </tr>
  </thead>
  <tbody>
  
<%
	 String divsn = ""; 

     String crs_num=request.getParameter("number");
     
     String crs_name=request.getParameter("discipline");
     
     String instructor=request.getParameter("prof");
     
   	if (!(request.getParameter("div_undr")==null) && !(request.getParameter("div_grad") == null)) 
   	{
   		divsn = "";
   	} 
   	else if (!(request.getParameter("div_grad") == null)) 
   	{

   		divsn = "G";

   	} 
   	else if (!(request.getParameter("div_undr") == null))
   	{

   		divsn = "D";
   	}
   	
   String querystring="";
   String querystring2="";
   String querystring3="";
   String semester2=sem.toLowerCase();
   
 	if (!instructor.equals("") && !crs_name.equals("Select") && !crs_num.equals("") && semester2.equals("select")){
 		System.out.println("1");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.DISC='"+crs_name+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	
 	else if(!instructor.equals("") && !crs_name.equals("Select") && !crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("2");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR where e.INSTRUCTOR_LNAME='"+instructor+"' and e.DISC='"+crs_name+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (instructor.equals("") && !crs_name.equals("Select") && !crs_num.equals("") && semester2.equals("select")){
 		System.out.println("3");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.DISC='"+crs_name+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";
 	}
 	else if (!instructor.equals("") && !crs_name.equals("Select") && crs_num.equals("") && semester2.equals("select")){
 		System.out.println("4");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.DISC='"+crs_name+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (instructor.equals("") && !crs_name.equals("Select") && crs_num.equals("") && semester2.equals("select")){
 		System.out.println("5");
 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.DISC='"+crs_name+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	
 	else if (instructor.equals("") && !crs_name.equals("Select") && !crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("6");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.DISC='"+crs_name+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (!instructor.equals("") && crs_name.equals("Select") && !crs_num.equals("") && semester2.equals("select")){
 		System.out.println("7");
 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (!instructor.equals("") && crs_name.equals("Select") && !crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("8");
 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (!instructor.equals("") && !crs_name.equals("Select") && crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("9");
 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.DISC='"+crs_name+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";
	}
 	else if (instructor.equals("") && crs_name.equals("Select") && !crs_num.equals("") && semester2.equals("select")){
 		System.out.println("10");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (instructor.equals("") && crs_name.equals("Select") && !crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("10");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.CRS_NUM='"+crs_num+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (!instructor.equals("") && crs_name.equals("Select") && crs_num.equals("") && semester2.equals("select")){
 		System.out.println("11");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	
 	else if (!instructor.equals("") && crs_name.equals("Select") && crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("12");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.INSTRUCTOR_LNAME='"+instructor+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	
 	else if (instructor.equals("") && !crs_name.equals("Select") && crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("13");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.DISC='"+crs_name+"' and e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where m.DISC_ABBREVIATION='"+crs_name+"' and e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (instructor.equals("") && crs_name.equals("Select") && crs_num.equals("") && semester2.equals("select")){
 		System.out.println("14");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.CRS_CD=m.CRS_CD and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	else if (instructor.equals("") && crs_name.equals("Select") && crs_num.equals("") && !semester2.equals("select")){
 		System.out.println("15");

 		querystring="SELECT * FROM CRS_SEC_SR e, CRS_COMMENTS_SR m, COURSE_SR a where e.CRS_CD=m.CRS_CD and e.SEMESTER='"+semester2+"' and a.COURSENUMBER=e.CRS_NUM and a.DISCIPLINE=e.DISC";
 		querystring3="SELECT * FROM DEPT_SR e, DISCIPLINE_SR m where e.DEPT_ID=m.DEPT_ID";

 	}
 	
 	
 	
 	if (divsn.equals("D") || divsn.equals("G")){
 		querystring=querystring+" and e.D_E_G='"+divsn+"'";
 		
 	}
 	
 	if (!day.equals(""))
 	{
 		querystring=querystring+" and e.MEETING_DAYS='"+day+"'";
 	}
 	
 	
 	 	
 	if (timeab.equals("before"))
 	{
 		String u=time.substring(0, 5);
 	 	String v=time.substring(5, 7);
 		querystring+=" and e.START_TIME<'"+u+"' and e.AM_PM='"+v+"'";
 		
 	}
 	else if(timeab.equals("around"))
 	{
 		String u=time.substring(0, 5);
 	 	String v=time.substring(5, 7);
 		querystring+=" and e.START_TIME='"+u+"' and e.AM_PM='"+v+"'";

 		
 	}
 	else if(timeab.equals("after"))
 	{
 		String u=time.substring(0, 5);
 	 	String v=time.substring(5, 7);
 		querystring+=" and e.START_TIME>'"+u+"' and e.AM_PM='"+v+"'";

 		
 	}
 	
 	

	ResultSet rs = stmt2.executeQuery(querystring);
	ResultSet cs = stmt4.executeQuery(querystring3);
	

	

	
    if (!rs.isBeforeFirst()) 
    {
	   	 response.sendRedirect("schedulesearcherror.jsp");
    
    }
    
    
    cs.next();		 
   
	
	while(rs.next())
      {
    	  String semester=rs.getString("SEMESTER");
    	 String section=rs.getString(5);
    	 String building=rs.getString(12);
    	 String room=rs.getString(13);
    	 String seats=rs.getString(11);
    	 String comments=rs.getString(20);
    	 String code=rs.getString(6);
    	 String course=rs.getString(3);
    	 String course_num=rs.getString(4);
    	 String teacher=rs.getString(16);
    	 String title=rs.getString("TITLE");
    	 String credits=rs.getString("CREDITHOUR");
    	 String description=rs.getString("DESCRIPTION");
    	 String prereq=rs.getString("PREREQ");
    	 String dept=cs.getString("DEPT_NAME");
    	 String days=rs.getString("MEETING_DAYS");
    	 String stime=rs.getString("START_TIME");
    	 String etime=rs.getString("STOP_TIME");
    	 String ampm=rs.getString("AM_PM");
    	 String div=rs.getString("D_E_G");
    	     	 
    	 
    	 if (div.equals("G")) div="Graduate";
    	 else div="Undergraduate";
    	 
    	 SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yy");

    	 String sdate=rs.getString("START_DATE");
    	 String edate=rs.getString("END_DATE");
    	 
    	 java.util.Date x,y = null;
    	 String a,b;
    	 
		 x = new SimpleDateFormat("yyyy-MM-dd").parse(sdate);
		 y = new SimpleDateFormat("yyyy-MM-dd").parse(edate);
		 
		 a=formatter.format(x);
		 b=formatter.format(y);
    	 
		 
		
         out.println("<TR>");
         out.println("<TD>"+"<a href=\"coursedetails.jsp?semester="+semester+"&div="+div+"&course="+course+"&number="+course_num+"&code="+code+"&section="+section+"&seats="+seats+"&title="+title+"&credits="+credits+"&description="+description+"&comments="+comments+"&prereq="+prereq+"&dept="+dept+"&days="+days+"&stime="+stime+"&etime="+etime+"&ampm="+ampm+"&prof="+teacher+"&building="+building+"&room="+room+"&sdate="+a+"&edate="+b+"\">"+course+" "+course_num+"</a>" + "</TD>");
         out.println("<td>"+code+"</td>");
         out.println("<td>"+section+"</td>");
         out.println("<td>"+days+"<br>"+stime+" to "+etime+" "+ampm+"</td>");
         out.println("<td>"+a+" - "+b+"</td>");
         out.println("<td>"+((building == null) ? "" : building)+" "+((room == null) ? "" : room)+"</td>");
         out.println("<td>"+teacher+"</td>");
         out.println("<td>"+seats+"</td>");
         out.println("<td>"+((comments == null) ? "" : comments)+"</td>");
         out.println("</TR>");
         
         
      }
	
	

      
      out.println("</tbody>");

      out.println("</TABLE>");
   }
   
   
   catch(SQLException e)
   {
	   	 response.sendRedirect("schedulesearcherror.jsp");
   }
   catch(ClassNotFoundException e)
   {
	   	 response.sendRedirect("schedulesearcherror.jsp");
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
    

</div>
<!-- /main -->
</div>
<!-- /wrapper -->
</body>
</html>
