package com.ems.service;

import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MailServiceImpl implements MailService
{
	@Autowired private JavaMailSender mailSender;
	
	
	public boolean sendMail(String to,String cc,String bcc, String subject, String content)
	{
		/*
		try
		{
			
			MimeMessage mimeMessage = mailSender.createMimeMessage();
		    MimeMessageHelper message=new MimeMessageHelper(mimeMessage, true);
		    message.setTo(InternetAddress.parse(to));
		    if(cc != null && cc.trim().length() > 0)
		    {
		    	message.setCc(InternetAddress.parse(cc));
		    }
		    if(bcc != null && bcc.trim().length() > 0)
		    {
		    	message.setBcc(InternetAddress.parse(bcc));
		    }

		    	
		    message.setSubject(subject);
		    mimeMessage.setContent(content, "text/html");
		    mailSender.send(mimeMessage);
		}
		catch(MessagingException me)
		{
			me.printStackTrace();
		}
		return false;
		*/
		return send_Mail(to, cc, bcc, subject, content);
	}
	
	
	public static boolean send_Mail(String to, String cc,String bcc,  String subject, String contant)
	{
		
		System.out.println("=============================================================================");
		
		System.out.println("to : " + to + " , cc : " + cc +" bcc : " + bcc + " subject : " + subject + " , content : " + contant);
		System.out.println("=============================================================================");
		
		
		Properties props = System.getProperties();
	    props.put("mail.smtp.starttls.enable", true); // added this line
	    props.put("mail.smtp.host", "smtp.gmail.com");
	    props.put("mail.smtp.user", "autoreply@vasonomics.com");
	    props.put("mail.smtp.password", "A@v@sonom!cs");
	    props.put("mail.smtp.port", "587");
	    props.put("mail.smtp.auth", true);

	    
	    Session session = Session.getInstance(props,null);
	    MimeMessage message = new MimeMessage(session);
//	    Date date = Data.dateFormat1.parse("09-06-2016");

	    // Create the email addresses involved
	    try 
	    {
	        InternetAddress from = new InternetAddress("autoreply@vasonomics.com");
	        message.setSubject(subject);
	        message.setFrom(from);
	        message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	        if(cc != null && cc.trim().length() > 0)
		    {
	        	message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(cc)); 
		    }
		    if(bcc != null && bcc.trim().length() > 0)
		    {
		    	message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc)); 
		    }
	        // Create a multi-part to combine the parts
	        Multipart multipart = new MimeMultipart("alternative");

	        // Create your text message part
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        
	        messageBodyPart.setContent(contant, "text/html");
	        multipart.addBodyPart(messageBodyPart);

	        
	        
	        // Associate multi-part with message
	        message.setContent(multipart);

	        System.out.println("mail sending..............");
	        Transport transport = session.getTransport("smtp");
	        transport.connect("smtp.gmail.com", "autoreply@vasonomics.com", "A@v@sonom!cs");
	        transport.sendMessage(message, message.getAllRecipients());
	        System.out.println("mail send");
	        return true;

	    } catch (AddressException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    } catch (MessagingException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }catch (Exception e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	    
	    
	    return false;
	}
	
	
}