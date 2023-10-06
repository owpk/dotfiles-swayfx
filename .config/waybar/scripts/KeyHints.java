import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class KeyHints {
    private static final int STEP = 50;

    public static void main(String... args) throws Exception {
        args = new String[]{"/home/owpk/.config/sway/config.d/default"};
        if (args.length != 1) {
            System.err.println("pass path to sway keybind config as first arg");
            System.exit(1);
        }

        var lines = Files.lines(Paths.get(args[0]))
                .map(String::strip)
                .filter(x -> x.contains("$mod"))
                .map(x -> x.replaceAll("[ |\t]+", " ")
                        .replaceAll("\"", "").substring(x.indexOf("$"))).collect(Collectors.toList());

        var splittedSource = splitToSublist(lines.stream()
              .sorted(Comparator.comparing(x -> x.toLowerCase())).collect(Collectors.toList()));

        var splittedListOfMap = splittedSource.stream()
                .map(x -> {
                     var map = x.stream().map(s -> s.split(" ", 2))
                        .collect(Collectors.toMap(x1 -> x1[0], x2 -> x2[1]));
                    var tree = new TreeMap<String, String>(
                            Comparator.comparing(c -> c, String.CASE_INSENSITIVE_ORDER));
                    tree.putAll(map);
                    return tree;
                }).map(x -> {
                    var longestKey = getLongestStringFormat(
                            streamToLongestWordLength(x.keySet().stream()));
                    return x.entrySet().stream()
                            .map(s -> (String.format(longestKey, s.getKey()) + s.getValue())
                                    .replaceAll(" ", "."))
                            .collect(Collectors.toList());
                }).map(x -> new Column(x, streamToLongestWordLength(x.stream())))
                .collect(Collectors.toList());
        var sb = new StringBuilder();
        var longestColumn = splittedListOfMap.stream()
                .max(Comparator.comparing(x -> x.content.size()))
                .orElse(new Column()).content;

        for (int i = 0; i < longestColumn.size(); i++) {
            for (Column currentColumn : splittedListOfMap) {
                String currentLine = "";
                if (i < currentColumn.content.size()) {
                    currentLine = currentColumn.content.get(i);
                }
                sb.append(String.format(getLongestStringFormat(currentColumn.width) + "  |  ", currentLine));
            }
            sb.append("\n");
        }
        System.out.println(sb);
    }

    private static class Column {
        List<String> content = new ArrayList<>();
        int width;

        public Column() {
        }

        public Column(List<String> content, int width) {
            this.content = content;
            this.width = width;
        }
    }

    private static String getLongestStringFormat(int size) {
        return "%-" + size + "s";
    }

    private static int streamToLongestWordLength(Stream<String> st) {
        return st.max(Comparator.comparing(String::length))
                .orElse("").length() + 2;
    }

    private static List<List<String>> splitToSublist(List<String> baseList) {
        var list = new ArrayList<List<String>>();
        int start = 0;
        int step = Math.min(STEP, baseList.size());
        int end = step;
        while (start < end) {
            var sublist = baseList.subList(start, end);
            list.add(sublist);
            start = end + 1;
            step = Math.min(baseList.size() - end, step);
            end += step;
        }
        return list;
    }
}
