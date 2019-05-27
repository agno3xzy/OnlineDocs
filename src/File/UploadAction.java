package File;

import dao.Dao;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Set;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class UploadAction {
    private String username;
    private File[] fileUpload;
    private String[] fileUploadFileName;//名字规范  File属性的 名字+FileName,(该属性为上传过来的文件名)

    public String execute() throws IOException {
        String path = ServletActionContext.getServletContext().getRealPath("/fileUpload/");//该path为tomcat下的webapp/工程/下
        for(int i = 0;i<fileUpload.length;i++){
            File log=new File(path+"\\"+username+"\\log");
            FileUtils.copyFile(fileUpload[i],new File(path+"\\"+ username + "\\create\\" + fileUploadFileName[i]));
            log.mkdirs();
            try
            {
                Dao dao = new Dao();
                Connection conn = dao.getConnection();
                Statement sm1 = conn.createStatement();
                String sql1 = "INSERT into " +
                        "document(document_name, create_time, last_modify_time, text_path, log_path) " +
                        "VALUES ('"+fileUploadFileName[i]+"','"+
                        DateFormat.getDateTimeInstance(2, 2, Locale.CHINESE).format(new java.util.Date()) +
                        "','"+ DateFormat.getDateTimeInstance(2, 2, Locale.CHINESE).format(new java.util.Date()) +
                        "','"+path+"\\"+ username + "\\create\\" + fileUploadFileName[i]+
                        "','"+path+"\\"+ username + "\\log\\" + fileUploadFileName[i]+"')";
                sm1.execute(sql1);

                PreparedStatement p1 = conn.prepareStatement("select * from user where user_name='"+username+"'");
                ResultSet rs1 = p1.executeQuery();
                rs1.next();

                PreparedStatement p2 = conn.prepareStatement("select * from document " +
                        "where text_path='"+path+"\\"+ username + "\\create\\" + fileUploadFileName[i]+"'");
                ResultSet rs2 = p2.executeQuery();
                rs2.next();

                Statement sm2 = conn.createStatement();
                String sql2="INSERT into " +
                        "cooperate(permission, user_iduser, document_iddocument) " +
                        "VALUES ('own','"+
                        rs1.getString("iduser")+"','"+
                        rs2.getString("iddocument")+"')";
                sm2.execute(sql2);
                dao.close(sm1);
                dao.close(sm2);
                dao.close(rs1,p1);
                dao.close(rs2,p2);
                dao.close(conn);
            }
            catch(SQLException e)
            {
                System.out.println("数据库出问题");
            }
        }

        return SUCCESS;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public File[] getFileUpload() {
        return fileUpload;
    }

    public void setFileUpload(File[] fileUpload) {
        this.fileUpload = fileUpload;
    }

    public String[] getFileUploadFileName() {
        return fileUploadFileName;
    }

    public void setFileUploadFileName(String[] fileUploadFileName) {
        this.fileUploadFileName = fileUploadFileName;
    }
}
