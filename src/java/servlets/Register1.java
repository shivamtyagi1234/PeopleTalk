package servlets;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig

public class Register1 extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session=request.getSession();
        try (PrintWriter out = response.getWriter()) {
          String email= request.getParameter("email");
          String name= request.getParameter("name");
          String phone= request.getParameter("phone");
          String gen= request.getParameter("gender");
          String d=request.getParameter("dob");
          java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");
          java.util.Date dt=sdf.parse(d);
          java.sql.Date dob=new java.sql.Date(dt.getTime());
          String state= request.getParameter("state");
          String area= request.getParameter("area");
          String city= request.getParameter("city");
          Part photo=request.getPart("photo");
    java.io.InputStream in;
    if(photo!=null){
        in = photo.getInputStream();
    }else{
        in=null;
    }
          String pass=request.getParameter("password");
         db.DbConnect db=new db.DbConnect();
       String m =db.insertUser(email, pass, name, phone, gen, dob, state, city, area, in);
       
       if(m.equalsIgnoreCase("done")){
           java.util.HashMap UserDetails=new java.util.HashMap();
           UserDetails.put("email",email);
           UserDetails.put("name",name);
           UserDetails.put("phone",phone);
           UserDetails.put("gender",gen);
           UserDetails.put("dob",dob);
           UserDetails.put("state",state);
           UserDetails.put("city",city);
           UserDetails.put("area",area);
           
           session.setAttribute("UserDeatails",UserDetails);
           response.sendRedirect("profile.jsp"); 
        }
        else if(m.equalsIgnoreCase("already")){
            session.setAttribute("msg","email id already exist");
           response.sendRedirect("home.jsp");
        }
        else{
           session.setAttribute("msg","registration failed");
           response.sendRedirect("home.jsp");
    }
        }
        catch(Exception ex){
            session.setAttribute("msg",ex);
            response.sendRedirect("home.jsp");
        }
        }
}
