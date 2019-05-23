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
    String filename;

    public String getPath() {
        return this.path;
    }

    public void setPath(String path) {
        this.path = path;
        String[] pathArray = path.split("/");
        this.filename = pathArray[pathArray.length - 1];
        System.out.print(this.filename);
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFilename() {
        return this.filename;
    }

    public String execute() throws IOException {

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
