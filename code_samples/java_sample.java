import java.nio.file.Files; //$ importing an external module (inline)$$
import java.nio.file.Path;
import java.nio.file.Paths;

//$ In Java, all functions are class methods (block)
class Main {
  public static void main(String[] args) {
//$$
    try {
      // creates a file object
      Path path = Paths.get("JavaFile.java");

      // deletes the file
      boolean value = Files.deleteIfExists(path);
      //$ define an if statement (block)
      if(value) {
        System.out.println("JavaFile.java is successfully deleted.");
      }
      else {
        System.out.println("File doesn't exit");
      } //$$
    } catch (Exception e) {
      e.getStackTrace(); // I do NOT want to see this comment on Mindbase
    }

  }
}
