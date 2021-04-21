//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Client {
    String host = "localhost";

    public Client() {
    }

    public Client(String host) {
        this.host = host;
    }

    public void connect() {
        try {
            Socket socket = new Socket("localhost", 8888);
            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter writer = new PrintWriter(socket.getOutputStream(), true);
            Scanner in = new Scanner(System.in);
            String command = in.nextLine();
            writer.println(command);
            if (command.split(" ")[0].compareTo("get") == 0) {
                String msg = reader.readLine();
                if (msg.compareTo("B") == 0) {
                    for(msg = reader.readLine(); msg.compareTo("E") != 0; msg = reader.readLine()) {
                        System.out.println(msg);
                    }
                } else {
                    System.out.println(msg);
                }
            }
        } catch (IOException var7) {
            var7.printStackTrace();
        }

    }

    public static void main(String[] args) {
        Client client;
        if (args.length != 0) {
            client = new Client(args[0]);
        } else {
            client = new Client();
        }

        client.connect();
    }
}
