package Share;

import static com.opensymphony.xwork2.Action.SUCCESS;
import dao.Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


public class ConfirmAction {
    private String userID;
    private String docID;
    private String authority;

    public String getUserID(){return this.userID;}

    public void setUserID(String userID){this.userID = userID;}

    public String getDocID(){return this.docID;}

    public void setDocID(String docID){this.docID=docID;}

    public String getAuthority(){return this.authority;}

    public void setAuthority(String authority){this.authority=authority;}


    public String execute()
    {
        Dao dao = new Dao();
        Connection conn = dao.getConnection();
        String docName = " ";
        String curPermission = "";

        try {
            if(this.authority.equals("read"))
            {
                PreparedStatement p3 = conn.prepareStatement("select * from cooperate where document_iddocument='" + docID + "' and user_iduser= '"+userID +"'");
                ResultSet rs3 = p3.executeQuery();
                boolean hasRes = rs3.next();
                if(hasRes == false)
                {
                    Statement s1 = conn.createStatement();
                    String str1 = "read";
                    s1.execute("insert into cooperate values"+"("+"'" + str1+"'"+","+"'"+userID+"'"+","+"'"+docID+"'"+")");
                    return SUCCESS;
                }
                else {
                    curPermission = rs3.getString("permission");
                    if(curPermission.equals("read"))
                    {
                        return "alreadyHasRead";
                    }
                    else
                    {
                        return "alreadyHasShare";
                    }
                }
            }
            else
            {
                PreparedStatement p4 = conn.prepareStatement("select * from cooperate where document_iddocument='" + docID + "' and user_iduser= '"+userID +"'");
                ResultSet rs4 = p4.executeQuery();
                boolean hasRes = rs4.next();

                if(hasRes == false)
                {
                    Statement s2 = conn.createStatement();
                    s2.execute("insert into cooperate values"+"(" + "share"+","+userID+","+docID+")");
                    return SUCCESS;
                }
                else
                {
                    curPermission = rs4.getString("permission");

                    if(curPermission==null)
                    {
                        Statement s2 = conn.createStatement();
                        s2.execute("insert into cooperate values"+"(" + "share"+","+userID+","+docID+")");
                        return SUCCESS;
                    }

                    else if(curPermission.equals("read"))
                    {
                        Statement s2 = conn.createStatement();
                        s2.execute("update  cooperate set permission ="+"'"+ "share"+"'"+"where document_iddocument='" + docID + "'"+"and user_iduser='"+userID +"'");
                        return SUCCESS;
                    }

                    else
                    {
                        return "alreadyHasShare";
                    }

                }


            }




        }
        catch (Exception e)
        {
            e.printStackTrace();
        }





        return SUCCESS;
    }
}
