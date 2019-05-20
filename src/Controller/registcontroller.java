package Controller;

import dao.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class registcontroller {
    public boolean regist(ArrayList list) throws Exception {
        String user = (String)list.get(0);
        String password = (String)list.get(1);
        boolean rt = false;

        try {
            Dao dao = new Dao();
            Connection conn = dao.getConnection();
            PreparedStatement p = conn.prepareStatement("select * from user where user_name=" + "\'" + user +  "\'");
            ResultSet rs = p.executeQuery();
            if(rs.next())
                return false;
            Statement sm = conn.createStatement();
            String sql = "insert into user(user_name,password) values(" + "\'" + user +  "\'" + "," + "\'" + password + "\'" +");";
            sm.execute(sql);
            dao.close(rs, p, conn);
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return true;
    }
    public boolean checkRegist(String username) throws Exception {
        try {
            Dao dao = new Dao();
            Connection conn = dao.getConnection();
            PreparedStatement p = conn.prepareStatement("select * from user where user_name=" + "\'" + username +  "\'");
            ResultSet rs = p.executeQuery();
            if(rs.next())
                return false;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return true;
    }
}
