package com.ems.dao;

import java.util.List;

import com.ems.domain.Documents;

public interface DocumentsDao 
{
	public long addDocument(Documents document);
	
	public boolean updateDocument(Documents document);
	
	public Documents getDocumentById(long did);
	
	public List<Documents> getDocumentsByUserId(String userid);
	
	
}
