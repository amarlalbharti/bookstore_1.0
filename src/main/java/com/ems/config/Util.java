package com.ems.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class Util 
{
	public Date getGMTCurrentDate()
	{
		Calendar calendar = Calendar.getInstance();
		TimeZone tz = calendar.getTimeZone();
		System.out.println(" time zone off set : " + tz.getRawOffset() );
		Date dt = new Date(calendar.getTimeInMillis()-tz.getRawOffset());
		return dt;
	}
	
	public Date getCurrentDate(TimeZone timeZone)
	{
		Calendar calendar = Calendar.getInstance();
		TimeZone tz = calendar.getTimeZone();
		
		long millis = calendar.getTimeInMillis()-tz.getRawOffset();
		
		System.out.println(" time zone off set : " + tz.getRawOffset() );
		Date dt = new Date(millis + timeZone.getRawOffset());
		return dt;
	}
	
	
	public Date getDate(Date date, TimeZone timeZone)
	{
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		TimeZone tz = calendar.getTimeZone();
		
		long millis = calendar.getTimeInMillis()-tz.getRawOffset();
		
		System.out.println(" time zone off set : " + tz.getRawOffset() );
		Date dt = new Date(millis + timeZone.getRawOffset());
		return dt;
	}
	
}
