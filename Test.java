import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Test {

    public static void writeToFile(String output, String machine, int id) {
        File file = new File("logs/java/" + machine + "/log." + id + ".java.txt");

        // create if not exists
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            FileWriter writer = new FileWriter(file);
            writer.write(output);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // This line prints "Hello, World!" to the console.
        System.out.println("Hello, World!");
        String machine = args.length > 0 ? args[0] : "local";
        int id = args.length > 1 ? Integer.parseInt(args[1]) : 0;
        System.out.println("machine: " + machine + " id: " + id);
        int counter = 0;
        String output = "machine: " + machine + " id: " + id + " content" + counter;

        while (counter < 1000) {
            counter++;
            output += " " + counter;
        }
        // write to file
        writeToFile(output, machine, id);
    }
}
