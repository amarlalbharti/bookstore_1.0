package com.ems.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import com.ems.domain.Attendance;

public class DateFormats
{
	static
	{
		TimeZone.setDefault(TimeZone.getTimeZone("GMT"));
	}
	
	
	public Date getDate(TimeZone tz)
	{
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MILLISECOND, tz.getRawOffset());
		return cal.getTime();
	}
	
	public Date getGMTDate()
	{
		Calendar cal = Calendar.getInstance();
		return cal.getTime();
	}
	
	
	
	public static SimpleDateFormat ddMMyyyy()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		return df;
	}
	
	
	public static SimpleDateFormat ddMMMyyyy()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");
		return df;
	}
	
	
	public static SimpleDateFormat fullformat()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd MM yyyy 'at' hh:mm a");
		return df;
	}
	
	
	public static SimpleDateFormat fullformat2()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
		return df;
	}
	
	
	public static SimpleDateFormat timeformat()
	{
		SimpleDateFormat df = new SimpleDateFormat("hh:mm a");
		return df;
	}
	
	
	public static SimpleDateFormat monthformat()
	{
		SimpleDateFormat df = new SimpleDateFormat("MM-yyyy");
		return df;
	}
	
	
	public static SimpleDateFormat MMMformat()
	{
		SimpleDateFormat df = new SimpleDateFormat("MMM yyyy");
		return df;
	}
	
	
	public static SimpleDateFormat yyyyMMdd()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df;
	}
	
	
	
	
	public static SimpleDateFormat ddMMyyyy(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat ddMMMyyyy(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat fullformat(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy 'at' hh:mm a");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat fullformat2(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat timeformat(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("hh:mm a");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat monthformat(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("MM-yyyy");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat MMMformat(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("MMM yyyy");
		df.setTimeZone(timezone);
		return df;
	}
	
	public static SimpleDateFormat yyyyMMdd(TimeZone timezone)
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		df.setTimeZone(timezone);
		return df;
	}
	
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
	
	public static String getWorkingHours(List<Attendance> atList)
	{
		String res = "";
		if(atList != null &&  !atList.isEmpty())
		{
			long time = 0;
			for(Attendance at : atList)
			{
				if(at.getInTime() != null && at.getOutTime() != null)
				{
					if(at.getInTime().before(at.getOutTime()))
					{
						time += at.getOutTime().getTime()-at.getInTime().getTime();
					}
				}
				
			}
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
