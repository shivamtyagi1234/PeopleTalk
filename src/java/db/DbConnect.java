

package db;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
public class DbConnect {
    public Connection c;
    public Statement st;
   public PreparedStatement insertUser,checkUser,getUserPhoto, searchUser,getUserByEmail,getPassByEmail,changePass,getMessages;
   public DbConnect(){
       try{
       Class.forName("oracle.jdbc.driver.OracleDriver");
c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","shivam","shivam");
insertUser=c.prepareStatement("insert into userinfo values(?,?,?,?,?,?,?,?,?,?)");
      checkUser=c.prepareStatement("select * from userinfo where email=? and pass=?");
      getUserPhoto=c.prepareStatement("select * from userinfo where email=?");
      searchUser=c.prepareStatement("select * from userinfo where state=? and city=? and email!=? and area like ?"); 
      getUserByEmail=c.prepareStatement("select * from userinfo where email=?");
      getPassByEmail=c.prepareStatement("select pass from userinfo where email=?");
      changePass=c.prepareStatement("update userinfo set pass=? where email=? and pass=?");
      getMessages=c.prepareStatement(
                "select * from ptalk where sid=? and rid=?");
       }
      
       catch(Exception ex)
       {
           ex.printStackTrace();
       
}
}
   public String insertUser(String email,String name,String phone,String gender,String state,String city,String area,String pass,java.sql.Date dob, java.io.InputStream is)throws SQLException
   {
        try {
            insertUser.setString(1, email);
             insertUser.setString(2, pass);
              insertUser.setString(3, name);
               insertUser.setString(4, phone);
                insertUser.setString(5, gender);
                 insertUser.setDate(6, dob);
                  insertUser.setString(7, state);
                   insertUser.setString(8, city);
                    insertUser.setString(9, area);
                     insertUser.setBinaryStream(10, is);
                     int x=insertUser.executeUpdate();
                     if(x!=0)
                     {
                         return "Done";
                     }
                     else
                         return "Failed";
        } catch (java.sql.SQLIntegrityConstraintViolationException ex) {
            ex.printStackTrace();
            return "Already";
           
        }
   }
   public HashMap checkUser(String email,String pass) throws SQLException{
      HashMap UserDetails=new HashMap();
     
      checkUser.setString(1,email);
      checkUser.setString(2,pass);
       ResultSet rs=checkUser.executeQuery();
      
      if(rs.next()){
         UserDetails.put("email",rs.getString("email"));
         UserDetails.put("name",rs.getString("name1"));
         UserDetails.put("phone",rs.getString("phone"));
         UserDetails.put("gender",rs.getString("gender"));
         UserDetails.put("dob",rs.getString("dob"));
         UserDetails.put("state",rs.getString("state"));
         UserDetails.put("area",rs.getString("area"));
         UserDetails.put("city",rs.getString("city"));
       return UserDetails;  
      }
      else
      {
          return null;
      }
       
   }
   public byte[] getUserPhoto(String email) throws SQLException{
       getUserPhoto.setString(1,email);
       ResultSet r=getUserPhoto.executeQuery();
       if(r.next()){
           return r.getBytes("photo");
   }
       else {
           return null;
       }
   }
   
   public java.util.HashSet<java.util.HashMap> searchUsers(String s,String c,String a,String e) throws SQLException{   
   searchUser.setString(1,s);
    searchUser.setString(2,c);
     searchUser.setString(3,e);
      searchUser.setString(4,"%"+a+"%");
     ResultSet r= searchUser.executeQuery();
     java.util.HashSet allUserDetails=new java.util.HashSet();
     while(r.next()){
         java.util.HashMap UserDetails=new java.util.HashMap();
        
          UserDetails.put("email",r.getString("email"));
           UserDetails.put("name",r.getString("name1"));
            UserDetails.put("phone",r.getString("phone"));
             UserDetails.put("gender",r.getString("gender"));
              UserDetails.put("dob",r.getDate("dob"));
               UserDetails.put("state",r.getString("state"));
                UserDetails.put("city",r.getString("city"));
                 UserDetails.put("area",r.getString("area"));
                 allUserDetails.add(UserDetails);
     }
     return allUserDetails;
         
}
   public HashMap getUserByEmail(String e) throws SQLException{ 
      getUserByEmail.setString(1,e);
      ResultSet r=getUserByEmail.executeQuery();
      if(r.next()){
          java.util.HashMap UserDetails=new java.util.HashMap();
          UserDetails.put("email",r.getString("email"));
           UserDetails.put("name",r.getString("name1"));
            UserDetails.put("phone",r.getString("phone"));
             UserDetails.put("gender",r.getString("gender"));
              UserDetails.put("dob",r.getDate("dob"));
               UserDetails.put("state",r.getString("state"));
                UserDetails.put("city",r.getString("city"));
                 UserDetails.put("area",r.getString("area"));
                 return UserDetails;
      }
      else
      {
          return null;
      }
          
}
   public String getPassByEmail(String e) throws SQLException{
       getPassByEmail.setString(1,e);
       ResultSet r=getPassByEmail.executeQuery();
       if(r.next()){
          return r.getString("pass");
       }
       else{
           return null;
}
   }
   
   public String changePass(String np,String e,String op) throws SQLException {        
        changePass.setString(1, np);
        changePass.setString(2, e);
        changePass.setString(3, op);
       int x=changePass.executeUpdate();
       if(x==1)
        return "Done";
       else 
        return "Error";
    }
public java.util.HashSet<java.util.HashMap> getMessages(String s,String r) throws SQLException{     
getMessages.setString(1, s);
getMessages.setString(2, r);
ResultSet rs=getMessages.executeQuery();
java.util.HashSet<java.util.HashMap> allMessages=new java.util.HashSet();
while(rs.next()){
    java.util.HashMap message=new java.util.HashMap();
    message.put("message",rs.getString("msg"));
    message.put("filename",rs.getString("filename"));
    message.put("udate",rs.getString("udate"));
    message.put("pid",rs.getInt("pid"));
    allMessages.add(message);
    }
return allMessages;
    }
}
