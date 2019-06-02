package ConflictHandle;

import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FileOperation {
    private String oldFilePath;
    private String newFilePath;
    private int index_log;//这一次记录日志应传递的操作序列开始位置
    private Map<String,Integer> user_index;//这一次更新文档应传递的操作序列开始位置
    private File newFile;
    private File oldFile;
    private List<String[]> optable;//操作序列表格（插入/删除，行数，开始位置，内容/字符数，是否插入新行/删除旧行，用户名）

    public FileOperation(String oldFilePath,String newFilePath,int index_log,Map<String,Integer> user_index,List<String[]> optable){
        this.index_log=index_log;
        this.user_index=user_index;
        this.newFilePath=newFilePath;
        this.oldFilePath=oldFilePath;
        this.optable=optable;
        this.oldFile=new File(oldFilePath);
        this.newFile=new File(newFilePath);
        try{
            this.newFile.createNewFile();
            copyFile(this.oldFile,this.newFile);
        }
        catch (Exception e){

        }
    }

    //记录日志时获取上一次记录日志后的所有操作序列
    public List<String[]> logFile(){
        List<String[]> temp=new ArrayList<>();
        try{
            int i=this.index_log;
            while (i<this.optable.size()){
                temp.add(this.optable.get(i));
                i++;
            }
            this.index_log=this.optable.size();
            copyFile(this.newFile,this.oldFile);
        }
        catch (Exception e){

        }
        return temp;
    }

    public String getOldFilePath(){
        return oldFilePath;
    }

    public void setOldFilePath(String oldFilePath){
        this.oldFilePath=oldFilePath;
    }

    public String getNewFilePath(){
        return newFilePath;
    }

    public void setNewFilePath(String newFilePath){
        this.newFilePath=newFilePath;
    }

    public File getOldFile(){
        return oldFile;
    }

    public File getNewFile(){
        return newFile;
    }

    public int getIndex_log(){
        return index_log;
    }

    public void setIndex_log(int index_log){
        this.index_log=index_log;
    }

    public int getUser_index(String username){
        return user_index.get(username);
    }

    public int setUser_index(String username,int index){
        return user_index.put(username,index);
    }

    //检测某用户更改痕迹是否已被记录，若无则新增记录
    public void insertUser_index(String username){
        if (!this.user_index.containsKey(username)){
            this.user_index.put(username,0);
        }
    }

    public List<String[]> getOptable(){
        return optable;
    }

    public void addOptable(String[] s){
        this.optable.add(s);
    }

    // 复制文件
    private void copyFile(File sourceFile, File targetFile)
            throws IOException {
        // 新建文件输入流并对它进行缓冲
        FileInputStream input = new FileInputStream(sourceFile);
        BufferedInputStream inBuff=new BufferedInputStream(input);

        // 新建文件输出流并对它进行缓冲
        FileOutputStream output = new FileOutputStream(targetFile);
        BufferedOutputStream outBuff=new BufferedOutputStream(output);

        // 缓冲数组
        byte[] b = new byte[1024 * 5];
        int len;
        while ((len =inBuff.read(b)) != -1) {
            outBuff.write(b, 0, len);
        }
        // 刷新此缓冲的输出流
        outBuff.flush();

        //关闭流
        inBuff.close();
        outBuff.close();
        output.close();
        input.close();
    }
}
