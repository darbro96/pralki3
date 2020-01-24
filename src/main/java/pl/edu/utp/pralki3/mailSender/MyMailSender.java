package pl.edu.utp.pralki3.mailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class MyMailSender {
    @Autowired
    private JavaMailSender javaMailSender;

    public void send(String to, String subject, String content) {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setTo(to);
            helper.setFrom("noreply@utp.edu.pl");
            helper.setSubject(subject);
            helper.setText(content, true);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
        javaMailSender.send(mimeMessage);
    }
}
