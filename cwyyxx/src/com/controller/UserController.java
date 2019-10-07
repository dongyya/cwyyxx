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
 * �û�Controller��
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * �û���½��֤
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request){
		HttpSession session = request.getSession();
		User currentUser = userService.login(user);
		if(currentUser==null){
			request.setAttribute("errorMsg", "�û������������");
			request.setAttribute("user", user);
			return "login/login";
		}else{
			//��ȡ��ǰ�û�����ŵ�session��
			session.setAttribute("currentUser", currentUser);
			return "redirect:/pages/main/mainTemp.jsp";
		}
	}
	
	/**
	 * �һ�����
	 * @param email
	 * @param request
	 * @return
	 */
	@RequestMapping("/findpwd")
	public String findBackPassword(@RequestParam(value="email")String email,HttpServletRequest request){
		User u = new User();
		u.setEmail(email);  //���û�������ʼ���ַ��װ��User������ȥ
		User user = userService.findpwd(u);
		if(user==null){
			request.setAttribute("user", u);
			request.setAttribute("Msg", "�����ַ��д����");
			return "/login/forget-password";
		}else{
			try {
				EmailUtil.sendEmail(user);
				request.setAttribute("Msg", "�ʼ����ͳɹ�����ע�����");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				request.setAttribute("Msg", "�ʼ�����ʧ��");
			}
			return "/login/forget-password";
		}
		
	}
	
	/**
	 * �޸��û�����
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
	 * �˳���¼
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
	 * ɾ���û���Ϣ
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
