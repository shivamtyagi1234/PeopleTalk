<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html>

<%
    HashMap UserDetails=(HashMap)session.getAttribute("UserDetails");
    if(UserDetails!=null){ 
    HashSet allUserDetails=(HashSet)session.getAttribute("allUserDetails");
    String s=(String)session.getAttribute("state");
    String c=(String)session.getAttribute("city");
    String a=(String)session.getAttribute("area");
    if(a==null){
        a="";
    }
%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleTalk</title>


    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/talk.css" rel="stylesheet">

  
  </head>
 
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="profile.jsp">PeopleTalk</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome:<%=UserDetails.get("name")%> </p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="panel panel-default text center">
			<div class="panel-heading text-center">
                            <%
                                if(a.equals("")){
                            %>
				<h3>Search Results for: <%=s%>/<%=c%></h3>
                                  <%
                                   }else{
                                  %>
                                <h3>Search Results for: <%=s%>/<%=c%>/<%=a%></h3>
                                 <%
                                    } 
                                 %>                         
                        </div>
		</div>
	</div>
	</br>
	</br>
		<div class="container">
			<section>
			<div class="row">
				
            <%
                try{
                  db.DbConnect db=(db.DbConnect)session.getAttribute("db");
                
                if(db==null){
                    
                    db=new db.DbConnect();
                   
                    session.setAttribute("db",db);
                }
               
            java.util.Iterator i=allUserDetails.iterator();
            
            while(i.hasNext()){
                java.util.HashMap ud=(java.util.HashMap)i.next();
           
                    
            %>
			<hr>
			<div class="row">
				<div class="col-lg-3">
					<img src="img/xyz.jpg"> 
				</div>
				<div class="col-lg-7">
					
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey"><%=ud.get("name")%></font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"> <%=ud.get("email")%></font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey"><%=ud.get("gender")%></font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=ud.get("dob")%></font></label><br>
                                                        <label for="phone" class="control-label">Phone: <font color="grey"><%=ud.get("phone")%></font></label><br>
						</div>
				
				</div>
				<div class="col-lg-2">
					<form action="talk.jsp" class="form-horizontal">
						<div class="form-group">
							</br>
							</br>
                                                        <input type="hidden" name="temail" value="<%=ud.get("email")%>"/>
							<button type="search" class="btn btn-primary">Talk</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		</section>
	</div>
	</br>
        <%
            }}catch(Exception ex){
            System.out.println(ex);
            ex.printStackTrace();
}
        %>
	<!--footer-->
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<p>Design and Develop by SHIVAM TYAGI</p>
			</div>
	
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
<%
    
}else{
        session.setAttribute("msg","Plz Login first");
        response.sendRedirect("home.jsp");
}
%>