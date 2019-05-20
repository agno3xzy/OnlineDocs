package File;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class DeleteAction {
    private String path;
    private String username;

    public String execute(){
        File file = new File(path);//这里有很多处理手段满足不同需求(从数据库读取等)
        file.delete();
        return SUCCESS;
    }

    public String getPath(){
        return path;
    }

    public void setPath(String path){
        this.path=path;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
