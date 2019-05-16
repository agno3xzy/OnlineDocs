package dao;

import java.sql.*;

public class Dao {
    public Connection getConnection(){
        String url = "jdbc:mysql://localhost:3306/OnlineDocs";
        String username = "root";
        String password = "Lyy19980122";
        Connection conn = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
        }
        catch(ClassNotFoundException e)
        {
            System.out.println("驱动加载出错");
        }
        catch(SQLException e)
        {
            System.out.println("数据库连接出错");
        }
        return conn;
    }

    public void close(ResultSet rs, PreparedStatement p, Connection conn)
    {
        try
        {
            rs.close();
            p.close();
            conn.close();
        }
        catch(SQLException e)
        {
            System.out.println("数据库关闭出错");
        }
    }
}
