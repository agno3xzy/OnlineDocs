package File;

import DiffMatchPatch.diff_match_patch;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.lang.reflect.Array;
import java.lang.reflect.Type;
import java.util.*;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class VersionAction {
    private String logpath;
    private String timestamp;

    public String getLogpath() {
        return logpath;
    }

    public void setLogpath(String logpath) {
        this.logpath = logpath;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public static String getFilePath(String filePath) {
        String[] path = filePath.split("/");
        path[path.length - 2] = "create";
        path[path.length - 1] = path[path.length - 1].replace("_version.json", ".txt");
        return StringUtils.join(path, "/");
    }

    public String excute() throws IOException {
        String filePath = getFilePath(this.logpath);
        File file = new File(filePath);
        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);
        StringBuilder sb = new StringBuilder();
        String str = br.readLine();

        while (str != null) {
            sb.append(str.replaceAll("\n", ""))
                    .append(System.getProperty("line.separator"));
            str = br.readLine();
        }
        fr.close();
        br.close();

        File logFile = new File(this.logpath);
        Map<String, String> versionLog = new HashMap<String, String>();
        Gson gson = new Gson();
        String content = new Scanner(logFile).useDelimiter("\\Z").next();
        Type type = new TypeToken<Map<String, String>>() {
        }.getType();
        versionLog = gson.fromJson(content, type);
        Object[] keys = versionLog.keySet().toArray();
        Arrays.sort(keys);

        int node = Arrays.binarySearch(keys, this.timestamp);

        for (int i = keys.length - 1; i > node; i--) {
            diff_match_patch dmp = new diff_match_patch();
            String strPatches = versionLog.get(keys[i]);
            LinkedList<diff_match_patch.Patch> patches = (LinkedList<diff_match_patch.Patch>) dmp.patch_fromText(strPatches);
            Object[] tmp;
            tmp = dmp.patch_apply(patches, str);
            str = (String) (tmp[0]);
        }

        try (PrintWriter out = new PrintWriter(filePath)) {
            out.println(str);
        }

        for (int i = keys.length - 1; i >= node; i--) {
            versionLog.remove(keys[i]);
        }

        try (PrintWriter out = new PrintWriter(this.logpath)) {
            out.println(gson.toJson(versionLog));
        }

        return SUCCESS;
    }

}
