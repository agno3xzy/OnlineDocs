package File;

import com.sun.net.httpserver.Authenticator;

import java.io.*;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class SaveFileAction {

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

    public String execute() throws IOException
    {

        File file = new File(path);

        if (!file.exists()) {
            file.createNewFile();
        }

        FileOutputStream out = new FileOutputStream(file);
        out.write(content.getBytes());
        out.close();


        return SUCCESS;
    }

}
