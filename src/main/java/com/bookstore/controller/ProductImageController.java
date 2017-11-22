package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Product;
import com.bookstore.domain.ProductImage;
import com.bookstore.service.ProductImageService;
import com.bookstore.service.ProductService;

@Controller
public class ProductImageController
{
	@Autowired private ProductService productService; 
	@Autowired private ProductImageService productImageService; 
	
	
	@RequestMapping(value = "/getProductImages")
    public String getProductImages(ModelMap map, HttpServletRequest request, Principal principal)
    {
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				List<ProductImage> productImages = productImageService.getProductImageByProductId(Util.getNumeric(pid));
				map.addAttribute("productImages", productImages);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "productCategosies";
    }
	

	@RequestMapping(value = "/profileImageUpld")
    public @ResponseBody String ajaxFileUpload(MultipartHttpServletRequest request, HttpServletRequest req, Principal principal)throws ServletException, IOException
    {   
		if(principal != null)
		{
			MultipartFile mpf = null;
			int flag=0;
			Iterator<String> itr=request.getFileNames();
			while(itr.hasNext()){
			mpf=request.getFile(itr.next());
			flag++;
	        boolean isMultipart=ServletFileUpload.isMultipartContent(request);
	        System.out.println("is file " + isMultipart + " file name " + mpf.getOriginalFilename());
			}
			if(flag > 0 && mpf != null && mpf.getOriginalFilename() != null && mpf.getOriginalFilename() != "")
			{
				String filename=null;
				filename=mpf.getOriginalFilename().replace(" ", "-");
				File dl = new File(ProjectConfig.UPLOAD_PATH+"/product/"+filename);
		    	System.out.println("PATH="+dl.getAbsolutePath());
			    if(!dl.exists()){
			    	System.out.println("in not file"+dl.getAbsolutePath());
				    dl.mkdirs();
			    }
				mpf.transferTo(dl);
				System.out.println("multiple images uploaded");
				return "success";
			}
		}
		return "failed";
    }
	
}
