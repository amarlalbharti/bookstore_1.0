package com.bookstore.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Roles;
import com.bookstore.config.Validation;
import com.bookstore.domain.LoginInfo;
import com.bookstore.domain.Product;
import com.bookstore.domain.Registration;
import com.bookstore.service.LoginInfoService;
import com.bookstore.service.MailService;
import com.bookstore.service.ProductService;
import com.bookstore.service.RegistrationService;
import com.bookstore.util.DateUtils;
import com.bookstore.util.Util;

/**
 * @author A. L. Bharti
 *
 */
@Controller
public class IndexController 
{
	@Autowired 
	private  RegistrationService registrationService; 
	@Autowired 
	private  LoginInfoService loginInfoService; 
	@Autowired
	private MailService mailService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private ProductService productService;
	
	
	/**
	 * @param map
	 * @param request 
	 * @param principal is the object for detail of loged in user
	 * @return   name of view mapped in tiles for index page
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("principal : " + principal);
		System.out.println("from index page of index controller");
		List<Product> list = productService.getProducts(0, 10);
		map.addAttribute("productlist", list);
		
		return "index";
	}
	
	@RequestMapping(value = "/product/view/{pid}/{product}", method = RequestMethod.GET)
	public String productView(@PathVariable(value="pid" ) String pid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(Validation.isNumeric(pid)){
			map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
		}
		return "userProductView";
	}
	
	
	
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("test : " );
		System.out.println("from test page of index controller");
		return "test";
	}
	
	
	
	/**
	 * @param map
	 * @param request
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap map, HttpServletRequest request, Principal principal, Locale locale)
	{
		if(principal != null)
		{
//			return "redirect:userHome";
		}
		System.out.println("Local : "+locale);
		System.out.println("from index page of index controller test : " + messageSource.getMessage("label.login.remember_me", null, locale));
		map.addAttribute("errormsg", messageSource.getMessage("NotEmpty.categoryForm.categoryName", null, "Hello to all", locale));
		return "login";
	}
	
	
	
	/**
	 * @param map
	 * @param request
	 * @param principal
	 * @return It redirect to dashboard page based on user loged in role. Like for admin, it redirect to admin dashboard.
	 */
	@RequestMapping(value = "/getLogedIn", method = RequestMethod.GET)
	public String getLogedIn(ModelMap map, HttpServletRequest request, Principal principal, TimeZone timeZone)
	{
		Registration reg = registrationService.getRegistrationByUserid(principal.getName());
		if(reg != null)
		{

			request.getSession(true).setAttribute("registration", reg);
			
			
			return "redirect:userHome";
		}
		return "redirect:login";

	}
	
	/**
	 * @param map
	 * @param request
	 * @param principal
	 * @return redirect to the index page after  login failed
	 */
	@RequestMapping(value = "/failtologin", method = RequestMethod.GET)
	public String failtologin(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from failtologin page of index controller");
		String error="true";
		return "redirect:/login?error="+error;
		
	}
	
	
	@RequestMapping(value = "/session-expired", method = RequestMethod.GET)
	public String sessionExpired(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from session-expired ");
		return "redirect:/login";
		
	}
	
	
	/**
	 * Destroy user session and delete cookies for this JSESSIONID
	 * @param map
	 * @param request
	 * @param principal
	 * @return redirect to the index page after  login failed
	 */
	
	@RequestMapping(value = "/insertLogOut", method = RequestMethod.GET)
	public @ResponseBody String insertLogOut(ModelMap map, HttpServletRequest request)
	{
		System.out.println("from logout page");
		return "logedOut";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from logout successfully");
		
		return "redirect:/login";
		
	}
	
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public String accessDenied(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from access denied ");
		
		return "accessDenied";
		
	}
	
	
	/**
	 * @param map
	 * @param request
	 * @param principal
	 * @return It redirect to dashboard page based on user loged in role. Like for admin, it redirect to admin dashboard.
	 */
	@RequestMapping(value = "/userHome", method = RequestMethod.GET)
	public String userHome(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(request.isUserInRole(Roles.ROLE_ADMIN))
		{
			return "redirect:/admin/dashboard";
		}
		else if(request.isUserInRole(Roles.ROLE_MANAGER))
		{
			return "redirect:/admin/dashboard";
		}
		else
		{
			return "redirect:test";
		}
	}
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String error(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from error page " + request.getRequestURI());
		return "error";
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String forgotPassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "forgotPassword";
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
	public String forgot_Password(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String userid = request.getParameter("userid");
		if(userid != null && userid.length() > 0 && Validation.validateEmail(userid.trim()))
		{
			Registration reg = registrationService.getRegistrationByUserid(userid);
			LoginInfo info = loginInfoService.getLoginInfoByUserid(userid);
			if(reg != null && info != null)
			{
				String uuid = UUID.randomUUID().toString();
				
				info.setForgotpwdid(uuid);
				loginInfoService.updateLoginInfo(info);
				String url = ProjectConfig.url+"/resetPassword?email="+userid+"&token="+uuid;
				System.out.println("url : " + url);
				String subject = "Reset Password from BookStore ";
				String content = "Dear "+ reg.getFirstName()+", <br><br>"
						+ "Please click on link below to reset password <br>"
						+ "<br>"
						+ "<a href='http://"+ url +"'>"+url+"</a>";
				
				boolean status = mailService.sendMail(userid, null, null, subject, content);
				map.addAttribute("resetPwd", "true");
				map.addAttribute("resetMsg", "Password reset link send to your email id. Please reset password from that link !");
				return "forgotPassword";
			}
			map.addAttribute("userid", userid);
			map.addAttribute("resetPwd", "false");
			map.addAttribute("resetMsg", "User id not found !");
			return "forgotPassword";
			
		}
		map.addAttribute("userid", userid);
		map.addAttribute("resetPwd", "false");
		map.addAttribute("resetMsg", "Invalid user id !");
		return "forgotPassword";
		
	}
	
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
	public String resetPassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String email = request.getParameter("email");
		String token = request.getParameter("token");
		if(email != null && email.length() > 0 && token != null && token.length() > 0 )
		{
			LoginInfo info = loginInfoService.getLoginInfoByUserid(email);
			if(info != null && info.getForgotpwdid().equals(token))
			{
				map.addAttribute("email", email);
				map.addAttribute("token", token);
				return "resetPassword";
			}
		}
		return "redirect:forgotPassword";
	}
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String reset_Password(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String new_password = request.getParameter("new_password");
		String conf_password = request.getParameter("conf_password");
		String email = request.getParameter("email");
		String token = request.getParameter("token");
		map.addAttribute("email", email);
		map.addAttribute("token", token);
		map.addAttribute("resetPwd", "false");
		if(new_password != null && conf_password != null && new_password.equals(conf_password))
		{
			if(Validation.validatePassword(new_password))
			{
				if(email != null && email.length() > 0 && token != null && token.length() > 0 )
				{
					LoginInfo info = loginInfoService.getLoginInfoByUserid(email);
					if(info != null && info.getForgotpwdid().equals(token))
					{
						boolean st = loginInfoService.resetPassword(email, new_password); 
						System.out.println("Password reset status : " + st);
						map.remove("email");
						map.remove("token");
						map.addAttribute("resetPwd", "true");
						return "redirect:login";
						
					}
					map.addAttribute("errorMsg", "Invalid User !");
					return "resetPassword";
				}
				map.addAttribute("errorMsg", "Invalid link !");
				return "resetPassword";
			}
			map.addAttribute("errorMsg", "Password not valid, Please use alphanumeric spring");
			return "resetPassword";
		}
		map.addAttribute("errorMsg", "Password not matched");
		return "resetPassword";
	}
	
	
	@RequestMapping(value = "/disableUser", method = RequestMethod.GET)
	@ResponseBody
	public String disableUser(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject obj = new JSONObject();
		
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			LoginInfo info = loginInfoService.getLoginInfoByUserid(empid);
			if(info != null)
			{
				info.setIsActive("false");
				loginInfoService.updateLoginInfo(info);
				obj.put("success", true);
				return obj.toJSONString();
			}
			
		}
		obj.put("success", false);
		return obj.toJSONString();
	}
	
	@RequestMapping(value = "/enableUser", method = RequestMethod.GET)
	@ResponseBody
	public String enableUser(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject obj = new JSONObject();
		
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			LoginInfo info = loginInfoService.getLoginInfoByUserid(empid);
			if(info != null)
			{
				info.setIsActive("true");
				loginInfoService.updateLoginInfo(info);
				obj.put("success", true);
				return obj.toJSONString();
			}
			
		}
		obj.put("success", false);
		return obj.toJSONString();
	}
	
	
}
