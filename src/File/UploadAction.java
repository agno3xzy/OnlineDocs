package File;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.io.IOException;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class UploadAction {
    private String username;
    private File[] fileUpload;
    private String[] fileUploadFileName;//名字规范  File属性的 名字+FileName,(该属性为上传过来的文件名)

    public String execute() throws IOException {
        String path = ServletActionContext.getServletContext().getRealPath("/fileUpload/");//该path为tomcat下的webapp/工程/下
        for(int i = 0;i<fileUpload.length;i++){
            FileUtils.copyFile(fileUpload[i],new File(path+"\\"+ username + "\\create\\" + fileUploadFileName[i]));
        }
        return SUCCESS;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public File[] getFileUpload() {
        return fileUpload;
    }

    public void setFileUpload(File[] fileUpload) {
        this.fileUpload = fileUpload;
    }

    public String[] getFileUploadFileName() {
        return fileUploadFileName;
    }

    public void setFileUploadFileName(String[] fileUploadFileName) {
        this.fileUploadFileName = fileUploadFileName;
    }
}
