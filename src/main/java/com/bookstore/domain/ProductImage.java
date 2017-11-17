package com.bookstore.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="product_image")
public class ProductImage
{
	@Id
	@Column(name = "image_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int imageId;
	
	@Column(name = "image_name", nullable=false)
	private String imageName;
	
	@Column(name = "image_url", nullable=false)
	private String imageURL;
	
	@Column(name = "image_alt")
	private String imageAlt;
	
	@Column(name = "image_desc")
	private String imageDesc;
	
	@Column(name = "image_order", nullable = false)
	private int imageOrder;
	
	@Column(name = "create_date", nullable=false)
	public Date createDate;
	
	@ManyToOne 
    @JoinColumn(name = "pid")
	public Product product;

	public int getImageId()
	{
		return imageId;
	}

	public void setImageId(int imageId)
	{
		this.imageId = imageId;
	}

	public String getImageName()
	{
		return imageName;
	}

	public void setImageName(String imageName)
	{
		this.imageName = imageName;
	}

	public String getImageURL()
	{
		return imageURL;
	}

	public void setImageURL(String imageURL)
	{
		this.imageURL = imageURL;
	}

	public String getImageAlt()
	{
		return imageAlt;
	}

	public void setImageAlt(String imageAlt)
	{
		this.imageAlt = imageAlt;
	}

	public String getImageDesc()
	{
		return imageDesc;
	}

	public void setImageDesc(String imageDesc)
	{
		this.imageDesc = imageDesc;
	}

	public int getImageOrder()
	{
		return imageOrder;
	}

	public void setImageOrder(int imageOrder)
	{
		this.imageOrder = imageOrder;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Product getProduct()
	{
		return product;
	}

	public void setProduct(Product product)
	{
		this.product = product;
	}
	
	
}
