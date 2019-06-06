package File;

import dao.Dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.*;
import java.text.DateFormat;
import java.util.Locale;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class DeleteAction {
    private String path;
    private String username;

    public String execute(){
        File file = new File(path);//这里有很多处理手段满足不同需求(从数据库读取等)
        file.delete();
        try
        {
            Dao dao = new Dao();
            Connection conn = dao.getConnection();

            PreparedStatement p2 = conn.prepareStatement("select * from document " +
                    "where text_path='"+path.replace("\\","/")+"'");
            ResultSet rs2 = p2.executeQuery();
            rs2.next();
            String id=rs2.getString("iddocument");

            Statement sm2 = conn.createStatement();
            String sql2 = "delete from cooperate where document_iddocument='"+id+"'";
            sm2.execute(sql2);

            Statement sm1 = conn.createStatement();
            String sql1 = "delete from document where iddocument='" +id+"'";
            sm1.execute(sql1);

            dao.close(sm1);
            dao.close(sm2);
            dao.close(rs2,p2);
            dao.close(conn);
        }
        catch(SQLException e)
        {
            System.out.println("数据库出问题");
        }
        return SUCCESS;
    }

    public String getPath(){
        return path;
    }

    public void setPath(String path){
        this.path=path;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
