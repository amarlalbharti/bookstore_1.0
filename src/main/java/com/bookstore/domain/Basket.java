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
@Table(name="basket")
public class Basket
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int basketId;
	
	@Column(nullable=false)
	private int quantity;
	
	@Column(nullable=false)
	private double finalPrice;
	
	@Column(nullable=false)
	private Date modifyDate; 
	
	@Column
	private Date deletedDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="customerId", referencedColumnName="customerId")
	private Customer customer;

	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="productId", referencedColumnName="pid")
	private Product Product;

	
	public int getBasketId()
	{
		return basketId;
	}

	public void setBasketId(int basketId)
	{
		this.basketId = basketId;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}

	public double getFinalPrice()
	{
		return finalPrice;
	}

	public void setFinalPrice(double finalPrice)
	{
		this.finalPrice = finalPrice;
	}

	public Date getDeletedDate()
	{
		return deletedDate;
	}

	public void setDeletedDate(Date deletedDate)
	{
		this.deletedDate = deletedDate;
	}

	public Date getModifyDate()
	{
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate)
	{
		this.modifyDate = modifyDate;
	}

	public Customer getCustomer()
	{
		return customer;
	}

	public void setCustomer(Customer customer)
	{
		this.customer = customer;
	}

	public Product getProduct()
	{
		return Product;
	}

	public void setProduct(Product product)
	{
		Product = product;
	}
	
	
}
