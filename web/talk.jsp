<%@page import="java.util.HashMap"%>
<%@page  errorPage="Error.jsp" %>
<%
    HashMap UserDetails=(HashMap)session.getAttribute("UserDetails");
    if(UserDetails!=null){ 
        String temail=request.getParameter("temail");
        db.DbConnect db=(db.DbConnect)session.getAttribute("db");
        if(db==null){
            db=new db.DbConnect();
            session.setAttribute("db",db);
        }
        HashMap tUserDetails=db.getUserByEmail(temail);
%>
<!DOCTYPE html>
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
                                    <li><div class="navbar-text"><p>Welcome: <%= UserDetails.get("name") %></p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav><!-- end of navbar-->
	
	</br>
	</br>
		<div class="container">
			<div class="row">
				<div class="col-lg-4">
                                    <%
                                    byte[] photo=
                                                db.getUserPhoto((String)tUserDetails.get("email"));
                                        if(photo.length!=0){
                                    %>
                                        <img src='GetPhoto.jsp?email=<%=tUserDetails.get("email")%>' width="130" height="150">
                                    <%
                                        }else{
                                    %>
                                        <img src="img/xyz.jpg" width="130" height="150">   
                                    <%
                                        }
                                    %>
				</div>
				<div class="col-lg-4">
                                    <div class="form-group">
                                    </br>
                                    <label for="email" class="control-label">Name: <font color="grey"><%=tUserDetails.get("name")%></font></label><br>
                                            <label for="gender" class="control-label">Gender: <font color="grey"><%=tUserDetails.get("gender")%></font></label><br>
                                            <label for="phone" class="control-label">Phone: <font color="grey"><%=tUserDetails.get("phone")%></font></label><br>
                                    </div>
				</div>
				<div class="col-lg-4">
                                    <div class="form-group">
                                    </br>
                                            <label for="name" class="control-label">Email:<font color="grey"> <%=tUserDetails.get("email")%></font></label><br>
                                            <label for="dob" class="control-label">Date of Birth: <font color="grey"><%=tUserDetails.get("dob")%></font></label><br>
                                            <label for="address" class="control-label">Address: <font color="grey"><%=tUserDetails.get("area")%>,<%=tUserDetails.get("city")%>,<%=tUserDetails.get("state")%></font></label><br>
                                    </div>
				</div>
			</div>
		</div>
		</br>
                <hr>
                <%
                String m=(String)session.getAttribute("msg");
                if(m!=null){
                %>
                    <div class="panel">
                        <div class="panel-body bg-danger text-center">
                            <%=m%>
                        </div>
                    </div>
                <%   
                    session.setAttribute("msg",null);
                }
                %>
		<div class="container text-center">
			<div class="panel panel-default">
				<div class="panel-body text-center">
                                    <form action="SendMessage" method="post" enctype='multipart/form-data'  data-toggle="validator"  class="form-horizontal">
						<div class="form-group">
							<label for="message" class="col-lg-2 control-label">Message:</label>
								<div class="col-lg-4">
									<textarea id="message" name="message" class="form-control" rows="5" cols="50" required></textarea>
								</div>
						</div><!--end form group-->
							<div class="form-group">
							<label for="ufile" class="col-lg-2 control-label">File to Send:</label>
								<div class="col-lg-4">
									<input type="file" name="ufile" class="form-control" id="filetosend"/>
								</div>
								<div class="col-lg-2">
                                                                    <input type="hidden" name="temail" value="<%=tUserDetails.get("email")%>"/>
                                                                    <button type="submit" class="btn btn-primary">Send</button>
								</div>
						</div><!--end form group-->
					</form>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<div class="panel panel-default">
				<div class="panel-body text-center">
					<div class="row">
						<div class="col-lg-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
									<h5><%= UserDetails.get("name") %>'s Messages</h5>
								</div>
                                                                <%
                                                                    java.util.HashSet<java.util.HashMap> AlMessages=db.getMessages((String)UserDetails.get("email"),(String)tUserDetails.get("email"));
                                                                    for(java.util.HashMap message : AlMessages){
                                                                %>
								<div class="panel-body text-left">
									<p><%= message.get("message")%></p>
									<div class="row">
										<font size="1">
										<div class="form-group">
											<%
                                                                                        if(!message.get("filename").equals("")){
                                                                                        %>
                                                                                        <div class="col-lg-2">
                                                                                            <label for="message" class="control-label">File: <a href="DownloadFile.jsp?pid=<%=message.get("pid")%>" > <%= message.get("filename")%></a></label>
											</div>
                                                                                        <%    
                                                                                        }
                                                                                        %>
											<div class="col-lg-2">
												<label for="message" class="control-label">Date: <%= message.get("udate")%></label>
											</div>
										</div>
										</font>
									</div>
									<hr>
								</div>
                                                                <%
                                                                    }
                                                                %>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
									<h5><%= tUserDetails.get("name") %>'s Messages</h5>
								</div>
								<%
                                                                     AlMessages=db.getMessages((String)tUserDetails.get("email"),(String)UserDetails.get("email"));
                                                                    for(java.util.HashMap message : AlMessages){
                                                                %>
								<div class="panel-body text-left">
									<p><%= message.get("message")%></p>
									<div class="row">
										<font size="1">
										<div class="form-group">
											<%
                                                                                        if(!message.get("filename").equals("")){
                                                                                        %>
                                                                                        <div class="col-lg-2">
                                                                                            <label for="message" class="control-label">File: <a href="DownloadFile.jsp?pid=<%=message.get("pid")%>" ><%= message.get("filename")%></a></label>
											</div>
                                                                                        <%    
                                                                                        }
                                                                                        %>
											<div class="col-lg-2">
												<label for="message" class="control-label">Date: <%= message.get("udate")%></label>
											</div>
										</div>
										</font>
									</div>
									<hr>
								</div>
                                                                <%
                                                                    }
                                                                %>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<hr>
	
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
	<script type="text/javascript" src="js/jquery-2.2.2.min.js"></script>
    <script src="js/validator.js"></script>
  </body>
</html>
<%
}else{
        session.setAttribute("msg","Plz Login first");
        response.sendRedirect("home.jsp");
}
%>