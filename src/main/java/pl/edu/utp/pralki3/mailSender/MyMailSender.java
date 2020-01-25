package pl.edu.utp.pralki3.mailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.logging.Logger;

@Service
public class MyMailSender {
    @Autowired
    private JavaMailSender javaMailSender;

    private final Logger LOGGER = Logger.getLogger(this.getClass().getName());

    public void send(String to, String subject, String content) {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setTo(to);
            helper.setFrom("noreply@utp.edu.pl");
            helper.setSubject(subject);
            helper.setText(content, true);
        } catch (MessagingException ex) {
            LOGGER.info("Błąd podczas generowaie e-mail!");
        }
        javaMailSender.send(mimeMessage);
    }
}
