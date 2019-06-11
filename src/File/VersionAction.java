package File;

import DiffMatchPatch.diff_match_patch;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.Dao;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.lang.reflect.Array;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class VersionAction {
    private String username;
    private String docName;
    private String path;
    private String oldPath;
    private String newPath;
    private String content;
    private String docOwner;
    private String docID;
    private String docSharer;
    private Map<String, String> versionLog;
    private String[] color;
    private String logpath;
    private String timestamp;

    public void setDocID(String docID) {
        this.docID = docID;
    }


    public void setVersionLog(Map<String, String> versionLog) {
        this.versionLog = versionLog;
    }

    public void setColor(String[] color) {
        this.color = color;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLogpath() {
        return logpath;
    }

    public void setLogpath(String logpath) {
        this.logpath = logpath;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public static String findLogPath(String filePath) {
        String[] path = filePath.split("/");
        path[path.length - 2] = "log";
        path[path.length - 1] = path[path.length - 1].replace( ".txt","_version.json");
        return StringUtils.join(path, "/");
    }

    public String execute() throws IOException {
        this.logpath = findLogPath(this.path);
        File file = new File(this.path);
        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);
        StringBuilder sb = new StringBuilder();
        String str = br.readLine();

        while (str != null) {
            sb.append(str.replaceAll("\n", ""))
                    .append(System.getProperty("line.separator"));
            str = br.readLine();
        }
        fr.close();
        br.close();

        File logFile = new File(this.logpath);
        Map<String, String> versionLog = new HashMap<String, String>();
        Gson gson = new Gson();
        String logContent = new Scanner(logFile).useDelimiter("\\Z").next();
        Type type = new TypeToken<Map<String, String>>() {
        }.getType();
        versionLog = gson.fromJson(logContent, type);
        Object[] keys = versionLog.keySet().toArray();
        Arrays.sort(keys);

        int node = Arrays.binarySearch(keys, this.timestamp);

        str = sb.toString();
        for (int i = keys.length - 1; i >= node; i--) {
            diff_match_patch dmp = new diff_match_patch();
            String strPatches = versionLog.get(keys[i]);
            LinkedList<diff_match_patch.Patch> patches = (LinkedList<diff_match_patch.Patch>) dmp.patch_fromText(strPatches);
            Object[] tmp;
            tmp = dmp.patch_apply(patches, str);
            str = (String) (tmp[0]);
        }

        try (PrintWriter out = new PrintWriter(this.path)) {
            out.println(str);
        }

        for (int i = keys.length - 1; i >= node; i--) {
            versionLog.remove(keys[i]);
        }

        try (PrintWriter out = new PrintWriter(this.logpath)) {
            out.println(gson.toJson(versionLog));
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

            File newfile = new File(newPath);
            File oldfile = new File(oldPath);
            FileUtils.copyFile(oldfile, newfile);
            FileReader nfr = new FileReader(newfile);  //字符输入流
            BufferedReader nbr = new BufferedReader(nfr);  //使文件可按行读取并具有缓冲功能
            StringBuffer strB = new StringBuffer();   //strB用来存储jsp.txt文件里的内容
            String nstr = nbr.readLine();
            while (nstr != null) {
                strB.append(nstr+"\n");   //将读取的内容放入strB
                nstr = nbr.readLine();
            }
            nbr.close();    //关闭输入流
            this.content=strB.toString();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        this.color = new String[1];

        if(this.versionLog != null){
            this.color = new String[versionLog.size()];
            for (int i = 0; i < versionLog.size(); i++) {
                this.color[i] = HistoryAction.randomColor();
            }
        }

        return SUCCESS;
    }



}
