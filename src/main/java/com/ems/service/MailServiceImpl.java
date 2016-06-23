package com.ems.service;

import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
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
	
	
	public boolean sendMail(String to,String cc,String bcc, String subject, String contant)
	{

		System.out.println("=============================================================================");
		
		System.out.println("to : " + to + " , cc : " + cc +" bcc : " + bcc + " subject : " + subject + " , content : " + contant);
		System.out.println("=============================================================================");
		
		final String user = "autoreply@vasonomics.com";
        final String pass = "A@v@sonom!cs";
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "25");

        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(user, pass);
                    }
                });

        try 
        {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress("amarlalbharti@gmail.com"));
           /* if(cc != null && cc.trim().length() > 0)
            {
            	message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
            }
            if(bcc != null && bcc.trim().length() > 0)
            {
            	message.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc));
            }*/
//            message.setSubject(subject);

            message.setSubject("test subject ");
            
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent("This is text context", "text/html");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);


            message.setContent(multipart);

            Transport.send(message);
            return true;
        }
        catch (MessagingException e) {
             e.printStackTrace();
            //throw new RuntimeException(e);  
        }
        return false;

	}
	
	
	
}