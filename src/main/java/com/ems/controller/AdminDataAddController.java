package com.ems.controller;

import java.security.Principal;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.config.DateFormats;
import com.ems.domain.Attendance;
import com.ems.domain.Branch;
import com.ems.domain.Country;
import com.ems.domain.Department;
import com.ems.domain.Designation;

import com.ems.domain.Registration;
import com.ems.domain.UserDetail;
import com.ems.domain.UserRole;
import com.ems.model.BranchModel;
import com.ems.model.RegModel;
import com.ems.model.CountryModel;
import com.ems.model.DepartmentModel;
import com.ems.model.DesignationModel;
import com.ems.service.BranchService;
import com.ems.service.CountryService;
import com.ems.service.DepartmentService;
import com.ems.service.DesignationService;
import com.ems.service.LoginInfoService;
import com.ems.service.RegistrationService;

@Controller
public class AdminDataAddController {
	
	@Autowired private RegistrationService registrationService;
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private DepartmentService departmentService;
	@Autowired private DesignationService designationService;
	@Autowired private CountryService countryService;
	@Autowired private BranchService branchService;
	
	@RequestMapping(value = "/adminViewBranch", method = RequestMethod.GET)
	public String viewBranch(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Branch> bList = branchService.getBranchList();
		map.addAttribute("bList", bList);
		return "adminViewBranch";
	}
	
	@RequestMapping(value = "/adminAddBranch", method = RequestMethod.GET)
	public String addBranch(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("Admin add branch Controller Get Method Executed.");
		String branchId = (String)request.getParameter("branchId");
		if(branchId == null)
		{
			map.addAttribute("branchForm", new BranchModel());
			map.addAttribute("cList", countryService.getCountryList());
			return "adminAddBranch";
		}
		else
		{
			Branch branch = branchService.getBranchById(Integer.parseInt(branchId));
			if(branch != null)
			{
				BranchModel model = new BranchModel();
				model.setBranchId(Integer.parseInt(branchId));
				model.setBranchName(branch.getBranchName());
				model.setPhoneNo(branch.getPhoneNo());
				model.setAddress(branch.getAddress());
				model.setPinCode(branch.getPinCode());
				model.setCountry(branch.getCountry());
				model.setTimeZone(branch.getTimeZone());
				
				map.addAttribute("branchId", branchId);
				map.addAttribute("branchForm", model);
				map.addAttribute("cList", countryService.getCountryList());
				return "adminAddBranch";
			}
			else
			{
				return "adminViewBranch";
			}
		}
	}
	
	@RequestMapping(value = "/adminAddBranch", method = RequestMethod.POST)
	public String addBranchP(@ModelAttribute(value = "branchForm") @Valid BranchModel model, BindingResult result,
			@ModelAttribute(value = "branch") @Valid Branch branch, BindingResult branchResult, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors() || model.getCountry().getCountryId() == 0)
		{
			if(model.getCountry().getCountryId() == 0)
			{
				result.addError(new FieldError("branchForm", "country", model.getCountry() , false, new String[1],new String[1], "Please Select Country !"));
			}
			map.addAttribute("cList", countryService.getCountryList());
			System.out.println("in validation");
			return "adminAddBranch";
		}
		else
		{
			int branchId=0;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Branch br = branchService.getBranchById(model.getBranchId());
			if(br != null)
			{
				br.setModifiedDate(dt);
				br.setBranchName(model.getBranchName());
				br.setPhoneNo(model.getPhoneNo());
				br.setAddress(model.getAddress());
				Country country = countryService.getCountryById(model.getCountry().getCountryId());
				br.setCountry(country);
				br.setPinCode(model.getPinCode());
				br.setTimeZone(model.getTimeZone());
				branchId = branchService.updateBranch(br);
				if(branchId > 0)
				{
					map.addAttribute("status", "success_update");
				}
				else
				{
					map.addAttribute("status", "failed");
				}

			}
			else
			{
				branch.setCreateDate(dt);
				Country country = countryService.getCountryById(model.getCountry().getCountryId());
				branch.setCountry(country);
				branchId = branchService.addBranch(branch);
				if(branchId > 0)
				{
					map.addAttribute("status", "success");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			return "redirect:adminViewBranch";
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/adminDeleteBranch", method = RequestMethod.GET)
	@ResponseBody
	public String deleteBranch(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String brid = request.getParameter("brid");
		JSONObject object = new JSONObject();
		if(brid != null)
		{
			Branch br = branchService.getBranchById(Integer.parseInt(brid));
			if(br != null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				br.setModifiedDate(dt);
				br.setDeleteDate(dt);
				branchService.updateBranch(br);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
		
	@RequestMapping(value = "/adminViewCountry", method = RequestMethod.GET)
	public String addAdminCountry(ModelMap map, HttpServletRequest request, Principal principal)
	{
		    String countryId = (String)request.getParameter("countryId");
			map.addAttribute("countryForm", new CountryModel());
			map.addAttribute("cList", countryService.getCountryList());
			map.addAttribute("mode", "add");
		
		if(countryId != null)
		{
			Country country = countryService.getCountryById(Integer.parseInt(countryId));
			if(country != null)
			{
				CountryModel model = new CountryModel();
				
				model.setCountryId(Integer.parseInt(countryId));
				model.setCountryName(country.getCountryName());
				model.setCountryCode(country.getCountryCode());
				map.addAttribute("countryForm", model);
				map.addAttribute("cList", countryService.getCountryList());
				map.addAttribute("mode", "edit");
				return "adminViewCountry";
			}
			else
			{
				return "adminViewCountry";
			}
		}
		return "adminViewCountry";
	}
	
	@RequestMapping(value = "/adminAddCountry", method = RequestMethod.POST)
	public String addCountry(@ModelAttribute(value = "countryForm") @Valid CountryModel model, BindingResult result,
			@ModelAttribute(value = "country") @Valid Country country, BindingResult countryResult, ModelMap map, HttpServletRequest request, Principal principal){
		
		if (result.hasErrors())
		{
			System.out.println("in validation");
			map.addAttribute("cList", countryService.getCountryList());
			return "adminViewCountry";
		}
		else
		{
			
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Country cr = countryService.getCountryById(model.getCountryId());
			if(cr != null)
			{
				cr.setCountryName(model.getCountryName());
				cr.setCountryCode(model.getCountryCode());
				flag = countryService.updateCountry(cr);
				if(flag==true)
				{
					map.addAttribute("status", "updated");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			else
			{
				country.setCreateDate(dt);
				int countryId = countryService.addCountry(country);
				if(countryId > 0)
				{
					map.addAttribute("status", "success");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			return "redirect:adminViewCountry";
		}
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/adminDeleteCountry", method = RequestMethod.GET)
	@ResponseBody
	public String deleteCountry(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String countryId = request.getParameter("countryId");
		JSONObject object = new JSONObject();
		if(countryId != null)
		{
			Country country = countryService.getCountryById(Integer.parseInt(countryId));
			if(country != null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				
				country.setDeleteDate(dt);
				countryService.updateCountry(country);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
		
	@RequestMapping(value = "/adminViewDepartment", method = RequestMethod.GET)
	public String addAdminDepartment(ModelMap map, HttpServletRequest request, Principal principal)
	{
		    String deptId = (String)request.getParameter("departmentId");
			map.addAttribute("depForm", new DepartmentModel());
			map.addAttribute("dList", departmentService.getDepartmentList());
			map.addAttribute("mode", "add");
			
			if(deptId!=null){
			Department department = departmentService.getDepartmentById(Integer.parseInt(deptId));
			if(department != null)
			{
				DepartmentModel model = new DepartmentModel();
				
				model.setDepartmentId(Integer.parseInt(deptId));
				model.setDepartment(department.getDepartment());
				map.addAttribute("depForm", model);
				map.addAttribute("dList", departmentService.getDepartmentList());
				map.addAttribute("mode", "edit");
				return "adminViewDepartment";
			}
			else
			{
				return "adminViewDepartment";
			}
		}
			return "adminViewDepartment";
	}
	
	@RequestMapping(value = "/adminAddDepartment", method = RequestMethod.POST)
	public String addDepartment(@ModelAttribute(value = "depForm") @Valid DepartmentModel model, BindingResult result,
			@ModelAttribute(value = "department") @Valid Department department, BindingResult departmentResult, ModelMap map, HttpServletRequest request, Principal principal){
		if (result.hasErrors())
		{
			map.addAttribute("dList", departmentService.getDepartmentList());
			System.out.println("in validation");
			return "adminViewDepartment";
		}
		else
		{
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Department dept = departmentService.getDepartmentById(model.getDepartmentId());
			if(dept != null)
			{
				
				dept.setDepartment(model.getDepartment());
				
				flag = departmentService.updateDepartment(dept);
				if(flag == true)
				{
					map.addAttribute("status", "updated");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			else
			{
				department.setCreateDate(dt);
				int departmentId = departmentService.addDepartment(department);
				if(departmentId > 0)
				{
					map.addAttribute("status", "success");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			return "redirect:adminViewDepartment";
		}
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/adminDeleteDepartment", method = RequestMethod.GET)
	@ResponseBody
	public String deleteDepartment(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String departmentId = request.getParameter("departmentId");
		JSONObject object = new JSONObject();
		if(departmentId != null)
		{
			Department department = departmentService.getDepartmentById(Integer.parseInt(departmentId));
			if(department != null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				
				department.setDeleteDate(dt);
				departmentService.updateDepartment(department);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}

	
	@RequestMapping(value = "/adminViewDesignation", method = RequestMethod.GET)
	public String addAdminDesignation(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String desgId = (String)request.getParameter("designationId");
		
			 map.addAttribute("desgForm", new DesignationModel());
			 map.addAttribute("dList", designationService.getDesignationList());
			 map.addAttribute("mode", "add");
			 
		if(desgId != null)
		{
			Designation designation = designationService.getDesignationById(Integer.parseInt(desgId));
			if(designation != null)
			{
				DesignationModel model = new DesignationModel();
				model.setDesignationId(Integer.parseInt(desgId));
				model.setDesignation(designation.getDesignation());
				map.addAttribute("desgForm", model);
				map.addAttribute("dList", designationService.getDesignationList());
				map.addAttribute("mode", "edit");
				return "adminViewDesignation";
			}
			else
			{
				return "adminViewDesignation";
			}
			
		}
		return "adminViewDesignation";
	}
	
	@RequestMapping(value = "/adminAddDesignation", method = RequestMethod.POST)
	public String addDesignation(@ModelAttribute(value = "desgForm") @Valid DesignationModel model, BindingResult result,
			@ModelAttribute(value = "designation") @Valid Designation designation, BindingResult designationResult, ModelMap map, HttpServletRequest request, Principal principal){
		if (result.hasErrors())
		{
		    System.out.println("in validation");
		    map.addAttribute("dList", designationService.getDesignationList());
			return "adminViewDesignation";
			
		}
		else
		{
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Designation desg = designationService.getDesignationById(model.getDesignationId());
			if(desg != null)
			{
				
				desg.setDesignation(model.getDesignation());
				
				flag = designationService.updateDesignation(desg);
				if(flag==true)
				{
					map.addAttribute("status", "updated");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			else
			{
				designation.setCreateDate(dt);
				int designationId = designationService.addDesignation(designation);
				if(designationId > 0)
				{
					map.addAttribute("status", "success");
				}
				else
				{
					map.addAttribute("status", "failed");
				}
			}
			return "redirect:adminViewDesignation";
		}
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/adminDeleteDesignation", method = RequestMethod.GET)
	@ResponseBody
	public String deleteDesignation(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String designationId = request.getParameter("designationId");
		JSONObject object = new JSONObject();
		if(designationId != null)
		{
			Designation designation = designationService.getDesignationById(Integer.parseInt(designationId));
			if(designation != null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				
				designation.setDeleteDate(dt);
				designationService.updateDesignation(designation);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}

	

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getBranchNames", method = RequestMethod.GET)
	@ResponseBody
	public String getBranchNames(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject object = new JSONObject();

		String cid = (String)request.getParameter("cid");
		System.out.println("cid : " + cid);
		if(cid != null && cid.length() > 0)
		{
			List<Branch> branch = (List<Branch>)branchService.getBranchByCountryId(Integer.parseInt(cid));
			JSONArray array = new  JSONArray();
			if(branch != null && !branch.isEmpty())
			{
				for(Branch br : branch)
				{
					JSONObject at = new JSONObject();
					at.put("id", br.getBranchId());
					at.put("name", br.getBranchName());
					array.add(at);
				}
			}
			object.put("bList", array);
			object.put("error", false);
			return object.toJSONString();
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
}
