package com.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.entity.Order;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.service.IMovieService;
import com.service.IOrderService;
import com.service.IScheduleService;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Resource
	private IOrderService orderService;
	@Resource
	private IScheduleService scheduleService;  //支付、退票成功 座位+-
	@Resource
	private IMovieService movieService; //支付、退票成功  票房+-
	//查看订单是否 是支付的（返回给前端的数据）
	@Resource
	private IUserService userService;
	
	@RequestMapping("findOrderById")
	@ResponseBody
	public JSONObject findOrderById(@RequestParam("order_id")String order_id, HttpServletRequest request) {
		String path = request.getServletContext().getRealPath("/upload/App.png/");
		JSONObject obj = new JSONObject();
		Order order = orderService.findOrderById(order_id);
		order.setQRImage(path);
		List<Order> list = new ArrayList<Order>();
		list.add(order);
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", list.size());
		obj.put("data",list);
		return obj;
	}
	
	@RequestMapping("findOrderByUserName")
	@ResponseBody
	public JSONObject findOrderByUserName(@RequestParam(value="page",defaultValue="1")Integer page,@RequestParam(value="limit",defaultValue="10")Integer limit,@RequestParam("user_name")String user_name, HttpServletRequest request) {
		PageInfo<Order> info = orderService.findOrdersByUserName(page, limit, user_name);
		String path = request.getServletContext().getRealPath("/upload/App.png/");
		for(Order order:info.getList()){
			order.setQRImage(path);
		}
		System.out.println("PageInfo-1: " + info.toString());
		JSONObject obj = new JSONObject();
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", info.getTotal());
		obj.put("data", info.getList());
		return obj;
	}
	
	@RequestMapping("findRefundOrderByUser")
	@ResponseBody
	public JSONObject findRefundOrderByUser(@RequestParam("user_name")String user_name, HttpServletRequest request) {
		String path = request.getServletContext().getRealPath("/upload/App.png/");
		JSONObject obj = new JSONObject();
		List<Order> list = this.orderService.findRefundOrderByUserName(user_name);
		for (Order order:list){
			order.setQRImage(path);
		}
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", list.size());
		obj.put("data", list);
		return obj;
	}
	
	@RequestMapping("findAllOrders")
	@ResponseBody
	public JSONObject findAllOrders(HttpServletRequest request) {
		String path = request.getServletContext().getRealPath("/upload/App.png/");
		JSONObject obj = new JSONObject();
		List<Order> list = orderService.findAllOrders();
		for (Order order:list){
			order.setQRImage(path);
		}
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", list.size());
		obj.put("data", list);
		return obj;
	}
	
	@RequestMapping("findAllOrdersPage")
	@ResponseBody
	public JSONObject findAllOrdersPage(@RequestParam(value="page",defaultValue="1")Integer page,@RequestParam(value="limit",defaultValue="10")Integer limit,String keyword, HttpServletRequest request) {
		PageInfo<Order> info = orderService.findAllOrdersBySplitPage(page, limit, keyword);
		String path = request.getServletContext().getRealPath("/upload/App.png/");
		for(Order order:info.getList()){
			order.setQRImage(path);
		}
		JSONObject obj = new JSONObject();
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", info.getTotal());
		obj.put("data", info.getList());
		return obj;
	}
	
	@RequestMapping("findAllRefundOrder")
	@ResponseBody
	public JSONObject findAllRefundOrder(@RequestParam(value="page",defaultValue="1")Integer page,@RequestParam(value="limit",defaultValue="10")Integer limit) {
		JSONObject obj = new JSONObject();
		PageInfo<Order> info = orderService.findOrdersByState(page, limit, 0);
		System.out.println("PageInfo-3: " + info.toString());
		obj.put("code", 0);
		obj.put("msg", "");
		obj.put("count", info.getTotal());
		obj.put("data", info.getList());
		return obj;
	}
	
	@RequestMapping("buyTickets")
	@ResponseBody
	public JSONObject buyTickets(@RequestParam("schedule_id")long schedule_id,@RequestParam("position[]")String[] position,@RequestParam("price")int price,HttpServletRequest request) {
		User user = (User)request.getSession().getAttribute("user");
		JSONObject obj = new JSONObject();
		int sign = 0;
		int flag = 0;
		if(user == null){
			Long userId = null;
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("user")){
					userId = Long.parseLong(cookie.getValue());
					flag = 1;
					break;
				}
			}
			if(flag == 1){
				sign = 1;
				user = userService.findUserById(userId);
			}
		} else {
			sign = 1;
		}
		if(sign != 1) {
			obj.put("code",200);
//			obj.put("msg", "您未登录,登录之后才可购票~");
			obj.put("msg", "You have not logged in yet, please log in to buy ticket");
		} else {
			double money = userService.findCardByUID((int)user.getUser_id()).getMoney();
			if (money<price){
				obj.put("code",200);
//				obj.put("msg", "购票失败~");
				obj.put("msg", "Not sufficient funds");
				obj.put("data", money);
				return obj;
			}

			int done = 0;
			int order_price = price / position.length;
			String user_id = "";
			switch(String.valueOf(user.getUser_id()).length()) {
			case 1: user_id = "000" + String.valueOf(user.getUser_id()); break;
			case 2: user_id = "00" + String.valueOf(user.getUser_id()); break;
			case 3: user_id = "0" + String.valueOf(user.getUser_id()); break;
			case 4: user_id = String.valueOf(user.getUser_id()); break;
			}
			for(int i = 0;i < position.length;i++) {
				Order order = new Order();
				String order_id = "";
				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("YYYYMMdd");
				order_id += dateFormat.format(date);
				order_id += user_id;
				String index = "";
				switch(position[i].length()) {
					case 4: 
						index = "0" + position[i].replaceAll("排", "0");
						index = index.replaceAll("座", "");
						break;
					case 5:
						if(position[i].charAt(2) >= 48 && position[i].charAt(2) <= 57) {
							index = "0" + position[i].replaceAll("排", "");
							index = index.replaceAll("座", "");
						}else {
							index = position[i].replaceAll("排", "0");
							index = index.replaceAll("座", "");
						}
						break;
					case 6:
						index = position[i].replaceAll("排", ""); 
						index = index.replaceAll("座", "");
						break;
				}
				order_id += index;
				order.setOrder_id(order_id);
				order.setOrder_position(position[i]);
				order.setSchedule_id(schedule_id);
				order.setUser_id(user.getUser_id());
				order.setOrder_price(order_price);
				order.setOrder_time(new Date());
				Integer rs = this.orderService.addOrder(order);
				Integer rs1 = this.scheduleService.delScheduleRemain(schedule_id);
				done++;
			}
			if(done == position.length) {
				float sum = (float)price/10000;
				Integer rs2 = this.movieService.changeMovieBoxOffice(sum, this.scheduleService.findScheduleById(schedule_id).getMovie_id());
				money = userService.withhold((int)user.getUser_id(),price);
				obj.put("code",0);
//				obj.put("msg", "购票成功~");
				obj.put("msg", "Buy ticket successfully");
				obj.put("data", money);
			}else {
				obj.put("code",200);
//				obj.put("msg", "购票失败~");
				obj.put("msg", "Buy ticket failed");
			}
		}
		return obj;
	}

	@RequestMapping("applyForRefund")
	@ResponseBody
	public JSONObject applyForRefund(@RequestParam("order_id")String order_id) {
		JSONObject obj = new JSONObject();
		Integer rs = orderService.updateOrderStateToRefund(order_id);
		if(rs > 0) {
			obj.put("code", 0);
//			obj.put("msg", "退票申请已发送~");
			obj.put("msg", "Refund request is already sent");
		}else {
			obj.put("code", 200);
//			obj.put("msg", "操作失败~");
			obj.put("msg", "Refund request failed");
		}
		return obj;
	}


	@RequestMapping("agreeForRefund")
	@ResponseBody
	public JSONObject agreeForRefund(@RequestParam("order_id")String order_id) {
		JSONObject obj = new JSONObject();
		Integer rs = this.orderService.updateOrderStateToRefunded(order_id);
		if(rs > 0) {
			Order order = this.orderService.findOrderById(order_id);
			int price = order.getOrder_price();
			long movie_id = order.getOrder_schedule().getMovie_id();
			Integer rs2 = this.movieService.changeMovieBoxOffice((float)price/10000, movie_id);
			obj.put("code", 0);
//			obj.put("msg", "退票成功");
			obj.put("msg", "Refund successfully");
		}else {
			obj.put("code", 200);
//			obj.put("msg", "退票失败");
			obj.put("msg", "Refund failed");
		}
		return obj;
	}
}
