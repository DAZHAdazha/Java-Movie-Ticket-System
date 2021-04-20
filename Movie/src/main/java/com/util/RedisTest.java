package com.util;

import com.util.JedisPoolUtils;
import org.junit.Test;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.util.List;
import java.util.Map;
import java.util.Set;
public class RedisTest {


    @Test
    public void test1(){
        //1.获取链接 默认6379端口
        Jedis jedis = new Jedis("localhost",6379);
        //2.操作
        jedis.set("username","zzzzz");
        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test2(){
        //1.获取链接 如果使用空参构造默认localhost 6379端口
        Jedis jedis = new Jedis();
        //2.操作
        //存储
        jedis.set("username","zzzzz");

        //获取
        String username = jedis.get("username");
        System.out.println(username);

        //可以使用setex()方法存储可以指定过期时间的key value 过期时间为20秒
        jedis.setex("activecode",20,"hhh");

        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test3(){
        //1.获取链接 如果使用空参构造默认localhost 6379端口
        Jedis jedis = new Jedis();
        //2.操作
        //存储
        jedis.hset("myhash","name","dazhaya");
        jedis.hset("myhash","gender","male");
        jedis.hset("myhash","age","23");

        String myhash = jedis.hget("myhash", "gender");
        System.out.println(myhash);

        //获取hash的所有map中的数据
        Map<String, String> myhash1 = jedis.hgetAll("myhash");

        //keyset遍历集合
        Set<String> keySet = myhash1.keySet();
        for (String s : keySet) {
            System.out.println(s + ":" + myhash1.get(s));
        }
        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test4(){
        //1.获取链接 如果使用空参构造默认localhost 6379端口
        Jedis jedis = new Jedis();
        //2.操作

        //list 存储
        jedis.lpush("mylist","a","b","c"); //一次可以存多个值
        jedis.rpush("mylist","a","b","c"); //一次可以存多个值

        // list 范围获取
        List<String> mylist = jedis.lrange("mylist", 0, -1);
        //[c, b, a, a, b, c]
        System.out.println(mylist);

        //list 弹出
        String element1 = jedis.lpop("mylist");
        System.out.println(element1);

        String element2 = jedis.rpop("mylist");
        System.out.println(element2);

        // list 范围获取
        mylist = jedis.lrange("mylist", 0, -1);
        //[c, b, a, a, b, c]
        System.out.println(mylist);

        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test5(){
        //1.获取链接 如果使用空参构造默认localhost 6379端口
        Jedis jedis = new Jedis();
        //2.操作

        //set 存储
        jedis.sadd("myset","java","php","c++");

        Set<String> myset = jedis.smembers("myset");
        System.out.println(myset);

        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test6(){
        //1.获取链接 如果使用空参构造默认localhost 6379端口
        Jedis jedis = new Jedis();
        //2.操作

        //sortedset 存储
        jedis.zadd("mysortedset",3,"dazha");
        jedis.zadd("mysortedset",30,"dazha1");
        jedis.zadd("mysortedset",25,"dazha2");

        Set<String> mysortedset = jedis.zrange("mysortedset", 0, -1);
        System.out.println(mysortedset);

        //3.关闭链接
        jedis.close();
    }

    @Test
    public void test7(){
        //创建一个配置对象
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(50);
        jedisPoolConfig.setMaxIdle(10);

        //创建jedis连接池对象
        JedisPool jedisPool = new JedisPool(jedisPoolConfig,"localhost",6379);
//        JedisPool jedisPool = new JedisPool(); 默认空参

        //获取连接
        Jedis jedis = jedisPool.getResource();

        //使用
        jedis.set("hehe","hha");
        jedis.close();
    }

    @Test
    public void test8(){
        //通过连接池工具类获取
        Jedis jedis = JedisPoolUtils.getJedis();

        jedis.set("hello","world");

        jedis.close();


    }
}
