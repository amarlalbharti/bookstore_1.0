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
@Table(name="orderitem")
public class OrderItem
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int orderItemId;
	
	@Column(nullable=false)
	private int quantity;
	
	@Column(nullable=false)
	private double productPrice;
	
	@Column(nullable=false)
	private Date createDate;
	
	@Column
	private Date modifyDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="productId", referencedColumnName="pid")
	private Product product;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="productOrderId", referencedColumnName="productOrderId")
	private ProductOrder productOrder;

	public int getOrderItemId()
	{
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId)
	{
		this.orderItemId = orderItemId;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}

	public double getProductPrice()
	{
		return productPrice;
	}

	public void setProductPrice(double productPrice)
	{
		this.productPrice = productPrice;
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

	public ProductOrder getProductOrder()
	{
		return productOrder;
	}

	public void setProductOrder(ProductOrder productOrder)
	{
		this.productOrder = productOrder;
	}
	
	
	
}
