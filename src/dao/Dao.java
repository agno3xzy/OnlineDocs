package dao;

import java.sql.*;

public class Dao {
    public Connection getConnection(){
        String url = "jdbc:mysql://localhost:3306/OnlineDocs?serverTimezone=GMT%2B8";
        String username = "root";
        String password = "1234";
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

    public void close(ResultSet rs, PreparedStatement p)
    {
        try
        {
            rs.close();
            p.close();
        }
        catch(SQLException e)
        {
            System.out.println("数据库关闭出错");
        }
    }

    public void close(Statement s)
    {
        try
        {
            s.close();
        }
        catch(SQLException e)
        {
            System.out.println("数据库关闭出错");
        }
    }

    public void close(Connection conn)
    {
        try
        {
            conn.close();
        }
        catch(SQLException e)
        {
            System.out.println("数据库关闭出错");
        }
    }
}