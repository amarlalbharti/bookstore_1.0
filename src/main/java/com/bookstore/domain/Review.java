package com.bookstore.domain;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="reviews")
public class Review
{
	@Id
	@Column(name = "review_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int reviewId;
	
	@Column(name = "customer_name", nullable=false)
	private String customerName;
	
	@Column(name = "review_rating", nullable=false)
	private int reviewRating;
	
	@Column(name = "review_text")
	private String reviewText;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "modify_date")
	private Date modifyDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="product_id", referencedColumnName="pid")
	private Product product;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="user_id", referencedColumnName="rid")
	private Registration registration;

	public int getReviewId()
	{
		return reviewId;
	}

	public void setReviewId(int reviewId)
	{
		this.reviewId = reviewId;
	}

	public String getCustomerName()
	{
		return customerName;
	}

	public void setCustomerName(String customerName)
	{
		this.customerName = customerName;
	}

	public int getReviewRating()
	{
		return reviewRating;
	}

	public void setReviewRating(int reviewRating)
	{
		this.reviewRating = reviewRating;
	}

	public String getReviewText()
	{
		return reviewText;
	}

	public void setReviewText(String reviewText)
	{
		this.reviewText = reviewText;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Date getModifyDate()
	{
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate)
	{
		this.modifyDate = modifyDate;
	}

	public Product getProduct()
	{
		return product;
	}

	public void setProduct(Product product)
	{
		this.product = product;
	}

	public Registration getRegistration()
	{
		return registration;
	}

	public void setRegistration(Registration registration)
	{
		this.registration = registration;
	}

	
	
	
	
	
	
	
	
}
