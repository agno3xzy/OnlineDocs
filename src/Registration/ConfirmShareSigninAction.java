package Registration;
import com.opensymphony.xwork2.ActionSupport;
import static com.opensymphony.xwork2.Action.SUCCESS;

public class ConfirmShareSigninAction {
    String username;
    String password;
    String docID;

    public String execute() {
        return SUCCESS;
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

    public String getDocID(){return this.docID;}

    public void setDocID(String docID){this.docID=docID;}

}
