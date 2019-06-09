package File;

import com.opensymphony.xwork2.ActionSupport;
import dao.Dao;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class EditAction extends ActionSupport {
    String username;
    String docName;
    String path;
    String oldPath;
    String newPath;
    String content;
    String docOwner;
    String docID;
    String docSharer;


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

    public String execute()
    {
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




        return SUCCESS;
    }


}
