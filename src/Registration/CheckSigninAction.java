package Registration;

import Controller.logincontroller;
import com.opensymphony.xwork2.ActionSupport;
import dao.Dao;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CheckSigninAction extends ActionSupport {
    private String username;
    private String shareDocsNameList;
    private String shareDocsPathList;
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getShareDocsNameList() {
        return shareDocsNameList;
    }
    public void setShareDocsNameList(String shareDocsNameList) {
        this.shareDocsNameList = shareDocsNameList;
    }
    public String getShareDocsPathList() {
        return shareDocsPathList;
    }
    public void setShareDocsPathList(String shareDocsPathList) {
        this.shareDocsPathList = shareDocsPathList;
    }
    @Override
    public String execute() {
        String password = "";
        try {
            logincontroller login = new logincontroller();
            password = login.checkLogin(username);
            System.out.println(password);
            //取得response 实例
            ServletResponse response = ServletActionContext.getResponse();
            PrintWriter writer = response.getWriter();
            writer.write(password);

            Dao dao = new Dao();
            Connection conn = dao.getConnection();

            PreparedStatement p2 = conn.prepareStatement("select * from user " +
                    "where user_name='"+username+"'");
            ResultSet rs2 = p2.executeQuery();
            rs2.next();
            String uid=rs2.getString("iduser");

            PreparedStatement p1 = conn.prepareStatement("select * from cooperate " +
                    "where user_iduser='"+uid+"' and permission='share'");
            ResultSet rs1 = p1.executeQuery();
            List<String> shareDocs=new ArrayList<>();
            while (rs1.next()){
                shareDocs.add(rs1.getString("document_iddocument"));
            }

            for (String temp_s:shareDocs){
                PreparedStatement p3 = conn.prepareStatement(
                        "select * from document " +
                        "where iddocument='"+temp_s+"'");
                ResultSet rs3 = p3.executeQuery();
                rs3.next();
                shareDocsNameList+=rs3.getString("document_name")+",";
                shareDocsPathList+=rs3.getString("text_path")+",";
                dao.close(rs3,p3);
            }

            shareDocsNameList = shareDocsNameList.substring(0,shareDocsNameList.length() - 1);
            shareDocsPathList = shareDocsPathList.substring(0,shareDocsPathList.length() - 1);

            dao.close(rs1,p1);
            dao.close(rs2,p2);
            dao.close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
