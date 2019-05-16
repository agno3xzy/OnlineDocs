package Controller;

import dao.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class logincontroller {

        public boolean checkLogin(ArrayList list) throws Exception {
            String user = (String)list.get(0);
            String password = (String)list.get(1);
            boolean rt = false;

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

                        if(password.equals(hm.get(user)))
                        {
                            rt = true;
                            break;
                        }
                    }
                }
            }
            catch(SQLException e)
            {
                System.out.println("数据库出问题");
            }
            return rt;
        }
}
