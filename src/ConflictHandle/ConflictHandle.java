package ConflictHandle;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ConflictHandle extends ActionSupport {
    private String oldPath;
    private String newPath;
    private String username;
    private String operation;
    private List<FileOperation> FopList=new ArrayList<>();
    private FileOperation Fop;

    //根据历史数据修正行数和行内开始位置
    private String[] merge(String[] op){
        int i=Fop.getUser_index(username);
        int line=Integer.valueOf(op[1]);
        int start=Integer.valueOf(op[2]);
        boolean line_change;
        if (op[4].equals("true")){
            line_change=true;
        }
        else{
            line_change=false;
        }
        if (line_change){
            while (i<Fop.getOptable().size()){
                while (!(Integer.valueOf(Fop.getOptable().get(i)[1])<=line
                        && Fop.getOptable().get(i)[4].equals("true"))){
                    i++;
                }
                if (Fop.getOptable().get(i)[0].equals("ins")){
                    line++;
                }
                else if (Fop.getOptable().get(i)[0].equals("del")){
                    line--;
                }
            }
        }
        else{
            while (i<Fop.getOptable().size()){
                while ((Integer.valueOf(Fop.getOptable().get(i)[1])<line
                        && !Fop.getOptable().get(i)[4].equals("true"))
                        ||
                        (Integer.valueOf(Fop.getOptable().get(i)[1])==line
                        && (Integer.valueOf(Fop.getOptable().get(i)[2])>start
                        || Fop.getOptable().get(i)[4].equals("true")))
                        ||
                        (Integer.valueOf(Fop.getOptable().get(i)[1])>line)){
                    i++;
                }
                if (Integer.valueOf(Fop.getOptable().get(i)[1])<line && Fop.getOptable().get(i)[4].equals("true")) {
                    if (Fop.getOptable().get(i)[0].equals("ins")){
                        line++;
                    }
                    else if (Fop.getOptable().get(i)[0].equals("del")){
                        line--;
                    }
                }
                else if (Integer.valueOf(Fop.getOptable().get(i)[1])==line && Integer.valueOf(Fop.getOptable().get(i)[2])<=start){
                    start+=Fop.getOptable().get(i)[3].length();
                }
            }
        }
        op[1]=String.valueOf(line);
        op[2]=String.valueOf(start);
        return op;
    }

    //根据操作更新内容
    private ArrayList<String> update_doc(String[] op,ArrayList<String> arrayList){
        int line=Integer.valueOf(op[1]);
        int start=Integer.valueOf(op[2]);
        if (op[4].equals("true")){//整行操作
            if (op[0].equals("ins")){
                arrayList.add(line+1,op[3]);
            }
            else {
                arrayList.remove(line);
            }
        }
        else{//行内操作
            StringBuffer buffer =new StringBuffer(arrayList.get(line));
            if (op[0].equals("ins")){
                buffer.insert(start,op[3]);
                arrayList.set(line,buffer.substring(0));
            }
            else {
                buffer.delete(start,start+op[3].length());
                arrayList.set(line,buffer.substring(0));
            }
        }
        return arrayList;
    }

    //按行写文件
    private void writeFile(ArrayList<String> content,String path_t){
        try {
            File fout = new File(path_t);
            FileOutputStream fos = new FileOutputStream(fout);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
            for (String l:content) {
                bw.write(l);
                bw.newLine();
            }
            //fos.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //按行读文件
    private ArrayList<String> readFile(String path_t){
        ArrayList<String> arrayList = new ArrayList<>();
        try {
            FileReader fr = new FileReader(path_t);
            BufferedReader bf = new BufferedReader(fr);
            String str="";
            while ((str = bf.readLine()) != null) {
                arrayList.add(str);
            }
            bf.close();
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return arrayList;
    }

    //加载文档内容
    private void loadContent(){
        try {
            String content="";
            FileReader fr = new FileReader(newPath);
            BufferedReader bf = new BufferedReader(fr);
            String str="";
            while ((str = bf.readLine()) != null) {
                content+=str+"\n";
            }
            bf.close();
            fr.close();

            //取得response 实例
            ServletResponse response = ServletActionContext.getResponse();
            PrintWriter writer = response.getWriter();
            writer.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //检查这个文档的修改记录是否已被追踪
    private int isContains(String path_t){
        int temp=-1;
        for (FileOperation f:FopList){
            if (f.getNewFilePath().equals(path_t)){
                temp=FopList.indexOf(f);
                break;
            }
        }
        return temp;
    }

    //根据文档路径获取相应文档操作类
    public FileOperation getFop(String newpath,String oldpath){
        FileOperation fop_t;
        int int_temp=isContains(newpath);
        if (int_temp>=0){
            fop_t=FopList.get(int_temp);
        }
        else{
            fop_t=new FileOperation(oldpath,newpath,
                    0,new HashMap<String, Integer>(),new ArrayList<>());
        }
        return fop_t;
    }

    @Override
    public String execute() {
        Fop=getFop(newPath,oldPath);
        Fop.insertUser_index(username);
        String[] lss=operation.split(";");
        String timeStamp=lss[0];
        try{
            if (lss.length>1){
                String[] ls = lss[1].split("\\.");
                ArrayList<String> content=readFile(newPath);
                //operation=forward_operation();
                for (String l : ls) {
                    String[] s = (l + "," + username+ "," + timeStamp ).split(",");
                    s[1]=String.valueOf(Integer.valueOf(s[1])-1);
                    s = merge(s);
                    content=update_doc(s,content);
                    Fop.addOptable(s);
                    Fop.setUser_index(username, Fop.getOptable().size());
                }
                writeFile(content,newPath);
            }
            loadContent();
        }
        catch (Exception e){

        }
        return null;
    }

    public String getOperation() {return operation;}

    public void setOperation(String operation) {this.operation=operation;}

    public String getUsername() {return username;}

    public void setUsername(String username) {this.username = username;}


    public String getOldPath(){return oldPath;}

    public void setOldPath(String oldPath){this.oldPath=oldPath;}

    public String getNewPath(){return newPath;}

    public void setNewPath(String newPath){this.newPath=newPath;}
}
