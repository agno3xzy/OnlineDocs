package File;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class EditAction {

    private String path;
    private String content;
    private String filename;
    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPath() {
        return this.path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setFilename(String path){

        String[] pathArray = getPath().split("/");
        this.filename = pathArray[pathArray.length-1];
        System.out.print(this.filename);
    }

    public String getFilename(){
        return this.filename;
    }
    public String execute() {
        return SUCCESS;
    }


}
