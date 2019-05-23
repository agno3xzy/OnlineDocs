package DiffMatchPatch;
import java.util.LinkedList;

public class Diff {
    public static void main(String args[]) {
        diff_match_patch dmp = new diff_match_patch();
        LinkedList<diff_match_patch.Diff> diff = dmp.diff_main("Hello World.", "Goodbye World.");
        // Result: [(-1, "Hell"), (1, "G"), (0, "o"), (1, "odbye"), (0, " World.")]
        dmp.diff_cleanupSemantic(diff);
        // Result: [(-1, "Hello"), (1, "Goodbye"), (0, " World.")]
        System.out.println(diff);
    }
}
