//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

public class Server {
    ServerSocket serverSocket;
    Map<String, String> locked;
    int port = 8888;

    public Server(String port) {
        this.port = Integer.parseInt(port);
    }

    public Server() {
    }

    public void runServer() {
        try {
            this.serverSocket = new ServerSocket(this.port);
            this.locked = new HashMap();
                while(true) {
                    try {
                        Socket socket = this.serverSocket.accept();
                        System.out.println(socket.getInetAddress()+" connect");
                        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                        PrintWriter writer = new PrintWriter(socket.getOutputStream(), true);
                        while (true){
                            String command = reader.readLine();
                            String[] args = command.split(" ");
                            if (args[0].compareTo("get") != 0) {
                                if (args[0].compareTo("set") == 0) {
                                    this.set(args[1], args[2]);
                                } else if (args[0].compareTo("time") == 0) {
                                    int seconds = Integer.parseInt(args[2]);
                                    this.setTimeout(args[1], seconds);
                                } else if (args[0].compareTo("remove") == 0) {
                                    this.remove(args[1]);
                                } else if (args[0].compareTo("clean")==0){
                                    this.clean();
                                }
                            } else {
                                String key = args[1];
                                if (key.compareTo("*") != 0) {
                                    writer.println(this.get(key));
                                } else {
                                    Set<String> keySet = this.locked.keySet();
                                    writer.println("B");
                                    Iterator var8 = keySet.iterator();
                                    while(var8.hasNext()) {
                                        String k = (String)var8.next();
                                        writer.println(k + " " + (String)this.locked.get(k));
                                    }

                                    if (keySet.size() == 0) {
                                        writer.println("null");
                                    }

                                    writer.println("E");
                                }
                            }
                        }
                    } catch (Exception var10) {
                        var10.printStackTrace();
                    }
                }
        } catch (IOException var11) {
            var11.printStackTrace();
        }
    }

    public String get(String key) {
        return this.locked.get(key) != null ? (String)this.locked.get(key) : "null";
    }

    public void set(String key, String value) {
        this.locked.put(key, value);
    }

    public void setTimeout(final String key, int seconds) {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            public void run() {
                Server.this.locked.remove(key);
            }
        }, (long)(seconds * 1000));
    }

    public void remove(String key) {
        this.locked.remove(key);
    }

    public void clean(){
        locked.clear();
    }

    public static void main(String[] args) {
        Server server;
        if (args.length != 0) {
            server = new Server(args[0]);
        } else {
            server = new Server();
        }

        server.runServer();
    }
}
