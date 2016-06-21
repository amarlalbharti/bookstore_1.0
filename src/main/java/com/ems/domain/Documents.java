package com.ems.domain;

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
@Table(name="documents")
public class Documents implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7501008395031795817L;

	
	private long did;
	
	private String documentName;
	
	private String documentDetail;
	
	private String doc_file;
	
	private Date createDate;
	
	private Date deleteDate;
	
	private Registration reg;
	
	private String uploadedBy;
	

	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getDid() {
		return did;
	}

	public void setDid(long did) {
		this.did = did;
	}

	@Column(nullable=false)
	public String getDocumentName() {
		return documentName;
	}


	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	@Column
	public String getDocumentDetail() {
		return documentDetail;
	}

	public void setDocumentDetail(String documentDetail) {
		this.documentDetail = documentDetail;
	}

	@Column(nullable=false)
	public String getDoc_file() {
		return doc_file;
	}

	public void setDoc_file(String doc_file) {
		this.doc_file = doc_file;
	}

	@Column(nullable=false)
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}

	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="reg_id", referencedColumnName="lid")
	public Registration getReg() {
		return reg;
	}

	public void setReg(Registration reg) {
		this.reg = reg;
	}

	@Column(nullable=false)
	public String getUploadedBy() {
		return uploadedBy;
	}

	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}
	
	
}
