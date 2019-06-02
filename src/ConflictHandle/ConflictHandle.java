package ConflictHandle;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ConflictHandle extends ActionSupport {
    private String path;
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
                while (!(Integer.valueOf(Fop.getOptable().get(i)[1])<=line && Fop.getOptable().get(i)[4].equals("true"))){
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
                while ((Integer.valueOf(Fop.getOptable().get(i)[1])<line && !Fop.getOptable().get(i)[4].equals("true"))
                        || (Integer.valueOf(Fop.getOptable().get(i)[1])==line && Integer.valueOf(Fop.getOptable().get(i)[2])>start)
                        || (Integer.valueOf(Fop.getOptable().get(i)[1])>line)){
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

    //根据操作更新服务器文档
    private void update_doc(String[] op){
        ArrayList<String> arrayList = new ArrayList<>();
        try {
            FileReader fr = new FileReader(path);
            BufferedReader bf = new BufferedReader(fr);
            String str;
            while ((str = bf.readLine()) != null) {
                arrayList.add(str);
            }
            bf.close();
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        int line=Integer.valueOf(op[1]);
        int start=Integer.valueOf(op[2]);
        if (op[4].equals("true")){//整行操作
            if (op[0].equals("ins")){
                arrayList.add(line,op[3]);
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
                buffer.delete(start,start+Integer.valueOf(op[3])-1);
                arrayList.set(line,buffer.substring(0));
            }
        }
        try {//写文件
            FileOutputStream fos = new FileOutputStream(Fop.getNewFilePath());
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
            for (String l:arrayList) {
                bw.write(l);
                bw.newLine();
            }
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //检查这个文档的修改记录是否已被追踪
    private int isContains(String path_t){
        int temp=-1;
        for (FileOperation f:FopList){
            if (f.getOldFilePath().equals(path_t)){
                temp=FopList.indexOf(f);
                break;
            }
        }
        return temp;
    }

    //根据文档路径获取相应文档操作类
    public FileOperation getFop(String path_t){
        FileOperation fop_t;
        int int_temp=isContains(path_t);
        if (int_temp>=0){
            fop_t=FopList.get(int_temp);
        }
        else{
            String[] string_t=path_t.split("\\\\");
            String[] string_tt=string_t[string_t.length-1].split("\\.");
            string_tt[0]+="_t";
            string_t[string_t.length-1]=String.join(".",string_tt);
            fop_t=new FileOperation(path_t,String.join("\\\\",string_t),
                    0,new HashMap<String, Integer>(),new ArrayList<>());
        }
        return fop_t;
    }

    @Override
    public String execute() {
        Fop=getFop(path);
        Fop.insertUser_index(username);
        String[] ls=operation.split("\\.");
        //operation=forward_operation();
        for (String l:ls){
            String[] s=(l+","+username).split(",");
            s=merge(s);
            update_doc(s);
            Fop.addOptable(s);
            Fop.setUser_index(username,Fop.getOptable().size());
        }
        return null;
    }

    public String getOperation() {return operation;}

    public void setOperation(String operation) {this.operation=operation;}

    public String getUsername() {return username;}

    public void setUsername(String username) {this.username = username;}


    public String getPath(){return path;}

    public void setPath(String path){this.path=path;}
}
