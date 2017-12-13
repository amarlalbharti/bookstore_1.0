package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONObject;
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
	
	
	@RequestMapping(value = "admin/getProductImages")
    public String getProductImages(ModelMap map, HttpServletRequest request, Principal principal)
    {
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				List<ProductImage> productImages = productImageService.getProductImageByProductId(Util.getNumeric(pid));
				map.addAttribute("productImages", productImages);
				map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
				String imageId = request.getParameter("imageId");
				if(Validation.isNumeric(imageId)) {
					map.addAttribute("editImage", productImageService.getProductImageById(Util.getNumeric(imageId)));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "productImages";
    }
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/deleteProductImage")
    public @ResponseBody String deleteProductImage(ModelMap map, HttpServletRequest request, Principal principal)
    {
		JSONObject json = new JSONObject();
		try{
			String imageId = request.getParameter("imageId");
			if(Validation.isNumeric(imageId)){
				ProductImage image = productImageService.getProductImageById(Util.getNumeric(imageId));
				if(image != null) {
					List<Integer> list = new ArrayList();
					list.add(Util.getNumeric(imageId));
					if(productImageService.deleteProductImage(list) > 0) {
						productImageService.setProductImage(image.getProduct().getPid());
						json.put("status", "success");
						json.put("msg", "Picture deleted successfully !");
						return json.toJSONString();
					}
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		json.put("status", "error");
		json.put("msg", "Opps something wrong !");
		return json.toJSONString();
    }
	

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/profileImageUpld")
    public @ResponseBody String ajaxFileUpload(MultipartHttpServletRequest request, HttpServletRequest req, Principal principal)throws ServletException, IOException
    {   
		String pid = req.getParameter("pid");
		String imageId = req.getParameter("imageId");
		String imageName = req.getParameter("imageName");
		String imageAlt = req.getParameter("imageAlt");
		String imageDetail = req.getParameter("imageDetail");
		String imageOrder = req.getParameter("imageOrder");
		JSONObject json = new JSONObject();
		boolean valid = true;
		if(imageName == null || imageName.trim().equals("")) {
			json.put("msg", "Picture name is required !");
			valid = false;
		}
		if(imageOrder == null || imageOrder.trim().equals("") || !Validation.isNumeric(imageOrder)) {
			json.put("msg", "Picture name is required !");
			valid = false;
		}
		Product product = null;
		if(pid == null || pid.trim().equals("") || pid.trim().equals("0")) {
			json.put("msg", "Product not saved !");
			valid = false;
		}else {
			product = productService.getProductById(Util.getNumeric(pid));
			if(product== null){
				json.put("msg", "Product not found !");
				valid = false;
			}
		}
		if(!valid) {
			json.put("status", "error");
			return json.toJSONString();
		}
		if(imageId == null || !Validation.isNumeric(imageId)) {
			MultipartFile mpf = null;
			int flag=0;
			Iterator<String> itr=request.getFileNames();
			while (itr.hasNext()){
				mpf = request.getFile(itr.next());
				flag++;
				boolean isMultipart = ServletFileUpload.isMultipartContent(request);
				System.out.println("is file " + isMultipart + " file name " + mpf.getOriginalFilename());
			}
			if(flag > 0 && mpf != null && mpf.getOriginalFilename() != null && mpf.getOriginalFilename() != "") {
				
				if(!Validation.isImageExtention(mpf.getOriginalFilename())) {
					json.put("msg", "Image Extension not allowed !");
					return json.toJSONString();
				}
				String filename=UUID.randomUUID().toString();
				String imagepath = "products/"+product.getPid()+"/"+filename+"."+FilenameUtils.getExtension(mpf.getOriginalFilename());
				File dl = new File(ProjectConfig.UPLOAD_PATH+""+imagepath);
		    	System.out.println("PATH="+dl.getAbsolutePath());
			    if(!dl.exists()){
			    	System.out.println("in not file"+dl.getAbsolutePath());
				    dl.mkdirs();
			    }
				mpf.transferTo(dl);
				ProductImage productImage = new ProductImage();
				productImage.setImageName(imageName);
				productImage.setImageAlt(imageAlt);
				productImage.setImageDesc(imageDetail);
				productImage.setImageOrder(Util.getNumeric(imageOrder));
				productImage.setImageURL(imagepath);
				productImage.setCreateDate(new Date());
				productImage.setProduct(product);
				productImageService.addProductImage(productImage);
				productImageService.setProductImage(product.getPid());
				json.put("status", "success");
				
			}
		}else {
			ProductImage productImage = productImageService.getProductImageById(Util.getNumeric(imageId));
			productImage.setImageName(imageName);
			productImage.setImageAlt(imageAlt);
			productImage.setImageDesc(imageDetail);
			productImage.setImageOrder(Util.getNumeric(imageOrder));
			productImageService.updateProductImage(productImage);
			productImageService.setProductImage(product.getPid());
			json.put("status", "success");
		}
		
		return json.toJSONString();
    }
	
}
