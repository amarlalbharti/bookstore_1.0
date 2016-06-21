package com.ems.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ems.config.DateFormats;
import com.ems.domain.Attendance;
import com.ems.domain.LeaveDetail;
import com.ems.domain.Registration;
import com.ems.service.AttendanceService;
import com.ems.service.BranchService;
import com.ems.service.CountryService;
import com.ems.service.DepartmentService;
import com.ems.service.DesignationService;
import com.ems.service.LeaveService;
import com.ems.service.LoginInfoService;
import com.ems.service.RegistrationService;
import com.ems.service.UserRoleService;

@Controller
public class ReportController 
{
	@Autowired private LeaveService leaveService;
	@Autowired private RegistrationService registrationService;
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private AttendanceService attendanceService; 
	@Autowired private DepartmentService departmentService;
	@Autowired private DesignationService designationService;
	@Autowired private UserRoleService userRoleService;
	@Autowired private CountryService countryService;
	@Autowired private BranchService branchService;
	
	@RequestMapping(value = "/secureReport", method = RequestMethod.GET)
	public String secureleavesdash(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("Sunday : " + Calendar.SUNDAY);
		map.addAttribute("countryList", countryService.getCountryList());
		return "reportData";
	}
	
	@RequestMapping(value = "/secureReportExport", method = RequestMethod.POST)
	public String secureReportExport(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		String dfilter = request.getParameter("dfilter");
		String empfilter = request.getParameter("empfilter");
		System.out.println(dfilter + " vs. " + empfilter);
		List<Registration> regList = null;
		
		
		if(empfilter != null && empfilter.equalsIgnoreCase("filter"))
		{
			String country = request.getParameter("country");
			String branch = request.getParameter("branch");
			if(branch != null && !branch.equals("0"))
			{
				regList = registrationService.getEmpRegistrationListByBranch(Integer.parseInt(branch));
			}
			else if(country != null && !country.equals("0"))
			{
				regList = registrationService.getEmpRegistrationListByCountry(Integer.parseInt(country));
			}
		}
		else
		{
			regList = registrationService.getEmpRegistrationList();
		}
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Attendance Report");
		
			Date sdate = null;
			Date edate = null;
			if(dfilter != null && dfilter.equalsIgnoreCase("filter"))
			{
				String s_date =  request.getParameter("sdate");
				String e_date =  request.getParameter("edate");
				System.out.println(s_date+ " vs. " + e_date);
				try 
				{
					sdate = DateFormats.ddMMyyyy().parse(s_date);
					edate = DateFormats.ddMMyyyy().parse(e_date);
					Calendar calendar =   Calendar.getInstance();
					calendar.setTime(sdate);
					calendar.set(Calendar.HOUR_OF_DAY, 0);
					calendar.set(Calendar.MINUTE, 0);
					calendar.set(Calendar.SECOND, 0);
					calendar.set(Calendar.MILLISECOND, 0);
					
					sdate = calendar.getTime();
					
					calendar.setTime(edate);
					calendar.set(Calendar.HOUR_OF_DAY, 0);
					calendar.set(Calendar.MINUTE, 0);
					calendar.set(Calendar.SECOND, 0);
					calendar.set(Calendar.MILLISECOND, 0);
					
					edate = calendar.getTime();
					
					
				}
				catch (Exception e) 
				{
					e.printStackTrace();
					map.addAttribute("status", "failed");
					map.addAttribute("msg", "date parsing error !");
					return "redirect:secureReport";
				}
				
				
			}
			else
			{
				Calendar calendar =   Calendar.getInstance();
				
				edate = calendar.getTime();
				
				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);
				calendar.set(Calendar.MILLISECOND, 0);
				calendar.set(Calendar.DATE, 1);
				sdate = calendar.getTime();
			}
			
			int rowCount = 2;
			
			
			// Create row object
			XSSFFont font = workbook.createFont();
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			XSSFCellStyle style = workbook.createCellStyle();
			style.setFont(font);
			
			XSSFRow row = sheet.createRow(rowCount++);
			Cell cell1 = row.createCell(0);
			cell1.setCellStyle(style);
			cell1.setCellValue("Attendance Report");
			
			row = sheet.createRow(rowCount++);
			cell1 = row.createCell(0);
			cell1.setCellStyle(style);
			cell1.setCellValue("From : "+DateFormats.ddMMMyyyy().format(sdate) + " to : "+ DateFormats.ddMMMyyyy().format(edate));
			
			
			row = sheet.createRow(rowCount++);
			
			
			// Write the workbook in file system
			font = workbook.createFont();
//			font.setBold(true);
			font.setFontHeightInPoints((short) 12);
			
			XSSFCellStyle style1 = workbook.createCellStyle();
			style1.setFont(font);
			style1.setAlignment(HorizontalAlignment.CENTER);
			style1.setVerticalAlignment(VerticalAlignment.CENTER);
			style1.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
			style1.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
			style1.setBorderBottom(CellStyle.BORDER_THIN);
			style1.setBorderTop(CellStyle.BORDER_THIN);
			style1.setBorderLeft(CellStyle.BORDER_THIN);
			style1.setBorderRight(CellStyle.BORDER_THIN);
			
			
			XSSFCellStyle style2 = workbook.createCellStyle();
			style2.setAlignment(HorizontalAlignment.CENTER);
			style2.setVerticalAlignment(VerticalAlignment.CENTER);
			style2.setFillForegroundColor(IndexedColors.RED.getIndex());
			style2.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
			style2.setBorderBottom(CellStyle.BORDER_THIN);
			style2.setBorderTop(CellStyle.BORDER_THIN);
			style2.setBorderLeft(CellStyle.BORDER_THIN);
			style2.setBorderRight(CellStyle.BORDER_THIN);
			
			
			XSSFCellStyle woStyle = workbook.createCellStyle();
			woStyle.setAlignment(HorizontalAlignment.CENTER);
			woStyle.setVerticalAlignment(VerticalAlignment.CENTER);
			woStyle.setFillForegroundColor(IndexedColors.PINK.getIndex());
			woStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
			woStyle.setBorderBottom(CellStyle.BORDER_THIN);
			woStyle.setBorderTop(CellStyle.BORDER_THIN);
			woStyle.setBorderLeft(CellStyle.BORDER_THIN);
			woStyle.setBorderRight(CellStyle.BORDER_THIN);
			
			
			int cellCount = 0;
			int headerRow = rowCount;
			row = sheet.createRow(rowCount++);
			XSSFRow row1 = sheet.createRow(rowCount++);
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Employee Name");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Location");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Week Off");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Leave");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Absent");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			cell1 = row.createCell(cellCount);
			cell1.setCellStyle(style1);
			cell1.setCellValue("Week off's");
			cell1 = row1.createCell(cellCount++);
			cell1.setCellStyle(style1);
			sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-1, cellCount-1, cellCount-1));
			
			Calendar scal = Calendar.getInstance();
			scal.setTime(sdate);
			
			Calendar ecal = Calendar.getInstance();
			ecal.setTime(edate);
			ecal.set(Calendar.HOUR_OF_DAY, 23);
			ecal.set(Calendar.MINUTE, 59);
			ecal.set(Calendar.SECOND, 59);
			ecal.set(Calendar.MILLISECOND, 0);
			
			
			while(scal.before(ecal))
			{
				cell1 = row.createCell(cellCount);
				cell1.setCellStyle(style1);
				cell1.setCellValue(DateFormats.ddMMMyyyy().format(scal.getTime()));
				
				cell1 = row1.createCell(cellCount++);
				cell1.setCellStyle(style1);
				cell1.setCellValue("Login");
				
				cell1 = row.createCell(cellCount);
				cell1.setCellStyle(style1);
				cell1 = row1.createCell(cellCount++);
				cell1.setCellStyle(style1);
				cell1.setCellValue("Logout");
				
				cell1 = row.createCell(cellCount);
				cell1.setCellStyle(style1);
				cell1 = row1.createCell(cellCount++);
				cell1.setCellStyle(style1);
				cell1.setCellValue("Work Hours");
				
				sheet.addMergedRegion(new CellRangeAddress(rowCount-2, rowCount-2, cellCount-3, cellCount-1));

				scal.add(Calendar.DATE, 1);
			}
			
			
			if(regList != null && !regList.isEmpty())
			{
				System.out.println(sdate + " : " + edate);
				for(Registration reg : regList)
				{
					int totalWeekOffs = 0;
					int totalAbsents = 0;
					int totalLeaves = 0;
					
					
					scal.setTime(sdate);
					cellCount = 0;
					
					row = sheet.createRow(rowCount++);
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(reg.getName());
					
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(reg.getBranch().getCountry().getCountryName());
					
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(DateFormats.getDayName(reg.getWeekOff()));
					
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(0);//CellValue("Leave");
					
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(0);//cell1.setCellValue("Absent");
					
					cell1 = row.createCell(cellCount++);
					cell1.setCellValue(0);//cell1.setCellValue("Week off's");
					
					
					List<LeaveDetail> leaves = leaveService.getLeaveBetweenTwoDates(reg.getUserid(), scal.getTime(), ecal.getTime());
					if(leaves != null && !leaves.isEmpty())
					{
						
						for(LeaveDetail leave : leaves)
						{
							if(leave.getStatus().equalsIgnoreCase("Approved"))
							{
								Calendar l_start = Calendar.getInstance();
								l_start.setTime(leave.getFromDate());
								l_start.set(Calendar.HOUR_OF_DAY, 0);
								l_start.set(Calendar.MINUTE, 0);
								l_start.set(Calendar.SECOND, 0);
								
								Calendar l_end = Calendar.getInstance();
								l_end.setTime(leave.getToDate());
								l_end.set(Calendar.HOUR_OF_DAY, 23);
								l_end.set(Calendar.MINUTE, 59);
								l_end.set(Calendar.SECOND, 59);
								
								while(l_start.before(l_end))
								{
									totalLeaves++;
									l_start.add(Calendar.DATE, 1);
								}
							}
						}
					}
					
					
					
					System.out.println( "===============================");
					while(scal.before(ecal))
					{
						System.out.println( " >>>>>>>>>>> " + scal.getTime());
						List<Attendance> attList = attendanceService.getAttendance(reg.getUserid(), scal.getTime());
						if(attList != null && !attList.isEmpty() )
						{
							
							for(Attendance at : attList)
							{
								System.out.println( " $$$$$$$$$$$$" + at.getInTime());
							}
							Attendance at = attList.get(0);
							cell1 = row.createCell(cellCount++);
							if(scal.get(Calendar.DAY_OF_WEEK) == reg.getWeekOff())
							{
								totalAbsents--;
								cell1.setCellStyle(woStyle);
							}
							cell1.setCellValue(DateFormats.timeformat().format(at.getInTime()));
							
							cell1 = row.createCell(cellCount++);
							if(scal.get(Calendar.DAY_OF_WEEK) == reg.getWeekOff())
							{
								cell1.setCellStyle(woStyle);
							}
							if(at.getOutTime() != null)
							{
								cell1.setCellValue(DateFormats.timeformat().format(at.getOutTime()));
							}
							else
							{
								cell1.setCellValue("NA");
							}
							cell1 = row.createCell(cellCount++);
							if(scal.get(Calendar.DAY_OF_WEEK) == reg.getWeekOff())
							{
								cell1.setCellStyle(woStyle);
							}
							cell1.setCellValue(DateFormats.getWorkingHours(attList));
						}
						else if(scal.get(Calendar.DAY_OF_WEEK) == reg.getWeekOff())
						{
							totalWeekOffs++;
							System.out.println( " $$$$$$$$$$$$ : Week Off" );
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(woStyle);
							cell1.setCellValue("Week Off");
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(woStyle);
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(woStyle);
							sheet.addMergedRegion(new CellRangeAddress(rowCount-1, rowCount-1, cellCount-3, cellCount-1));
						}
						else
						{
							totalAbsents++;
							System.out.println( " $$$$$$$$$$$$ : Absent" );
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(style2);
							cell1.setCellValue("Absent");
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(style2);
							cell1 = row.createCell(cellCount++);
							cell1.setCellStyle(style2);
							
							sheet.addMergedRegion(new CellRangeAddress(rowCount-1, rowCount-1, cellCount-3, cellCount-1));
						}
						scal.add(Calendar.DATE, 1);
					}
					
					cell1 = row.getCell(3);
					cell1.setCellValue(totalLeaves);
					cell1 = row.getCell(4);
					cell1.setCellValue(totalAbsents);
					cell1 = row.getCell(5);
					cell1.setCellValue(totalWeekOffs);
					
				}
				
			}
			
			
			XSSFRow headRow = sheet.getRow(headerRow);
	        int i = headRow.getLastCellNum();
	        System.out.println("last cell : " + i);
			while (i>= 0)
	        { 
	        	sheet.autoSizeColumn(i--);
	        }
			
			
		
		String filename = "attendance_report.xlsx";
		
		FileOutputStream out;
		try 
		{
			File file = File.createTempFile("attendance_report", ".xlsx");
			out = new FileOutputStream(file);
			workbook.write(out);
			out.close();
			System.out.println("Writesheet.xlsx written successfully");
			
			try 
			{
				InputStream inputStream = new FileInputStream(file);
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment; filename="+filename); 
				FileCopyUtils.copy(inputStream, response.getOutputStream());
				response.flushBuffer();
				inputStream.close();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return "redirect:secureReport";
	}
	
	
}
