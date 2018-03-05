package com.bookstore.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.domain.City;
import com.bookstore.service.CityService;

@Controller
public class CityController
{
	@Autowired
	private CityService cityService; 
	
	@RequestMapping(value = "search/ceties", method = RequestMethod.GET)
	public @ResponseBody String getCitiesList(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject response = new JSONObject();
		JSONArray array = new JSONArray();
		String text = request.getParameter("search");
		if(text != null && text.trim().length() > 0 ) {
			List<City> list = this.cityService.searchCity(text.trim());
			for(City city : list) {
				JSONObject json = new JSONObject();
				json.put("id", city.getCityId());
				json.put("text", city.getCityName());
				array.add(json);
			}
		}
		response.put("results", array);
		JSONObject pagination = new JSONObject();
		pagination.put("more", false);
		response.put("pagination", pagination);
		return response.toJSONString();
	}
}
