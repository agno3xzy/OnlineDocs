import java.util.ArrayList;
import java.util.List;

import difflib.Delta;
import difflib.DiffRow;
import difflib.DiffRowGenerator;
import difflib.DiffUtils;
import difflib.Patch;
import difflib.DiffRow.Tag;

public class text {
    private String content="";
    private List<String> revised=new ArrayList<>();
    private List<String> original=new ArrayList<>();

    public String execute() throws Exception {
        return "success";
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        original.add(this.content);
        revised.add(content);
        try{
            Thread.sleep(1000);

            Patch patch = DiffUtils.diff(original, revised);

            List<Delta<String>> delta = patch.getDeltas();
            for (int i=0;i<delta.size();i++) {
                List<?> list = delta.get(i).getRevised().getLines();
                for (Object object : list) {
                    System.out.println(object);
                }
            }

            original.clear();
            revised.clear();
        }
        catch(Exception e){

        }
    }
}
