package Registration;

import Controller.logincontroller;
import com.opensymphony.xwork2.ActionSupport;
import dao.Dao;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SigninAction extends ActionSupport{
    private String username;
    private String password;
    private String path;
    private String fnameList_create;
    private String shareDocsNameList;
    private String shareDocsPathList;

    @Override
    public String execute() throws Exception{
        path= ServletActionContext.getServletContext().getRealPath("/fileUpload/") + username;
        File file_create = new File(path  + "/create/");
        File[] fileList_create = file_create.listFiles();

        fnameList_create="";
        if (fileList_create!=null && fileList_create.length!=0){
            for (int i = 0; i < fileList_create.length; i++) {
                if (fileList_create[i].getName().indexOf("_t")==-1){
                    fnameList_create+=fileList_create[i].getName()+",";
                }
            }
            fnameList_create=fnameList_create.substring(0,fnameList_create.length()-1);
        }


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
        boolean hasShare=false;
        while (rs1.next()){
            hasShare=true;
            shareDocs.add(rs1.getString("document_iddocument"));
        }

        shareDocsNameList="";
        shareDocsPathList="";
        if (hasShare){
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

        }

        dao.close(rs1,p1);
        dao.close(rs2,p2);
        dao.close(conn);
        return SUCCESS;
    }
    public String getPath () {
        return path;
    }

    public void setPath (String path){
        this.path = path;
    }

    public String getUsername () {
        return username;
    }

    public void setUsername (String username){
        this.username = username;
    }

    public String getPassword () {
        return password;
    }

    public void setPassword (String password){
        this.password = password;
    }

    public String getFnameList_create () {
        return fnameList_create;
    }

    public void setFnameList_create (String fnameList_create){
        this.fnameList_create = fnameList_create;
    }

    public String getShareDocsNameList () {
        return shareDocsNameList;
    }

    public void setShareDocsNameList (String shareDocsNameList){
        this.shareDocsNameList = shareDocsNameList;
    }

    public String getShareDocsPathList () {
        return shareDocsPathList;
    }

    public void setShareDocsPathList (String shareDocsPathList){
        this.shareDocsPathList = shareDocsPathList;
    }
}
