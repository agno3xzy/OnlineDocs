package File;

import dao.Dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class EditAction {

    String path;
    String content;
    String docOwner;
    String docID;
    String docSharer="";

    public String getDocOwner() { return this.docOwner; }

    public void setDocOwner(String docOwner){this.docOwner = docOwner;}

    public String getDocSharer(){return this.docSharer;}

    public void setDocSharer(String docSharer){this.docSharer=docSharer;}

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

    public String execute()
    {
        try{
            Dao dao = new Dao();
            Connection conn = dao.getConnection();

            PreparedStatement p1 = conn.prepareStatement("select * from document where text_path='"+path+"'");
            ResultSet rs1 = p1.executeQuery();
            rs1.next();
            docID = rs1.getString("iddocument");


            PreparedStatement p2 = conn.prepareStatement("select * from cooperate where document_iddocument='" + docID +"'" +"AND permission='" + "share" +"'");
            ResultSet rs2 = p2.executeQuery();

            while(rs2.next())
            {
                docSharer+=rs2.getString("user_iduser");
            }

            PreparedStatement p3 = conn.prepareStatement("select * from cooperate where document_iddocument='" + docID + "'" + "AND permission='" + "own" +"'");
            ResultSet rs3 = p3.executeQuery();
            rs3.next();
            docOwner = rs3.getString("user_iduser");

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }




        return SUCCESS;
    }


}
