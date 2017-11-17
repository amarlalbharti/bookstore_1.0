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
@Table(name="order_item")
public class OrderItem
{
	@Id
	@Column(name = "order_item_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int orderItemId;
	
	@Column(name = "quantity", nullable=false)
	private int quantity;
	
	@Column(name = "product_price", nullable=false)
	private double productPrice;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "modify_date")
	private Date modifyDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="product_id", referencedColumnName="pid")
	private Product product;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="product_order_id", referencedColumnName="product_order_id")
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
