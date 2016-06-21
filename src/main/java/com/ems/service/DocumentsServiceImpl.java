package com.ems.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.DocumentsDao;
import com.ems.domain.Documents;

@Service
@Transactional
public class DocumentsServiceImpl implements DocumentsService
{
	@Autowired private DocumentsDao documentsDao;
	
	public long addDocument(Documents document)
	{
		return this.documentsDao.addDocument(document);
	}
	public boolean updateDocument(Documents document)
	{
		return this.documentsDao.updateDocument(document);
	}
	
	public Documents getDocumentById(long did)
	{
		return this.documentsDao.getDocumentById(did);
	}
	
	public List<Documents> getDocumentsByUserId(String userid)
	{
		return this.documentsDao.getDocumentsByUserId(userid);
	}

}
