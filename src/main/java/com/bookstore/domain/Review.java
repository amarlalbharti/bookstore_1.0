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
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int reviewId;
	
	@Column(nullable=false)
	private String customerName;
	
	@Column(nullable=false)
	private int reviewRating;
	
	@Column
	private String reviewText;
	
	@Column(nullable=false)
	private Date createDate;
	
	@Column
	private Date modifyDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="productId", referencedColumnName="pid")
	private Product product;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="customerId", referencedColumnName="customerId")
	private Customer customer;

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

	public Customer getCustomer()
	{
		return customer;
	}

	public void setCustomer(Customer customer)
	{
		this.customer = customer;
	}
	
	
	
	
	
	
	
	
	
}
