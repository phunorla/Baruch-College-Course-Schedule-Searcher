<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%

// 
//--CHECK_OracleSID
//select * from all_services

String driver = "oracle.jdbc.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String myusername = "cis4160"; //YOur oracle ID
String mypassword = "cis4160"; //YOur oracle Pass
%>
<%
	Connection conn=null;
	try
	{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, myusername, mypassword);

		Statement st = conn.createStatement();
		
        String s[]=null;
		ResultSet rs=null;
		rs = st.executeQuery("SELECT * FROM INSTRUCTOR_SR ");
		List<String> li = new ArrayList();

        while (rs.next()) {
               li.add(rs.getString(2));
        }

        String[] str = new String[li.size()];
        Iterator<String> it = li.iterator();

        int i = 0;
        while (it.hasNext()) {
               String p = (String) it.next();
               str[i] = p;
               i++;
        }

        //jQuery related start
        String query = (String) request.getParameter("q");

        int cnt = 1;
        for (int j = 0; j < str.length; j++) {
               if (str[j].toUpperCase().startsWith(query.toUpperCase())) {
                     out.print(str[j] + "\n");
                     if (cnt >= 5)// 5=How many results have to show while we are typing(auto suggestions)
                            break;
                     cnt++;
               }
        }
        //jQuery related end

        rs.close();
        st.close();
        conn.close();

 } catch (Exception e) {
        e.printStackTrace();
 }

%>

		
		
