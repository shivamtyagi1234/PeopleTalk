package db;
import java.sql.*;
import java.util.HashMap;

public class DbConnect {
    private Connection con;
    private Statement st;
    private PreparedStatement insertUser,checkLogin;
    public DbConnect() throws Exception{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","shivam","shivam");
        insertUser=con.prepareStatement(
                "insert into register_user values (?,?,?,?,?,?,?,?,?,?)");
        checkLogin=con.prepareStatement(
                "select * from register_user where email=? and pass=?");
 
    }
    public String insertUser(String email,String pass,String name,String phone,String gen,java.sql.Date dob,String state,String city,String area,java.io.InputStream in) throws SQLException {
        try{        
 insertUser.setString(1, email);
 insertUser.setString(2, pass);
 insertUser.setString(3, name);
 insertUser.setString(4, phone);
 insertUser.setString(5, gen);
 insertUser.setDate(6, dob);
 insertUser.setString(7, state);
 insertUser.setString(8, city);
 insertUser.setString(9, area);
 insertUser.setBinaryStream(10, in);
int x=insertUser.executeUpdate();
if(x!=0){
 return "Done";
}
else 
 return "Error";
        }catch(java.sql.SQLIntegrityConstraintViolationException ex){
            ex.printStackTrace();
            return "Already";
        }
    }
    public HashMap checkLogin(String e,String p) throws SQLException{     
checkLogin.setString(1, e);
checkLogin.setString(2, p);
ResultSet r=checkLogin.executeQuery();
if(r.next()){
    java.util.HashMap UserDetails=new java.util.HashMap();
    UserDetails.put("email",r.getString("email"));
    UserDetails.put("name",r.getString("name"));
    UserDetails.put("phone",r.getString("phone"));
    UserDetails.put("gender",r.getString("gender"));
    UserDetails.put("dob",r.getDate("dob"));
    UserDetails.put("state",r.getString("state"));
    UserDetails.put("city",r.getString("city"));
    UserDetails.put("area",r.getString("area"));
    return UserDetails;
}else{
    return null;
}
    }
}
