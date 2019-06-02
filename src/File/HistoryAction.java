package File;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Type;
import java.util.*;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class HistoryAction extends ActionSupport {
    private  Map<String, String> versionLog;
    private String username;
    private String[] color;
    private String path;


    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public static String getLogPath(String filePath, boolean type) {
        String[] path = filePath.split("/");
        path[path.length - 2] = "log";
        String[] test = path[path.length - 1].split("\\.");
        String filename = path[path.length - 1].split("\\.")[0];

        if (type == true) {
            String versionLogName = filename + "_version.json";
            path[path.length - 1] = versionLogName;
            return StringUtils.join(path, "/");
        } else {
            String editLogName = filename + "_edit.json";
            path[path.length - 1] = editLogName;
            return StringUtils.join(path, "/");
        }
    }

    public String randomColor(){
        String red;
        //绿色
        String green;
        //蓝色
        String blue;
        //生成随机对象
        Random random = new Random();
        //生成红色颜色代码
        red = Integer.toHexString(random.nextInt(256)).toUpperCase();
        //生成绿色颜色代码
        green = Integer.toHexString(random.nextInt(256)).toUpperCase();
        //生成蓝色颜色代码
        blue = Integer.toHexString(random.nextInt(256)).toUpperCase();

        //判断红色代码的位数
        red = red.length()==1 ? "0" + red : red ;
        //判断绿色代码的位数
        green = green.length()==1 ? "0" + green : green ;
        //判断蓝色代码的位数
        blue = blue.length()==1 ? "0" + blue : blue ;
        //生成十六进制颜色值
        return "#"+red+green+blue;
    }
    public String execute() throws FileNotFoundException {
        Gson gson = new Gson();
        this.path = getLogPath(path, true);
        System.out.println(this.path);
        File versionLogFile = new File(path);
        if (versionLogFile.exists()) {
            String content = new Scanner(versionLogFile).useDelimiter("\\Z").next();
            Type type = new TypeToken<Map<String, String>>() {
            }.getType();
            this.versionLog = gson.fromJson(content, type);
        }
        this.color = new String[versionLog.size()];
        for (int i = 0; i < versionLog.size(); i++) {
            this.color[i] = randomColor();
        }
        return SUCCESS;
    }

    public Map<String, String> getVersionLog() {
        return versionLog;
    }

    public void setVersionLog(Map<String, String> versionLog) {
        this.versionLog = versionLog;
    }

    public String[] getColor() {
        return color;
    }

    public void setColor(String[] color) {
        this.color = color;
    }
}
