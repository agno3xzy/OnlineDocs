package File;

import com.sun.net.httpserver.Authenticator;

import java.io.*;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class SaveFileAction {

    String newPath;
    String oldPath;
    String username;

    public String getUsername() {return username;}

    public void setUsername(String username) {this.username = username;}


    public String getOldPath(){return oldPath;}

    public void setOldPath(String oldPath){this.oldPath=oldPath;}

    public String getNewPath(){return newPath;}

    public void setNewPath(String newPath){this.newPath=newPath;}

    public String execute() throws IOException {


        return null;
    }

}
