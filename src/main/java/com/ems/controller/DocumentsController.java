package com.ems.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ems.config.ProjectConfig;
import com.ems.config.Roles;
import com.ems.domain.Documents;
import com.ems.domain.LoginInfo;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.model.UploadFiles;
import com.ems.service.DocumentsService;
import com.ems.service.LoginInfoService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;

@Controller
public class DocumentsController 
{
	@Autowired private RegistrationService registrationService;
	@Autowired private DocumentsService documentsService;
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private NotificationService notificationService;

	@RequestMapping(value = "/empDocuments", method = RequestMethod.GET)
	public String adminEmpDocuments(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				map.addAttribute("docList", documentsService.getDocumentsByUserId(empid));
				map.addAttribute("empReg", reg);
				return "adminDocuments";
			}
		}
		if(request.isUserInRole(Roles.ROLE_ADMIN.toString()))
		{
			return "redirect:adminEmployees";
		}
		else if(request.isUserInRole(Roles.ROLE_MANAGER.toString()))
		{
			return "redirect:manageremployees";
		}
		else
		{
			return "redirect:error";
		}
		
	}
	
	
	@RequestMapping(value = "/empDocuments", method = RequestMethod.POST)
	public String admin_EmpDocuments(@ModelAttribute UploadFiles uploadFiles, ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			Registration registration = registrationService.getRegistrationByUserid(principal.getName());
			if(reg != null)
			{
				System.out.println("doc_name : " + request.getParameter("doc_name"));
				System.out.println("doc_file : " + uploadFiles.getFile().getOriginalFilename());
				
				String doc_name =  request.getParameter("doc_name");
				String doc_detail =  request.getParameter("doc_detail");
				MultipartFile doc_file = uploadFiles.getFile();
	            if(doc_file != null)
	            {
		            String file_name=doc_file.getOriginalFilename();				            
		            try
		            {
		                if(!(file_name.equals("")))
		                {
		                	file_name=file_name.replace(" ", "-");

		                    File img = new File (ProjectConfig.upload_path+"/"+reg.getUserid()+"/documents/"+file_name);
		                    
		                    if(!img.exists())
		                    {
		                        img.mkdirs();
		                    }
		                    
		                    doc_file.transferTo(img); 
		                    Documents doc = new Documents();
		                    doc.setDocumentName(doc_name);
		                    doc.setDocumentDetail(doc_detail);
		                    doc.setDoc_file(file_name);
		                    doc.setCreateDate(new java.sql.Date(new Date().getTime()));
		                    doc.setReg(reg);
		                    doc.setUploadedBy(principal.getName());
		                    documentsService.addDocument(doc);
		                    
		                    
		                    Notification notification=new Notification();
		    				notification.setType("document");
		    				notification.setNotiMsg(doc_name+" has been uploaded by "+registration.getName());
		    				notification.setNotiId(doc.getDid());
		    				notification.setNotiTo(reg.getUserid());
		    				notificationService.addNotification(notification);
		                    
		                    
		                    map.addAttribute("uf_status", "success");
		                    map.addAttribute("empid", empid);
		                    return "redirect:empDocuments";
		                    
		                }              
		            }
					catch (IOException ie) {
						ie.printStackTrace();
					}
			  }
	            map.addAttribute("uf_status", "failed");
				map.addAttribute("empid", empid);
				return "redirect:empDocuments";
			}
		}
		if(request.isUserInRole(Roles.ROLE_ADMIN.toString()))
		{
			return "redirect:adminEmployees";
		}
		else if(request.isUserInRole(Roles.ROLE_MANAGER.toString()))
		{
			return "redirect:manageremployees";
		}
		else
		{
			return "redirect:error";
		}
	}
	
	
	@RequestMapping(value = "/deleteDocument", method = RequestMethod.GET)
	@ResponseBody
	public String deleteDocument(@ModelAttribute UploadFiles uploadFiles, ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject obj = new JSONObject();
		String did = request.getParameter("did");
		if(did != null && did.length() > 0)
		{
			Documents doc = documentsService.getDocumentById(Long.parseLong(did));
			doc.setDeleteDate(new java.sql.Date(new Date().getTime()));
			boolean st =  documentsService.updateDocument(doc);
			
			Registration registration = registrationService.getRegistrationByUserid(principal.getName());
			 Notification notification=new Notification();
				notification.setType("document");
				notification.setNotiMsg(doc.getDocumentName()+" has been deleted by "+registration.getName());
				notification.setNotiId(Long.parseLong(did));
				notification.setNotiTo(doc.getReg().getUserid());
				notificationService.addNotification(notification);
			
			if(st)
			{
				obj.put("status", true);
				return obj.toJSONString();
			}
		}
		obj.put("status", false);
		return obj.toJSONString();
		
	}
	
	
	
	@RequestMapping(value = "/userDocuments", method = RequestMethod.GET)
	public String userDocuments(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null)
		{
			Registration reg = registrationService.getRegistrationByUserid(principal.getName());
			if(reg != null)
			{
				map.addAttribute("docList", documentsService.getDocumentsByUserId(principal.getName()));
				map.addAttribute("empReg", reg);
				return "userDocuments";
			}
		}
		return "redirect:userDashboard";
		
	}
	
	@RequestMapping(value = "/userDocuments", method = RequestMethod.POST)
	public String userDocuments(@ModelAttribute UploadFiles uploadFiles, ModelMap map, HttpServletRequest request, Principal principal)
	{
		
			Registration reg = registrationService.getRegistrationByUserid(principal.getName());
			if(reg != null)
			{
				System.out.println("doc_name : " + request.getParameter("doc_name"));
				System.out.println("doc_file : " + uploadFiles.getFile().getOriginalFilename());
				
				String doc_name =  request.getParameter("doc_name");
				String doc_detail =  request.getParameter("doc_detail");
				MultipartFile doc_file = uploadFiles.getFile();
	            if(doc_file != null)
	            {
		            String file_name=doc_file.getOriginalFilename();				            
		            try
		            {
		                if(!(file_name.equals("")))
		                {
		                	file_name=file_name.replace(" ", "-");

		                    File img = new File (ProjectConfig.upload_path+"/"+reg.getUserid()+"/documents/"+file_name);
		                    
		                    if(!img.exists())
		                    {
		                        img.mkdirs();
		                    }
		                    
		                    doc_file.transferTo(img); 
		                    Documents doc = new Documents();
		                    doc.setDocumentName(doc_name);
		                    doc.setDocumentDetail(doc_detail);
		                    doc.setDoc_file(file_name);
		                    doc.setUploadedBy(principal.getName());
		                    doc.setCreateDate(new java.sql.Date(new Date().getTime()));
		                    doc.setReg(reg);
		                    documentsService.addDocument(doc);
		                    
		                    map.addAttribute("uf_status", "success");
		                    
		                    return "redirect:userDocuments";
		                    
		                }              
		            }
					catch (IOException ie) {
						ie.printStackTrace();
					}
			  }
			}
			map.addAttribute("uf_status", "failed");
			return "redirect:userDocuments";
		
	}
	
}
