<%
    String e=request.getParameter("email");
    db.DbConnect db=(db.DbConnect)session.getAttribute("db");
   //This code is optimizing the performance of website,by creating Database connection only once
   //This code is  should be used in all pages.
    if(db==null){
        db=new db.DbConnect();
        session.setAttribute("db",db);
    }
    byte[] photo=db.getUserPhoto(e);
    response.getOutputStream().write(photo);
%>