package Controller;

import dao.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class logincontroller {

        public String checkLogin(String username) throws Exception {
            String user = username;
            String password = "";
            try
            {
                Dao dao = new Dao();
                Connection conn = dao.getConnection();
                PreparedStatement p = conn.prepareStatement("select * from user");
                ResultSet rs = p.executeQuery();
                HashMap<String,String> hm = new HashMap();
                while(rs.next())
                {
                    hm.put(rs.getString("user_name"), rs.getString("password"));
                }
                dao.close(rs, p, conn);
                Set<String> set = hm.keySet();
                Iterator it = set.iterator();
                while(it.hasNext())
                {
                    if(it.next().equals(user))
                    {
                        password = hm.get(user);
                    }
                }
            }
            catch(SQLException e)
            {
                System.out.println("数据库出问题");
            }
            return password;
        }
}
