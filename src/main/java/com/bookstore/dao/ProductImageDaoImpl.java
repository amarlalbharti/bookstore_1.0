package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.ProductImage;

@Repository
public class ProductImageDaoImpl implements ProductImageDao
{
	@Autowired private SessionFactory sessionFactory;
	
	
	public int addProductImage(ProductImage productImage)
	{
		try{
			this.sessionFactory.getCurrentSession().save(productImage);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return productImage.getImageId();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	public boolean updateProductImage(ProductImage productImage)
	{
		try{
			this.sessionFactory.getCurrentSession().update(productImage);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public ProductImage getProductImageById(int imageId)
	{
		try{
			return (ProductImage)this.sessionFactory.getCurrentSession().get(ProductImage.class, imageId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<ProductImage> getProductImageByProductId(int productId)
	{
		try{
			return this.sessionFactory.getCurrentSession().createCriteria(ProductImage.class)
					.add(Restrictions.eq("product.pid", productId))
					.addOrder(Order.asc("imageOrder"))
					.list();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

}
