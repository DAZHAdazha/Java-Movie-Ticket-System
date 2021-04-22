package com.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

public class Zedis {

    private String host;
    private int port;
    private Socket socket;
    private BufferedReader reader;
    private PrintWriter writer;

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public void connect(){
        try {
            System.out.println("Zedis run");
            socket = new Socket(host,port);
            reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            writer = new PrintWriter(socket.getOutputStream(), true );
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String get(String key){
        writer.println("get "+key);
        String res = null;
        try {
            res = reader.readLine();
            if(res.compareTo("null")==0)
                return null;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    public void set(String key,int value){
        writer.println("set "+key+" "+value);
    }

    public void setTime(String key,int second){
        writer.println("time "+key+" "+second);
    }

    public void remove(String key){
        writer.println("remove "+key);
    }

    public Map<String,Integer> all(){
        Map<String, Integer> res = new HashMap<>();
        writer.println("get *");
        String msg;
        try {
            reader.readLine();
            msg = reader.readLine();
            while (msg.compareTo("E") != 0) {
                if (msg.compareTo("null")==0)
                    continue;
                String key = msg.split(" ")[0];
                Integer value = Integer.parseInt(msg.split(" ")[1]);
                res.put(key, value);
                msg = reader.readLine();
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return res;
    }

    public void clean(){
        writer.println("clean");
    }

    public void close(){
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
