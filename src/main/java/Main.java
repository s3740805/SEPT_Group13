import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by CoT on 7/29/18.
 */

public class Main {

    public static void main(String[] args) throws Exception {
        Print("doctors");
        Print("bookings");
        Print("patients");
    }

    public static void Print(String target) throws IOException {
        URL url = new URL("http://localhost:8080/"+target);

        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
        String line = "";
        StringBuilder stringBuilder = new StringBuilder();

        while ((line = bufferedReader.readLine()) != null) {
            System.out.println(target+" "+line);
            stringBuilder.append(line);
        }

        String s = stringBuilder.toString();

        System.out.println(s);
    }

}
