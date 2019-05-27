package DiffMatchPatch;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import difflib.StringUtills;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.*;

public class Diff {
    /*
    Online Docs' Document history structure
    * */
    Map<String, String> userToPatch = new HashMap();
    Map<String, Map> timeToUser = new HashMap();
    String currentTime;
    String[] userID;

    /**
     * @Title：saveVersionLog
     * @Description: save log after user click save button or system execute auto-save for recording history
     * @Param: String oldVerPath last version's document path
     * @Param: String newVerPath latest version's document path
     * @author <a href="mail to: agno3xzy@gmail.com">agno3, gui Li</a>
     * @CreateDate: 2019年5月27日 15点16分
     * @update:
     * @LogStructure
     * * Timestamp
     *      * Patches
     **/

    public static void saveVersionLog(String oldVerPath, String newVerPath) throws IOException {
        String timeStamp = timeStamp();

        String versionLogPath = getLogPath(oldVerPath, true);

        File oldfile = new File(oldVerPath);
        File newfile = new File(newVerPath);

        FileReader ofr = new FileReader(oldfile);  //字符输入流
        FileReader nfr = new FileReader(newfile);

        BufferedReader nbr = new BufferedReader(nfr);  //使文件可按行读取并具有缓冲功能
        BufferedReader obr = new BufferedReader(ofr);

        StringBuilder nsb = new StringBuilder();   //strB用来存储jsp.txt文件里的内容
        StringBuilder osb = new StringBuilder();

        String ostr = obr.readLine();
        String nstr = nbr.readLine();


        while (nstr != null) {
            nsb.append(nstr.replaceAll("\n", ""))
                    .append(System.getProperty("line.separator"));
            nstr = nbr.readLine();
        }
        //关闭输入流
        System.out.println(nsb.toString());
        while (ostr != null) {
            osb.append(ostr.replaceAll("\n", ""))
                    .append(System.getProperty("line.separator"));
            ostr = obr.readLine();
        }

        diff_match_patch dmp = new diff_match_patch();
        LinkedList<diff_match_patch.Patch> patches = dmp.patch_make(osb.toString(), nsb.toString());
        String patch = dmp.patch_toText(patches);

        Map<String, String> versionLog = new HashMap<String, String>();


        Gson gson = new Gson();

        File versionLogFile = new File(versionLogPath);

        if(versionLogFile.exists()){
            String content = new Scanner(versionLogFile).useDelimiter("\\Z").next();
            Type type = new TypeToken<Map<String, String>>(){}.getType();
            versionLog = gson.fromJson(content, type);
        }

        versionLog.put(timeStamp,patch);
        PrintStream ps = new PrintStream(new FileOutputStream(versionLogFile));
        ps.print(gson.toJson(versionLog));

        ps.close();
        nbr.close();
        obr.close();
    }


    /**
     * @Title：saveEditLog
     * @Description: save log for user's every operations
     * @Param: editPatches user operation patches
     * @Param: String oldVerPath last version's document path
     * @author <a href="mail to: agno3xzy@gmail.com">agno3, gui Li</a>
     * @CreateDate: 2019年5月27日 15点16分
     * @update:
     * @LogStructure
     * * Timestamp
     *      * UserID
     *          * Patches
     **/
    public static void saveEditLog(String userID,String oldVerPath, LinkedList<diff_match_patch.Patch> editPatches) throws FileNotFoundException {
        diff_match_patch dmp = new diff_match_patch();
        String editPatch = dmp.patch_toText(editPatches);
        String timeStamp = timeStamp();

        String editLogPath = getLogPath(oldVerPath, false);

        Map<String, String> editLog1 = new HashMap<String, String>();
        Map<String,Map<String, String>> editLog2 = new HashMap<String,Map<String, String>>();
        Gson gson = new GsonBuilder().disableHtmlEscaping().create();

        File editLogFile = new File(editLogPath);
        Type type = new TypeToken<Map<String,Map<String, String>>>(){}.getType();

        if(editLogFile.exists()){
            String content = new Scanner(editLogFile).useDelimiter("\\Z").next();

            editLog2 = gson.fromJson(content, type);
        }
        editLog1.put(userID ,editPatch);

        editLog2.put(timeStamp,editLog1);

        PrintStream ps = new PrintStream(new FileOutputStream(editLogFile));
        ps.print(gson.toJson(editLog2,type));
        ps.close();

    }

    public static void main(String args[]) throws IOException {
    }

    /**
     * 十六进制转换字符串
     *
     * @param hexStr str Byte字符串(Byte之间无分隔符 如:[616C6B])
     * @return String 对应的字符串
     */
    public static String hexStr2Str(String hexStr) {
        //hexStr.replaceAll("%","");
        String str = "0123456789ABCDEF";
        char[] hexs = hexStr.toCharArray();
        byte[] bytes = new byte[hexStr.length() / 2];
        int n;

        for (int i = 0; i < bytes.length; i++) {
            n = str.indexOf(hexs[2 * i]) * 16;
            n += str.indexOf(hexs[2 * i + 1]);
            bytes[i] = (byte) (n & 0xff);
        }
        return new String(bytes);
    }

    /**
     * * 取得当前时间戳（精确到秒）
     */
    public static String timeStamp() {
        long time = System.currentTimeMillis();
        String t = String.valueOf(time / 1000);
        String format = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date(Long.valueOf(t + "000")));
    }


    /**
     * * 获取日志地址
     */
    public static String getLogPath(String filePath, boolean type){
        String[] path = filePath.split("\\\\");
        path[path.length - 2] = "log";
        String [] test = path[path.length - 1].split("\\.");
        String filename = path[path.length - 1].split("\\.")[0];

        if(type == true){
            String versionLogName = filename + "_version.json";
            path[path.length - 1 ] = versionLogName;
            return StringUtils.join(path,"\\");
        }
        else{
            String editLogName = filename + "_edit.json";
            path[path.length - 1 ] = editLogName;
            return StringUtils.join(path,"\\");
        }
    }
}
