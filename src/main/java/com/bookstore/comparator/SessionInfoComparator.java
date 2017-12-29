package com.bookstore.comparator;

import java.util.Comparator;

import org.springframework.security.core.session.SessionInformation;

public class SessionInfoComparator implements Comparator<SessionInformation>
{

	public int compare(SessionInformation s1, SessionInformation s2)
	{
		return s2.getLastRequest().compareTo(s1.getLastRequest());
	}

}
