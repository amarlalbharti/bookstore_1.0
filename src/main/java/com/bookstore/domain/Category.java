package com.bookstore.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/*import org.apache.solr.analysis.LowerCaseFilterFactory;
import org.apache.solr.analysis.SnowballPorterFilterFactory;
import org.apache.solr.analysis.StandardTokenizerFactory;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.AnalyzerDef;
import org.hibernate.search.annotations.DateBridge;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Parameter;
import org.hibernate.search.annotations.Resolution;
import org.hibernate.search.annotations.Store;
import org.hibernate.search.annotations.TokenFilterDef;
import org.hibernate.search.annotations.TokenizerDef;
*/
@Entity
@Table(name="category")
//@Indexed
//@AnalyzerDef(name = "customanalyzer",tokenizer =@TokenizerDef(factory = StandardTokenizerFactory.class),
//filters = {
//@TokenFilterDef(factory = LowerCaseFilterFactory.class),
//@TokenFilterDef(factory = SnowballPorterFilterFactory.class, params = {
//	@Parameter(name = "language", value = "English")
//  })
//})
public class Category
{
	
	@Id
	@Column(name = "cid", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int cid;
	
	@Column(name = "category_name", nullable=false, unique=true)
	private String categoryName;
	
	@Column(name = "category_detail", nullable=false)
	private String categoryDetail;
	
	@Column(name = "category_image")
	private String categoryImage;
	
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "modify_date")
	private Date modifyDate;
	
	@Column(name = "delete_date")
	private Date deleteDate;
	
	@Column(name = "active", nullable=false)
	private boolean active;
	
	@Column(name = "display_order", nullable=false)
	private int displayOrder;

	@Column(name = "created_by")
	private String createdBy;

	@Column(name = "modify_by")
	private String modifyBy;

	@ManyToOne 
    @JoinColumn(name = "parent_id")
	private Category parent;

	@OneToMany(mappedBy="parent", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<Category> childCategories = new HashSet();
	
	@ManyToMany(mappedBy="categories", fetch = FetchType.LAZY)
	private Set<Product> products = new HashSet();

	
	public int getCid()
	{
		return cid;
	}

	public void setCid(int cid)
	{
		this.cid = cid;
	}

	public String getCategoryName()
	{
		return categoryName;
	}

	public void setCategoryName(String categoryName)
	{
		this.categoryName = categoryName;
	}
	
	public String getCategoryDetail()
	{
		return categoryDetail;
	}

	public void setCategoryDetail(String categoryDetail)
	{
		this.categoryDetail = categoryDetail;
	}

	public String getCategoryImage()
	{
		return categoryImage;
	}

	public void setCategoryImage(String categoryImage)
	{
		this.categoryImage = categoryImage;
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

	
	public Date getDeleteDate()
	{
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate)
	{
		this.deleteDate = deleteDate;
	}

	public boolean isActive()
	{
		return active;
	}

	public void setActive(boolean active)
	{
		this.active = active;
	}

	public int getDisplayOrder()
	{
		return displayOrder;
	}

	public void setDisplayOrder(int displayOrder)
	{
		this.displayOrder = displayOrder;
	}

	public Category getParent()
	{
		return parent;
	}

	public void setParent(Category parent)
	{
		this.parent = parent;
	}

	
	public Set<Category> getChildCategories()
	{
		return childCategories;
	}

	public void setChildCategories(Set<Category> childCategories)
	{
		this.childCategories = childCategories;
	}

	public Set<Product> getProducts()
	{
		return products;
	}

	public void setProducts(Set<Product> products)
	{
		this.products = products;
	}

	public String getCreatedBy()
	{
		return createdBy;
	}

	public void setCreatedBy(String createdBy)
	{
		this.createdBy = createdBy;
	}

	public String getModifyBy()
	{
		return modifyBy;
	}

	public void setModifyBy(String modifyBy)
	{
		this.modifyBy = modifyBy;
	}

	
	
	
}
