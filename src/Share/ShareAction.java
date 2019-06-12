package Share;

import com.sun.net.httpserver.Authenticator;
import static com.opensymphony.xwork2.Action.SUCCESS;

public class ShareAction {

    private String docName;
    private String authority;
    private String path;
    private String isResultVis;

    public void setDocName(String docName) {
        this.docName = docName;
    }

    public String getDocName(){return this.docName;}

    public void setAuthority(String authority){this.authority = authority;}

    public String getAuthority(){return this.authority;}

    public void setPath(String path){this.path = path;}

    public String getPath(){return this.path;}

    public void setIsResultVis(String isResultVis){this.isResultVis = isResultVis;}

    public String getIsResultVis(){return this.isResultVis;}

    public String execute()
    {
        return SUCCESS;
    }
}
