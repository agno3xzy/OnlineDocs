package File;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class EditAction {

    String path;
    String content;

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




        return SUCCESS;
    }


}
