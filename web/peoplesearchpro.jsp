<%@page import="java.util.HashMap"%>
<%
    HashMap UserDetails=(HashMap)session.getAttribute("UserDetails");
    if(UserDetails!=null){ 
    String s=request.getParameter("state");
    String c=request.getParameter("city");
    String a=request.getParameter("area");
    String e=(String)UserDetails.get("email");
    db.DbConnect db=(db.DbConnect)session.getAttribute("db");
    if(db==null){
        db=new db.DbConnect();
        session.setAttribute("db",db);
    }
    java.util.HashSet allUserDetails=db.searchUsers(s, c, a,e );
    if(!allUserDetails.isEmpty()){
            session.setAttribute("allUserDetails",allUserDetails);
            session.setAttribute("state", s);
            session.setAttribute("city", c);
            session.setAttribute("area", a);
            response.sendRedirect("peoplesearch.jsp");
    }else{
            session.setAttribute("msg","No data found!");
            response.sendRedirect("profile.jsp");
    }
    }else{
        session.setAttribute("msg","Plz Login first");
        response.sendRedirect("home.jsp");
    }
%>