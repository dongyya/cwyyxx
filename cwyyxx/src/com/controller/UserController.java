package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.User;
import com.service.UserService;
import com.utils.EmailUtil;
import com.utils.ResponseUtil;

/**
 * 用户Controller类
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 用户登陆验证
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request){
		HttpSession session = request.getSession();
		User currentUser = userService.login(user);
		if(currentUser==null){
			request.setAttribute("errorMsg", "用户名或密码错误");
			request.setAttribute("user", user);
			return "login/login";
		}else{
			//获取当前用户，存放到session中
			session.setAttribute("currentUser", currentUser);
			return "redirect:/pages/main/mainTemp.jsp";
		}
	}
	
	/**
	 * 找回密码
	 * @param email
	 * @param request
	 * @return
	 */
	@RequestMapping("/findpwd")
	public String findBackPassword(@RequestParam(value="email")String email,HttpServletRequest request){
		User u = new User();
		u.setEmail(email);  //把用户输入的邮件地址封装到User对象中去
		User user = userService.findpwd(u);
		if(user==null){
			request.setAttribute("user", u);
			request.setAttribute("Msg", "邮箱地址填写错误");
			return "/login/forget-password";
		}else{
			try {
				EmailUtil.sendEmail(user);
				request.setAttribute("Msg", "邮件发送成功，请注意查收");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				request.setAttribute("Msg", "邮件发送失败");
			}
			return "/login/forget-password";
		}
		
	}
	
	/**
	 * 修改用户密码
	 * @param newPassWord
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/modifypwd")
	public String modifyPassword(@RequestParam(value="newPassWord",required=false)String newPassWord,
			@RequestParam(value="id",required=false)String id,HttpServletResponse response)throws Exception{
		User user = new User();
		user.setUserId(Integer.parseInt(id));
		user.setPassWord(newPassWord);
		int resultNum = userService.updatePwd(user);
		
		JSONObject result = new JSONObject();
		if(resultNum>0){
			result.put("success", true);
			ResponseUtil.write(response, result);
		}else{
			result.put("success", false);
			ResponseUtil.write(response, result);
		}
		
		return null;
	}
	
	/**
	 * 退出登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/exit")
	public String exit(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.removeAttribute("currentUser");
		
		return "redirect:/pages/main/mainTemp.jsp";
	}
	
	/**
	 * 删除用户信息
	 * @param request
	 * @param response
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value="ids",required=false)String ids) throws Exception{
		
		int resultNum = 0;
		String[] id = ids.split(",");
		for(int i=0;i<id.length;i++){
			resultNum = userService.delete(Integer.parseInt(id[i]));
		}
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success", true);
			ResponseUtil.write(response, result);
		}else{
			result.put("success", false);
			ResponseUtil.write(response, result);
		}
		
		return null;
	}
	
}
