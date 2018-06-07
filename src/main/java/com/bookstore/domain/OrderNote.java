package com.bookstore.domain;

import java.io.Serializable;
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
@Table(name="order_note")
public class OrderNote implements Serializable
{
	@Id
	@Column(name = "order_note_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int orderNoteId;
	
	@Column(name = "note" , nullable=false)
	private String note;
	
	@Column(name = "show_to_customer" , nullable=false)
	private Boolean showToCustomer;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "delete_date")
	private Date deleteDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="product_order_id", referencedColumnName="product_order_id")
	private ProductOrder productOrder;

	public int getOrderNoteId()
	{
		return orderNoteId;
	}

	public void setOrderNoteId(int orderNoteId)
	{
		this.orderNoteId = orderNoteId;
	}

	public String getNote()
	{
		return note;
	}

	public void setNote(String note)
	{
		this.note = note;
	}

	public Boolean getShowToCustomer()
	{
		return showToCustomer;
	}

	public void setShowToCustomer(Boolean showToCustomer)
	{
		this.showToCustomer = showToCustomer;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Date getDeleteDate()
	{
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate)
	{
		this.deleteDate = deleteDate;
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
