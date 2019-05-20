package File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

public class DownloadAction {
    private InputStream inputStream;
    private String fileName;
    private String path;

    public String execute(){
        try {
            this.inputStream = new FileInputStream(path);//这里有很多处理手段满足不同需求(从数据库读取等)
            String[] array=path.split("\\\\");
            this.fileName = array[array.length-1];
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return "success";
    }
    public InputStream getInputStream() {
        return inputStream;
    }
    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }
    /*乱码处理*/
    public String getFileName() {
        String temp=null;
        try {
            temp = new String(this.fileName.getBytes(),"ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return temp;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getPath(){
        return path;
    }

    public void setPath(String path){
        this.path=path;
    }
}
