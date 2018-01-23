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
	@Column(name = "basket_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int basketId;
	
	@Column(name = "quantity", nullable=false)
	private int quantity;
	
	@Column(name = "final_price", nullable=false)
	private double finalPrice;
	
	@Column(name = "modify_date", nullable=false)
	private Date modifyDate; 
	
	@Column(name = "deleted_date")
	private Date deletedDate;
	
	@ManyToOne
	@JoinColumn(name="customer_id", referencedColumnName="rid")
	private Registration registration;

	
	@ManyToOne
	@JoinColumn(name="product_id", referencedColumnName="pid")
	private Product product;

	
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

	public Registration getRegistration()
	{
		return registration;
	}

	public void setRegistration(Registration registration)
	{
		this.registration = registration;
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
