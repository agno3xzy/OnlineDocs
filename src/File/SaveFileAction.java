package File;

import DiffMatchPatch.Diff;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sun.net.httpserver.Authenticator;
import dao.Dao;

import java.io.*;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Scanner;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class SaveFileAction {

    private String newpath;
    private String oldpath;
    private String username;

    private String docName;
    private String path;
    private String oldPath;
    private String newPath;
    private String content;
    private String docOwner;
    private String docID;
    private String docSharer;
    private String logpath;
    private Map<String, String> versionLog;
    private String[] color;

    public void setLogpath(String logpath) {
        this.logpath = logpath;
    }

    public void setDocID(String docID) {
        this.docID = docID;
    }

    public void setVersionLog(Map<String, String> versionLog) {
        this.versionLog = versionLog;
    }

    public void setColor(String[] color) {
        this.color = color;
    }

    public String getLogpath() {
        return logpath;
    }

    public String getDocID() {
        return docID;
    }

    public String[] getColor() {
        return color;
    }

    public Map<String, String> getVersionLog() {
        return versionLog;
    }

    public String getDocName() { return this.docName; }

    public void setDocName(String docName){this.docName = docName;}

    public String getDocOwner() { return this.docOwner; }

    public void setDocOwner(String docOwner){this.docOwner = docOwner;}

    public String getDocSharer(){return this.docSharer;}

    public void setDocSharer(String docSharer){this.docSharer=docSharer;}

    public String getOldPath()
    {
        return this.oldPath;
    }

    public void setOldPath(String oldPath)
    {
        this.oldPath = oldPath;
    }

    public String getNewPath()
    {
        return this.newPath;
    }

    public void setNewPath(String newPath)
    {
        this.newPath = newPath;
    }

    public String getPath()
    {
        return this.path;
    }

    public void setPath(String path)
    {
        this.path = path;
    }

    public String getContent()
    {
        return this.content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getUsername() {return username;}

    public void setUsername(String username) {this.username = username;}

    public String getNewpath() {
        return newpath;
    }

    public String getOldpath() {
        return oldpath;
    }

    public void setNewpath(String newpath) {
        this.newpath = newpath;
    }

    public void setOldpath(String oldpath) {
        this.oldpath = oldpath;
    }

    public String execute() throws IOException {

        if (this.oldpath != null && this.newpath != null) {
            Diff.saveVersionLog(this.oldpath, this.newpath);
        }

        try{
            Dao dao = new Dao();
            Connection conn = dao.getConnection();

            PreparedStatement p1 = conn.prepareStatement("select * from document where text_path='"
                    +path.replace("\\","/")+"'");
            ResultSet rs1 = p1.executeQuery();
            rs1.next();
            docID = rs1.getString("iddocument");
            dao.close(rs1,p1);

            PreparedStatement p2 = conn.prepareStatement("select * from cooperate where document_iddocument='"
                    + docID +"'" +"AND permission='" + "share" +"'");
            ResultSet rs2 = p2.executeQuery();

            docSharer="";
            while(rs2.next())
            {
                docSharer+=rs2.getString("user_iduser");
            }
            dao.close(rs2,p2);

            PreparedStatement p3 = conn.prepareStatement("select * from cooperate where document_iddocument='"
                    + docID + "'" + "AND permission='" + "own" +"'");
            ResultSet rs3 = p3.executeQuery();
            rs3.next();
            docOwner = rs3.getString("user_iduser");
            dao.close(rs3,p3);

            PreparedStatement p4 = conn.prepareStatement("select * from document where text_path='"
                    + path.replace("\\","/") + "'");
            ResultSet rs4 = p4.executeQuery();
            rs4.next();
            docName = rs4.getString("document_name");
            dao.close(rs4,p4);
            dao.close(conn);

            oldPath = path;
            String[] string_t=oldPath.split("\\\\");
            String[] string_tt=string_t[string_t.length-1].split("\\.");
            string_tt[0]+="_t";
            string_t[string_t.length-1]=String.join(".",string_tt);
            newPath = String.join("\\",string_t);

            File file = new File(newPath);
            FileReader fr = new FileReader(file);  //字符输入流
            BufferedReader br = new BufferedReader(fr);  //使文件可按行读取并具有缓冲功能
            StringBuffer strB = new StringBuffer();   //strB用来存储jsp.txt文件里的内容
            String str = br.readLine();
            while (str != null) {
                strB.append(str+"\n");   //将读取的内容放入strB
                str = br.readLine();
            }
            br.close();    //关闭输入流
            content=strB.toString();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        //版本日志读出
        Gson gson = new Gson();
        this.logpath = HistoryAction.getLogPath(this.oldPath, true);
        File versionLogFile = new File(logpath);
        if (versionLogFile.exists()) {
            String content = new Scanner(versionLogFile).useDelimiter("\\Z").next();
            Type type = new TypeToken<Map<String, String>>() {
            }.getType();
            this.versionLog = gson.fromJson(content, type);
        }
        this.color = new String[versionLog.size()];
        for (int i = 0; i < versionLog.size(); i++) {
            this.color[i] = HistoryAction.randomColor();
        }

        return SUCCESS;
    }

}
