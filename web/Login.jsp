<%
    String e=request.getParameter("email");
    String p=request.getParameter("password");
    db.DbConnection db=new db.DbConnection();
    java.util.HashMap UserDetails=db.checkLogin(e, p);
    if(UserDetails!=null){
            session.setAttribute("UserDetails",UserDetails);
            response.sendRedirect("profile.jsp");
    }else{
            session.setAttribute("msg","Invalid Id or Password");
            response.sendRedirect("home.jsp");
    }
%>