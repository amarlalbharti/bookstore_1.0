package com.bookstore.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

public class DateUtils
{
	/**
	 *  SimpleDateFormat for format dd-MM-yyyy
	 */
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	
	public static SimpleDateFormat clientDateFormat = new SimpleDateFormat("MMM dd, yyyy");
	public static SimpleDateFormat fullFormat = new SimpleDateFormat("dd-MM-yyyy 'at' hh:mm a");
	public static SimpleDateFormat clientFullformat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
	
	public static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	
	public static String getWorkingHours(Date sdate, Date edate)
	{
		String res = "";
		if(sdate != null && edate != null)
		{
			if(sdate.before(edate))
			{
				long time = edate.getTime()-sdate.getTime();
				if(time > 0)
				{
					long hours = time/(60*60*1000);
					time = time%(60*60*1000);
					
					long mins = time/(60*1000);
					if(hours < 10)
					{
						res += "0"+hours;
					}
					else
					{
						res += hours;
					}
					res += " : ";
					if(mins < 10)
					{
						res += "0"+mins;
					}
					else
					{
						res += mins;
					}
					
					res += " Hours";
					return res;
				}
				else
				{
					res += "NA";
				}
			}
		}
		return "NA";
	}
	
	public static String getDayName(int day)
	{
		String dayname = "";
		switch (day) {
		case 1:
			dayname = "SUNDAY";
			break;
		case 2:
			dayname = "MONDAY";
			break;
		case 3:
			dayname = "TUESDAY";
			break;
		case 4:
			dayname = "WEDNESDAY";
			break;
		case 5:
			dayname = "THURSDAY";
			break;
		case 6:
			dayname = "FRIDAY";
			break;
		case 7:
			dayname = "SATURDAY";
			break;

		default:
			dayname = "NA";
			break;
		}
		
		return dayname;
	}
}
